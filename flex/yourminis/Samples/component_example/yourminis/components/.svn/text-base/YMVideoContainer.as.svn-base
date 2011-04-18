package yourminis.components {
	
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.filters.*;
	import flash.geom.*;
	
	import yourminis.components.YMControls;
	import yourminis.components.YMVideoPlayer;
	import yourminis.events.YMCustomEvent;
	
	public class YMVideoContainer extends Sprite {
		
		public var myvideo:YMVideoPlayer;
		
		
		public var vidArray:Array;
		public var wasPlaying:Boolean;
		public var videoLoaded:Boolean;
		public var showStart:Boolean;
		public var firstTime:Boolean;
		public var changeVol:Boolean;
		public var alignment:uint;
		public var con:YMControls;
		public var loopPlaylist:Boolean = false;
		public var themeColor:uint;
		public var aspectRatio:Number=0;
		public var cornerRadius:int=0;
		public var bg:Sprite;
		public var bigPlay:Sprite;
		
		private var notdragging:Boolean;
		private var targetAlpha:Number;
		private var targetAlpha2:Number;
		private var playerW:Number;
		private var playerH:Number;
		private var maxwidth = 400;
		private var widget;
		
		public function YMVideoContainer(_widget=null,
										 _themeColor:uint=0xAADE0E,
										 _showStart:Boolean=false,
										 _alignment=2,
										 _playerW=160,
										 _playerH=120,
										 _padding=3,
										 _glass:Sprite=null,
										 _play_btn:Sprite=null,
										 _volume_btn:Sprite=null,
										 _fullscreen_btn:Sprite=null,
										 _index_btn:YMIndexSelector=null,
										 _progress_bar:YMSlideControl=null,
										 _volume_bar:YMSlideControl=null,
										 _elapsed_txt:TextField=null,
										 _total_txt:TextField=null,
										 _play_txt:TextField=null
										) {
			widget = _widget;
			themeColor = _themeColor;
			playerW = _playerW;
			playerH = _playerH;
			alignment = _alignment;
			bg = new Sprite();
			myvideo = new YMVideoPlayer(playerW,playerH,_widget)
			vidArray = new Array();
			wasPlaying = false;
			videoLoaded = false;
			firstTime = false;
			targetAlpha = 0;
			targetAlpha2 = 0;
			showStart = _showStart;
			
			bigPlay = new Sprite();
			drawBigPlay(0xFFFFFF);
			bigPlay.addEventListener(MouseEvent.ROLL_OVER, bpOver);
			bigPlay.addEventListener(MouseEvent.ROLL_OUT, bpOut);
			bigPlay.addEventListener(MouseEvent.CLICK, bpClick);
			bigPlay.buttonMode = true;
			
			con = new YMControls(		_widget,
										_themeColor,
										Math.min(maxwidth,_playerW),
								   		_playerH,
										_padding,
										_glass,
										_play_btn,
										_volume_btn,
										_fullscreen_btn,
										_index_btn,
										_progress_bar,
										_volume_bar,
										_elapsed_txt,
										_total_txt,
										_play_txt
									);
			
			addEventListener(Event.ENTER_FRAME, mainLoop);
			myvideo.addEventListener("NetStream.Play.Stop",onComplete);
			myvideo.addEventListener("NetStream.Buffer.Full",onBuffered);
			myvideo.addEventListener("NetStream.Buffer.Empty",onBuffering);
			myvideo.addEventListener("metaDataLoaded",onMetaDataLoaded);
			
			notdragging=true;
			
			myvideo.addEventListener(MouseEvent.ROLL_OVER, onOver);
			myvideo.addEventListener(MouseEvent.ROLL_OUT, onOut);
			con.progress_bar.addEventListener(con.progress_bar.SLIDE_DOWN,startSeek);
			con.progress_bar.addEventListener(con.progress_bar.SLIDE_UP,endSeek);
			con.volume_bar.addEventListener(con.volume_bar.SLIDE_DOWN,startVolume);
			con.volume_bar.addEventListener(con.volume_bar.SLIDE_UP,endVolume);
			con.addEventListener(MouseEvent.ROLL_OVER, onOver);
			con.addEventListener(MouseEvent.ROLL_OUT, onOut);
			con.addEventListener("play-click", playVid);
			con.addEventListener("change-index", changeIndex);
			con.addEventListener("mute-sound", toggleMute);
			con.addEventListener("player-close", playerClose);
			//con.next_btn.addEventListener(MouseEvent.CLICK, nextVid);
			//con.prev_btn.addEventListener(MouseEvent.CLICK, prevVid);
			addChild(bg);
			addChild(myvideo);
			addChild(con);
			addChild(bigPlay)
			setSize(playerW,playerH);
		}
		
		
		public function bpOver(evt:MouseEvent) {
			drawBigPlay(themeColor);
			targetAlpha2 = 1;
		}
		public function bpOut(evt:MouseEvent) {
			drawBigPlay(0xFFFFFF);
			targetAlpha2 = 0;
		}
		public function bpClick(evt:MouseEvent) {
			showStart = false;
			wasPlaying = true;
			myvideo.playVideo();
		}
		
		public function drawBigPlay(col) {
			with (bigPlay.graphics) {
				clear();
				beginFill(0,.7);
				lineStyle(3,col,1,true);
				drawCircle(30,30,30)
				endFill();
				
				beginFill(col);
				lineStyle(0,0,0);
				moveTo(22,10);
				lineTo(22,50);
				lineTo(46,30);
				lineTo(22,10);
				endFill();
			}
		}
		
		public function loadNext() {
			myvideo.loadVideo(vidArray[con.index_btn.index],"",showStart);
			wasPlaying = !showStart;
			con.setState(1);
		}
		public function onComplete(evt:Event) {
			if (myvideo.time/myvideo.metaData.duration > .9) {
				dispatchEvent(new Event("video-finished"));
				if (con.index_btn.total != 1)
				{
					videoLoaded = false;
					con.index_btn.increment(false)
					loadNext();
				}
			}
		}
		public function setIndex(param) {
			con.index_btn.index = param;
			loadNext();
		}
		public function changeIndex(evt:YMCustomEvent) {
			con.setState(1);
			loadNext();
		}
		public function playerClose(evt:Event){dispatchEvent(new Event("player-close"));}
		public function toggleMute(evt:Event) {
			myvideo.setVolume(con.volume_bar.percentPlayed)
			con.redrawAll();
		}
		
		public function startSeek(evt:Event) {
			notdragging = false;
		}
		public function endSeek(evt:Event) {
			notdragging = true;
		}
		public function startVolume(evt:Event) {
			changeVol = true;
		}
		public function endVolume(evt:Event) {
			changeVol = false;
		}
		
		
		public function setVideos(arr:Array) {
			wasPlaying = false;//!showStart;
			vidArray = arr;
			con.index_btn.total = arr.length;
			con.redrawAll();
		}
		
		public override function set visible(value:Boolean):void {
			if (wasPlaying) {
				if (value) myvideo.playVideo();
				else myvideo.pauseVideo();
			}
			else {
				if (value) loadNext();
			}
			super.visible = value;
		}
		
		
		public function setSize(w,h) {
			playerW = w;
			playerH = h;
			var aspectH:Number;
			var aspectW:Number;
			if (aspectRatio)
			{
				if (h*aspectRatio>w)
				{
					aspectW = w;
					aspectH = Math.round(w/aspectRatio);
				}
				else
				{
					aspectH = h;
					aspectW = Math.round(aspectRatio*h);
				}
				myvideo.setSize(aspectW,aspectH);
				myvideo.x = Math.round((w-aspectW)/2);
				myvideo.y = Math.round((h-aspectH)/2);
			}
			else myvideo.setSize(w,h);
			con.setSize(Math.min(maxwidth,w-10),40);
			
			bigPlay.x = (w-bigPlay.width)/2;
			bigPlay.y = (h-bigPlay.height)/2;
			bg.graphics.clear();
			bg.graphics.beginFill(0);
			bg.graphics.drawRoundRect(0,0,w,h,cornerRadius);
			bg.graphics.endFill();
			
			var xalign = (alignment)%3;
			var yalign = Math.floor((alignment-1)/3);
			
			switch (xalign) {
				case 0:
					con.x = playerW-con.width-4;
				break;
				case 1:
					con.x = 4;
				break;
				case 2:
					con.x = (playerW-con.width)/2;
				break;
			}
			
			switch (yalign) {
				case 0:
					con.y = playerH-con.height-4;
				break;
				case 1:
					con.y = (playerH-con.height)/2;
				break;
				case 2:
					con.y = 4;
				break;
			}
			
			
			
		}
		
		function mainLoop(evt:Event) {	
			con.alpha += (targetAlpha-con.alpha)/4;
			//bigPlay.alpha += ((targetAlpha|targetAlpha2)*.8-bigPlay.alpha)/4;
			
			if (videoLoaded) {
				if (notdragging) {
					con.setLoaded(myvideo.bytesLoaded,myvideo.bytesTotal);
					con.setPlayed(myvideo.time,myvideo.metaData.duration);
				}
				else {
					myvideo.seek(con.progress_bar.percentPlayed)
				}
				if (changeVol) {
					con.redrawAll();
					myvideo.setVolume(con.volume_bar.percentPlayed) 
				}
			}
			
			con.visible = !showStart;
			bigPlay.visible = showStart&&(!myvideo.loading);
			
			
			//con.visible = (con.alpha > 0)
			con.index_btn.visible = (vidArray.length > 1);//(con.alpha > .5)&&
			con.elapsed_txt.visible=(con.alpha > .8);
			con.total_txt.visible=(con.alpha > .8);
			con.p_btn.visible=(con.alpha > .8)
			con.fullscreen_btn.visible = widget.allowFullScreen;
		}
		
		function onOver(evt:MouseEvent) {
			targetAlpha = 1;
			con.redrawAll();
		}
		function onOut(evt:MouseEvent) {
			targetAlpha = 0;
			con.redrawAll();
		}
		function playVid(evt:Event) {
			if (con.currentState==1) {
				myvideo.playVideo();
				wasPlaying = true;
			}
			else {
				myvideo.pauseVideo();
				wasPlaying = false;
			}
		}
		function onBuffered(evt:Event) {
			
		}
		function onBuffering(evt:Event) {
			
		}
		function onMetaDataLoaded(evt:Event) {
			if (firstTime) {
				firstTime = false;
				con.setState(1);
			}
			videoLoaded = true;
		}
		
		public function set closeEnabled(val:Boolean):void{con.close_btn.visible = val;}
		
	}
}