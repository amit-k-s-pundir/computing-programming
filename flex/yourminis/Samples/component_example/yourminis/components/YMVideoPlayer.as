package yourminis.components
 {
	import yourminis.utils.LoadingIndicator;
	import flash.net.ObjectEncoding;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;
	import flash.text.TextField;
	import flash.media.SoundTransform;

    public class YMVideoPlayer extends Sprite 
	{
        private var _loadingIndicator:LoadingIndicator;
		private var connection:NetConnection;
        private var netClient:Object;
		public var stream:NetStream;
		private var videoURL:String;
		public var video:Video;
		public var debugMode:Boolean=false;
		public var videoMask:Sprite;
		public var metaData:Object;
		private var txtbox:TextField;
		private var rtmp:String="";
		private var widget:Sprite;
		private var firstFrame:Boolean;
		private var muted:SoundTransform;
		private var curST:SoundTransform;
		private var muteCount;
		private var allowLoading:Boolean;
		
        public function YMVideoPlayer(vwidth:Number,vheight:Number, _widget:Sprite=null,al:Boolean=true) 
		{
			allowLoading = al;
			muteCount = 0;
			firstFrame = true;
			muted = new SoundTransform();
			muted.volume = 0;
			curST = new SoundTransform();
			curST.volume = 1;
			videoURL = "";
			widget = _widget;
			//mouseEnabled = false;
			metaData = new Object();
			NetConnection.defaultObjectEncoding = ObjectEncoding.AMF0;
			connection = new NetConnection();
            connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			video = new Video(vwidth,vheight);
			_loadingIndicator = new LoadingIndicator();
			_loadingIndicator.loading = false;
			setSize(vwidth,vheight)
			videoMask = new Sprite();
			addChild(video);
			addChild(videoMask);
			addChild(_loadingIndicator);
			if (debugMode)
			{
				txtbox = new TextField();
				txtbox.width = 200;
				txtbox.autoSize = "left"
				txtbox.background = true;
				txtbox.wordWrap = true;
				addChild(txtbox);
			}
        }
		
		public function unload(evt:Event=null):void
		{
			if (stream) stream.close();
			if (connection) connection.close();
		}
		public function seek(percent:Number):void
		{
			stream.seek(percent*metaData.duration);
		}
		public function setSize(w:int,h:int):void
		{
			video.width = w;
			video.height = h;
			_loadingIndicator.x = (w-_loadingIndicator.width)/2;
			_loadingIndicator.y = (h-_loadingIndicator.height)/2;
		}
		public function loadVideo(url:String,videoStr:String="",_firstFrame:Boolean=false):void
		{
			//unload();
			video.clear();
			firstFrame = _firstFrame;
			if (!widget) widget = this["parent"].widget;
			if (widget) widget.addEventListener("widget-closing",unload);
			_loadingIndicator.loading = allowLoading;
			if (videoURL != "" && stream != null) stream.close();
			videoURL = url;
			rtmp = videoStr;
			if (rtmp != "") connection.connect(videoURL);
			else connection.connect(null);
			
			
		}
		public function setMask(doSetMask:Boolean=true):void
		{
			if (doSetMask) video.mask = videoMask;
			else video.mask = null;
		}
		public function drawMask(sx:Number,sy:Number,w:Number,h:Number,cr:Number):void
		{
			videoMask.graphics.clear();
			videoMask.graphics.beginFill(0,1);
			videoMask.graphics.drawRoundRect(sx,sy,w,h,cr*2);
			videoMask.graphics.endFill();
			setMask();
		}
        private function netStatusHandler(event:NetStatusEvent):void {
			catchError(event.info.code);
			if (stream != null) {
				if (firstFrame)	stream.soundTransform = muted;
				else stream.soundTransform = curST;
			}
			
			switch (event.info.code) 
			{
                case "NetStream.Play.Start":
					break;
				case "NetConnection.Connect.Success":
                    connectStream();
                    break;
				case "NetStream.Buffer.Full":
                    _loadingIndicator.loading = false;
					
                    break;
                default:
					break;
            }
			
			dispatchEvent(new Event(event.info.code));
        }
		
		public function pauseVideo() {
			stream.pause();
		}
		
		public function setVolume(param) {
			curST.volume = param;
			stream.soundTransform = curST;
		}
		
		public function playVideo() {
			if (firstFrame) {
				stream.seek(0);
				firstFrame = false;
			}
			stream.resume();
		}
		public function stopVideo() {
			stream.close();
		}

        private function connectStream():void {
            stream = new NetStream(connection);
			stream.bufferTime = 3;
            stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			video.attachNetStream(stream);
            var streamVideo:String = videoURL;
			if (rtmp != "") streamVideo = rtmp;
			
			stream.play(streamVideo);
			
			netClient = new Object()
			netClient.onMetaData = function(meta:Object){
				metaData = meta;
				
				if (firstFrame) {
					stream.pause();
					stream.seek(1);
					_loadingIndicator.loading = false;
				}
				
				dispatchEvent(new Event("metaDataLoaded"));
			}
			
			stream.client = netClient;
        }
		private function toMinuteString(seconds):String
		{
			var minutes:int = Math.floor(seconds/60);
			var seconds:int = seconds % 60;
			var minutePrefix:String = "";
			var secondPrefix:String = "";
			if (minutes < 10) minutePrefix = "0";
			if (seconds < 10) secondPrefix = "0";
			return minutePrefix+minutes+":"+secondPrefix+seconds;
		}
		
		public function get time():Number {
			return stream.time;
		}
		public function get elapsed():String
		{
			if (stream) return toMinuteString(stream.time);
			else return "00:00";
		}
		public function get duration():String
		{
			if (stream && metaData) return toMinuteString(metaData.duration);
			else return "00:00";
		}
		public function get bytesLoaded():uint {
			return stream.bytesLoaded;
		}
		public function get bytesTotal():uint {
			return stream.bytesTotal;
		}
		public function get percentLoaded():Number
		{
			if (stream) return stream.bytesLoaded / stream.bytesTotal;
			else return 0;
		}
		public function get percentPlayed():Number
		{
			if (stream && metaData.duration) return stream.time/metaData.duration;
			else return 0;
		}
		public function get loading():Boolean{return _loadingIndicator.loading;}
		public function set loading(val:Boolean):void{_loadingIndicator.loading = val&&allowLoading;}
		
        private function securityErrorHandler(event:SecurityErrorEvent):void {
            catchError(event.toString());
        }
        
        private function asyncErrorHandler(event:AsyncErrorEvent):void {
            catchError(event.error.message);
        }
		private function catchError(e:String)
		{
			if (debugMode)
			{
				txtbox.appendText(e + "\n");
			}
		}
    }
 }