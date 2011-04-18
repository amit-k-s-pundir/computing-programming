package yourminis.components {
	
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.utils.Timer;
	
	import yourminis.components.YMControls;
	import yourminis.components.YMAudioPlayer;
	import yourminis.events.YMCustomEvent;
	import yourminis.utils.TextFitField;
	
	public class YMAudioContainer extends Sprite {
		
		public var audio:YMAudioPlayer;
		
		public var titleArray:Array;
		public var audioArray:Array;
		public var wasPlaying:Boolean;
		public var audioLoaded:Boolean;
		public var showStart:Boolean;
		public var firstTime:Boolean;
		public var changeVol:Boolean;
		public var con:YMControls;
		public var loopPlaylist:Boolean = false;
		public var themeColor:uint;
		
		private var title_txt:TextFitField;
		private var notdragging:Boolean;
		private var playerW:Number;
		private var playerH:Number;
		private var widget;
		private var padding=0;
		private var timer:Timer;
		
		public function YMAudioContainer(_widget=null,
										 _themeColor:uint=0xAADE0E,
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
			playerW = 240;
			playerH = 60;
			audio = new YMAudioPlayer(_widget)
			audioArray = new Array();
			wasPlaying = false;
			audioLoaded = false;
			firstTime = false;
			


			
			con = new YMControls(		_widget,
										_themeColor,
										playerW,
								   		playerH,
										4,
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
			notdragging=true;			
			con.progress_bar.addEventListener(con.progress_bar.SLIDE_DOWN,startSeek);
			con.progress_bar.addEventListener(con.progress_bar.SLIDE_UP,endSeek);
			con.volume_bar.addEventListener(con.volume_bar.SLIDE_DOWN,startVolume);
			con.volume_bar.addEventListener(con.volume_bar.SLIDE_UP,endVolume);
			con.addEventListener("play-click", playAudio);
			con.addEventListener("change-index", changeIndex);
			con.addEventListener("mute-sound", toggleMute);
			con.addEventListener("player-close", playerClose);
			
			title_txt = new TextFitField();
			title_txt.x = 4;
			title_txt.y = 30;
			
			addChild(audio);
			addChild(con);
			addChild(title_txt);
			con.setState(0);
			setSize(playerW,60);
			timer = new Timer(100,1);
			timer.addEventListener("timer",onTimer);
			timer.start();
		}
		private function onTimer(evt:Event):void{setSize(playerW,playerH);}
			
		public function loadNext() {
			audio.loadAudio(audioArray[con.index_btn.index]);
			wasPlaying = !showStart;
			con.setState(1);
		}
		public function onComplete(evt:Event) {
			dispatchEvent(new Event("audio-finished"));
			if (con.index_btn.total != 1)
			{
				audioLoaded = false;
				con.index_btn.increment(false);
				loadNext();
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
			audio.setVolume(con.volume_bar.percentPlayed)
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
		
		
		public function setTitles(arr:Array):void
		{
			titleArray = arr;
			title_txt.text = (titleArray[con.index_btn.index]);
		}
		public function setTracks(arr:Array) {
			wasPlaying = true;//!showStart;
			audioArray = titleArray = arr;
			con.index_btn.total = arr.length;
			title_txt.text = (titleArray[con.index_btn.index]);
		}
		
		public override function set visible(value:Boolean):void {
			if (wasPlaying) {
				if (value) 
				{
					if (audio.currentTrack) audio.playAudio();
					else audio.loadAudio(audioArray[con.index_btn.index]);
					con.setState(1);
				}
				else 
				{
					audio.pauseAudio();
					con.setState(0);
				}
			}
			else {
				if (value) loadNext();
			}
			super.visible = value;
		}
		
		
		public function setSize(w,h) {
			playerW = w;
			playerH = 70;
			con.setSize(w,70);
			title_txt.width = playerW - 10;
			//con.redrawAll();
			
			//con.x = con.y = padding;
				
			
			
		}
		
		function mainLoop(evt:Event) {	
			if (audio.currentTrack) {
				if (notdragging) {
					con.setLoaded(audio.currentTrack.bytesLoaded,audio.currentTrack.bytesTotal);
					con.setPlayed(Math.round(audio.soundChannel.position/1000),Math.round(audio.currentTrack.length/1000));
				}
				else {
					audio.seek(con.progress_bar.percentPlayed)
				}
				if (changeVol) {
					con.redrawAll();
					audio.setVolume(con.volume_bar.percentPlayed) 
				}
				
			}
			
			
			
			
			con.index_btn.visible = (audioArray.length > 1);//(con.alpha > .5)&&
			con.elapsed_txt.visible=true
			con.total_txt.visible=true
			con.p_btn.visible=true
			con.fullscreen_btn.visible = false;
			con.close_btn.visible = false;
		}
		
		function playAudio(evt:Event) {
			if (con.currentState==1) {
				if (audio.currentTrack) audio.playAudio();
				else audio.loadAudio(audioArray[con.index_btn.index]);
				audio.soundChannel.addEventListener(Event.SOUND_COMPLETE,onComplete);
				wasPlaying = true;
			}
			else {
				audio.pauseAudio();
				wasPlaying = false;
			}
		}
		function onBuffered(evt:Event) {
			
		}
		function onBuffering(evt:Event) {
			
		}
		
		
	}
}