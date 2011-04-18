package yourminis.components {
	
	/*import yourminis.utils.LoadingIndicator;
	import flash.net.ObjectEncoding;
	import flash.display.Sprite;
	
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import flash.media.SoundTransform;
	*/
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.filters.*;
	import flash.geom.*;
	
	import yourminis.events.YMCustomEvent;
	import yourminis.components.YMSlideControl;
	import yourminis.components.YMIndexSelector;
	
	public class YMControls extends Sprite {
		
		public var playerW;
		public var playerH;
		public var padding;
		
		public var colArr:Array;
		public var themeColor:uint;
		public var glass:Sprite;
		public var play_btn:Sprite;
		public var volume_btn:Sprite;
		public var fullscreen_btn:Sprite;
		public var cover:Sprite;
		public var slideShine1:Sprite;
		public var slideShine2:Sprite;
		public var close_btn:Sprite;
		
		public var p_btn
		public var index_btn:YMIndexSelector;
		public var progress_bar:YMSlideControl;
		public var volume_bar:YMSlideControl;
		public var elapsed_txt:TextField;
		public var total_txt:TextField;
		public var play_txt:TextField;
		public var t_fmt:TextFormat;
		public var t_fmt2:TextFormat;
		public var oldVolume;
		public var mywidget;
		public var filterArr;
		
		public var currentState:uint;
		
		private var rectArr:Array;
		
		public function YMControls(		_widget,
										_themeColor:uint=0xAAC043,
										_playerW=160,
								   		_playerH=60,
										_padding=4,
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
										
									)
		{
			mywidget = _widget;
			themeColor = _themeColor;
			playerW = _playerW;
			playerH = 60;//_playerH;
			padding = _padding;
			colArr = new Array();
			colArr = [0xFFFFFF,0xFFFFFF,0xFFFFFF,0xFFFFFF];
			rectArr = new Array();
			rectArr = [
						[14,4,2,8],
						[18,2,2,12],
						[22,0,2,16]
					  ];
			
			if (_glass == null) glass = new Sprite();
			else glass = _glass;
			
			if (_play_btn == null) play_btn = new Sprite();
			else play_btn = _play_btn;
			
			if (_volume_btn == null) volume_btn = new Sprite();
			else volume_btn = _volume_btn;
			
			if (_fullscreen_btn == null) fullscreen_btn = new Sprite();
			else fullscreen_btn = _fullscreen_btn;
			
			if (_index_btn == null) index_btn = new YMIndexSelector(changeIndex,themeColor,0x333333,themeColor,false,10,"Verdana",0xFFFFFF);
			else index_btn = _index_btn;
			
			if (_progress_bar == null) progress_bar = new YMSlideControl(100,6,themeColor,0x999999,0x666666,3);
			else progress_bar = _progress_bar;
			
			if (_volume_bar == null) volume_bar = new YMSlideControl(100,6,themeColor,0x999999,0x666666,3);
			else volume_bar = _volume_bar;
			
			if (_elapsed_txt == null) elapsed_txt = new TextField();
			else elapsed_txt = _elapsed_txt;
			
			if (_total_txt == null) total_txt = new TextField();
			else total_txt = _total_txt;
			
			if (_play_txt == null) play_txt = new TextField();
			else play_txt = _play_txt;
			
			close_btn = new Sprite();
			slideShine1 = new Sprite();
			slideShine2 = new Sprite();
			
			p_btn = new Sprite();
			cover = new Sprite();
			index_btn.setSize(60);
			volume_bar.percentLoaded = 1;
			volume_bar.percentPlayed = 1;
			
			
			p_btn.addEventListener(MouseEvent.CLICK,toggleButton);
			p_btn.addEventListener(MouseEvent.MOUSE_OVER,mover);
			p_btn.addEventListener(MouseEvent.MOUSE_OUT,mout);
			
			volume_btn.addEventListener(MouseEvent.CLICK,mute);
			volume_btn.addEventListener(MouseEvent.MOUSE_OVER,mover2);
			volume_btn.addEventListener(MouseEvent.MOUSE_OUT,mout2);
			
			fullscreen_btn.addEventListener(MouseEvent.CLICK,fullscreen);
			fullscreen_btn.addEventListener(MouseEvent.MOUSE_OVER,mover3);
			fullscreen_btn.addEventListener(MouseEvent.MOUSE_OUT,mout3);
			
			close_btn.addEventListener(MouseEvent.CLICK,closeHandler);
			close_btn.addEventListener(MouseEvent.MOUSE_OVER,mover4);
			close_btn.addEventListener(MouseEvent.MOUSE_OUT,mout4);
			
			
			elapsed_txt.width=40;
			total_txt.width=40;
			play_txt.width=44;
			elapsed_txt.height=18;
			total_txt.height=18;
			play_txt.height=18;
			elapsed_txt.selectable = false;
			total_txt.selectable = false;
			play_txt.selectable = false;
			play_txt.multiline = false;
			elapsed_txt.multiline = false;
			total_txt.multiline = false;
			play_txt.mouseEnabled = false;
			elapsed_txt.mouseEnabled = false;
			total_txt.mouseEnabled = false;
			
			t_fmt = new TextFormat("Verdana",11,0xFFFFFF,false);
			t_fmt2 = new TextFormat("Verdana",10,0xFFFFFF,false);
			elapsed_txt.setTextFormat(t_fmt);
			total_txt.setTextFormat(t_fmt);
			play_txt.setTextFormat(t_fmt2);
			
			
			addChild(glass);
			p_btn.addChild(play_txt);
			p_btn.addChild(play_btn);
			p_btn.addChild(cover);
			addChild(p_btn);
			addChild(close_btn);
			addChild(volume_btn);
			addChild(fullscreen_btn);
			addChild(index_btn);
			addChild(progress_bar);
			addChild(volume_bar);
			addChild(elapsed_txt);
			addChild(total_txt);
			addChild(slideShine1);
			addChild(slideShine2);
			
			slideShine1.mouseEnabled = false;
			slideShine2.mouseEnabled = false;
			
			slideShine1.blendMode = BlendMode.HARDLIGHT;
			slideShine2.blendMode = BlendMode.HARDLIGHT;
			
			close_btn.buttonMode=true;
			p_btn.buttonMode=true;
			volume_btn.buttonMode=true;
			fullscreen_btn.buttonMode=true;
			progress_bar.buttonMode=true;
			volume_bar.buttonMode=true;
			filterArr = [new BevelFilter(2,45,0xFFFFFF,.3,0,.3,2,2,1),new DropShadowFilter(0,0,0,1,4,4)];
			
			glass.filters = [new BevelFilter(1,45,0xFFFFFF,.8,0,.8,2,2,1,1,BitmapFilterType.OUTER), new DropShadowFilter(1,90,0,1,4,4)];
			p_btn.filters = filterArr;
			volume_btn.filters = filterArr;
			fullscreen_btn.filters = filterArr;
			index_btn.filters = filterArr;
			progress_bar.filters = filterArr;
			volume_bar.filters = filterArr;
			elapsed_txt.filters = filterArr;
			total_txt.filters = filterArr;
			
			
			setState(1);
			
		}
		
		function mover(evt:MouseEvent) {
			colArr[0] = themeColor
			redrawAll();
		}
		function mout(evt:MouseEvent) {
			colArr[0] = 0xFFFFFF;
			redrawAll();
		}
		function mover2(evt:MouseEvent) {
			colArr[1] = themeColor
			redrawAll();
		}
		function mout2(evt:MouseEvent) {
			colArr[1] = 0xFFFFFF;
			redrawAll();
		}
		function mover3(evt:MouseEvent) {
			colArr[2] = themeColor
			redrawAll();
		}
		function mout3(evt:MouseEvent) {
			colArr[2] = 0xFFFFFF;
			redrawAll();
		}
		function mover4(evt:MouseEvent) {
			colArr[3] = themeColor
			redrawAll();
		}
		function mout4(evt:MouseEvent) {
			colArr[3] = 0xFFFFFF;
			redrawAll();
		}
		
		public function setState(param) {
			currentState=param;
			redrawAll();
		}
		function closeHandler(evt:MouseEvent):void{dispatchEvent(new Event("player-close"));}
		function mute(evt:MouseEvent) {
			if (volume_bar.percentPlayed == 0) {
				volume_bar.percentPlayed = oldVolume;
			}
			else {
				oldVolume = volume_bar.percentPlayed;
				volume_bar.percentPlayed = 0;
			}
			dispatchEvent(new Event("mute-sound"));
		}
		function fullscreen(evt:MouseEvent) {
			mywidget.displayFullScreen(evt);
		}
		function toggleButton(evt:MouseEvent) {
			switch (currentState) {
				case 0://paused
					setState(1);
				break;
				case 1://playing
					setState(0);
				break;
				case 2://start
					setState(1);
				break;
			}
			dispatchEvent(new Event("play-click"));
		}
		
		function setLoaded(bLoaded,bTotal) {
			progress_bar.percentLoaded = bLoaded/bTotal;
		}
		function setPlayed(tPlayed,tTotal) {
			progress_bar.percentPlayed = tPlayed/tTotal;
			var tarr:Array = [Math.floor(tPlayed/60), Math.floor(tPlayed)%60, Math.floor(tTotal/60), Math.floor(tTotal)%60];
			
			for (var i = 0; i < 4; i++) {
				if (String(tarr[i]).length < 2) tarr[i] = "0"+tarr[i];
			}
			
			elapsed_txt.text = tarr[0] + ":" + tarr[1];
			total_txt.text = tarr[2] + ":" + tarr[3];
			elapsed_txt.setTextFormat(t_fmt);
			total_txt.setTextFormat(t_fmt);
		}
		
		
		public function redrawAll() {
			var w = playerW - 2*padding;
			var h = playerH - 2*padding;
			var i;
			
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [0xAAAAAA,0xFFFFFF,0x666666,0,0];
			var alphas:Array = [.5, .3, .5, .3, .5];
			var ratios:Array = [0x00, 0x44, 0x88,0x99,0xFF];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(playerW, playerH, Math.PI/2, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
			
			with(glass.graphics) {
				clear();
				lineStyle(1,0xFFFFFF,.4,true);
				beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
				drawRoundRect(0,0,playerW,playerH,5);
				endFill();
			}
			
			with(close_btn.graphics)
			{
				clear();
				lineStyle(2,0xFFFFFF,1,true,"none");
				beginFill(colArr[3],int(colArr[3]!=0xFFFFFF));
				drawRoundRect(0,0,12,12,7);
				endFill();
				lineStyle(2,0xFFFFFF,1,true);
				moveTo(4,4);
				lineTo(8,8);
				moveTo(8,4)
				lineTo(4,8);
			}
			
			if (currentState==0) 
			{
				with(play_btn.graphics) {
					clear();
					lineStyle(3,colArr[0],1,true);
					beginFill(colArr[0],1);
					moveTo(0,0);
					lineTo(4,4);
					lineTo(0,8);
					lineTo(0,0);
					endFill();
				}
				play_txt.text = "PLAY";
				play_btn.x = 5;
				play_btn.y = 2;
				
				
			}
			if (currentState==1) {
				with(play_btn.graphics) {
					clear();
					beginFill(colArr[0],1);
					drawRoundRect(0,0,4,12,5);
					drawRoundRect(6,0,4,12,5);
					endFill();
				}
				play_txt.text = "PAUSE";
				play_btn.x = 0;
				play_btn.y = 0;
			}
			with(cover.graphics) {
				clear();
				beginFill(0xFF0000,0)
				drawRect(0,0,54,14);
				endFill();
			}
			with(volume_btn.graphics) {
				clear();
				beginFill(0xFF0000,0);
				drawRect(0,0,26,16);
				endFill();
				beginFill(colArr[1],1);
				moveTo(4,4);
				lineTo(4,12);
				lineTo(8,12);
				lineTo(12,16);
				lineTo(12,0);
				lineTo(8,4);
				lineTo(4,4);
				for (i = 0; i < Math.floor(3.5*volume_bar.percentPlayed); i++) {
					drawRect(rectArr[i][0],rectArr[i][1],rectArr[i][2],rectArr[i][3])
				}
				endFill();
			}
			volume_btn.scaleX = .6;
			volume_btn.scaleY = .6;
			
			
			
			with(fullscreen_btn.graphics) {
				clear();
				beginFill(0xFF0000,0);
				drawRect(0,0,16,16);
				endFill();
				beginFill(colArr[2],1);
				
				moveTo(0,0);
				lineTo(6,0);
				lineTo(4,2);
				lineTo(6,4);
				lineTo(4,6);
				lineTo(2,4);
				lineTo(0,6);
				lineTo(0,0);
				moveTo(16,0);
				lineTo(16,6);
				lineTo(14,4);
				lineTo(12,6);
				lineTo(10,4);
				lineTo(12,2);
				lineTo(10,0);
				lineTo(16,0);
				moveTo(16,16);
				lineTo(10,16);
				lineTo(12,14);
				lineTo(10,12);
				lineTo(12,10);
				lineTo(14,12);
				lineTo(16,10);
				lineTo(16,16);
				moveTo(0,16);
				lineTo(6,16);
				lineTo(4,14);
				lineTo(6,12);
				lineTo(4,10);
				lineTo(2,12);
				lineTo(0,10);
				lineTo(0,16);
				drawRect(6,6,4,4);
				
				endFill();
			}
			fullscreen_btn.scaleX = .6;
			fullscreen_btn.scaleY = .6;
			
			
			
			t_fmt2.color = colArr[0];
			play_txt.setTextFormat(t_fmt2);
			t_fmt2.color = 0xFFFFFF;
			play_txt.x = padding+10;
			play_txt.y = -2;
			
			elapsed_txt.x = padding;
			total_txt.x = playerW-padding-total_txt.width-close_btn.width*int(close_btn.visible);
			elapsed_txt.y = padding;
			total_txt.y = padding;
			progress_bar.y = padding+6;//Math.floor(elapsed_txt.height/2);
			progress_bar.width = playerW-padding*4-elapsed_txt.width-total_txt.width-close_btn.width*int(close_btn.visible);			
			progress_bar.x = padding*2+elapsed_txt.width;
			
			var ibmod = (index_btn.width+padding)*Number(index_btn.visible);
			var fsb = fullscreen_btn.width*Number(fullscreen_btn.visible);
			
			index_btn.x = playerW-padding*2-index_btn.width - fsb + 4;
			index_btn.y = playerH-index_btn.height;
			close_btn.y = 6;
			close_btn.x = playerW-17;
			
			p_btn.x = padding+3;
			p_btn.y = playerH+2-p_btn.height;
			
			fullscreen_btn.x = playerW-padding-fullscreen_btn.width-3;
			fullscreen_btn.y = playerH-padding-fullscreen_btn.height-2;
			
			
			volume_bar.y = playerH-padding-volume_bar.height-3;
			var sa = playerW - padding*5 - fsb - volume_btn.width - p_btn.width-ibmod;
			volume_bar.width = Math.min(sa,50);
			
			volume_bar.x = p_btn.x + p_btn.width + ((playerW-padding*3-fsb-p_btn.width-ibmod)-(volume_bar.width+padding+volume_btn.width))/2;//p_btn.x + p_btn.width + (volume_bar.width + p_btn.width + padding*2)/2;
			
			
			volume_btn.x = volume_bar.x + volume_bar.width + padding;
			volume_btn.y = playerH-padding-volume_btn.height-2;
			
			colors = [0xFFFFFF,0xFFFFFF,0xFFFFFF,0xFFFFFF];
			alphas = [.5, .8, 0, 0];
			ratios = [0x00, 0x77, 0x78, 0xFF];
			matr.createGradientBox(progress_bar.width, progress_bar.height, Math.PI/2, 0, 0);
			
			with(slideShine1.graphics) {
				clear();
				beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
				drawRoundRect(0,0,progress_bar.width,progress_bar.height,3);
				endFill();
			}
			matr.createGradientBox(volume_bar.width, volume_bar.height, Math.PI/2, 0, 0);
			with(slideShine2.graphics) {
				clear();
				beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
				drawRoundRect(0,0,volume_bar.width,volume_bar.height,3);
				endFill();
			}
			
			slideShine1.x = progress_bar.x;
			slideShine1.y = progress_bar.y;
			slideShine2.x = volume_bar.x;
			slideShine2.y = volume_bar.y;
			
			
			
			
		}
		
		public function setSize(w,h) {
			playerW = w;
			playerH = h;
			redrawAll();
		}
		
		public function changeIndex(ind) {
			dispatchEvent(new YMCustomEvent("change-index",ind));
		}
	}
}