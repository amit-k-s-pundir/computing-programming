package yourminis.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.MouseEvent;
	
	public class YMSlideControl extends Sprite
	{
		private var _playedPercent:Number = 0;
		private var _loadedPercent:Number = 0;
		private var _width:Number;
		private var _height:Number;
		private var slide:Sprite;
		public var base:Sprite;
		private var loadbar:Sprite;
		public var slideColor:uint;
		public var loadColor:uint;
		public var baseColor:uint;
		public var mouseIsDown:Boolean = false;
		public var cornerRadius;
		public var slideAlpha:Number=1;
		public var loadAlpha:Number=1;
		public var baseAlpha:Number=1;
		
		public const SLIDE_MOVE:String = "slide-moved";
		public const SLIDE_DOWN:String = "slide-down";
		public const SLIDE_UP:String = "slide-up";
		
		public function YMSlideControl(_initWidth:Number=100,_initHeight=4,_slideColor:uint=0x00CCFF,_loadColor:uint=0x999999,_baseColor:uint=0x666666, _cornerRadius=0)
		{
			_width = _initWidth;
			_height = _initHeight;
			cornerRadius = _cornerRadius;
			slideColor = _slideColor;
			loadColor = _loadColor;
			baseColor = _baseColor
			base = new Sprite();
			slide = new Sprite();
			
			loadbar = new Sprite();
			drawTrack(base,baseColor,baseAlpha,1);
			addChild(base);
			addChild(loadbar);
			addChild(slide);
			
			addEventListener(MouseEvent.MOUSE_DOWN,onMDown,false,0,false);
			//addEventListener(MouseEvent.MOUSE_UP,onMUp);
			//addEventListener(MouseEvent.MOUSE_MOVE,onMMove);
			//slider.addEventListener(MouseEvent.MOUSE_DOWN,onMDown);
		}
		private function onMDown(evt:MouseEvent)
		{
			evt.stopImmediatePropagation();
			mouseIsDown = true;
			var newPercent:Number = (mouseX/_width);
			newPercent = Math.max(newPercent,0);
			newPercent = Math.min(newPercent,_loadedPercent);
			percentPlayed = newPercent;
			stage.addEventListener(MouseEvent.MOUSE_UP, onMUp,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMMove,false,0,true);
			dispatchEvent(new Event(SLIDE_DOWN));
		}
		private function onMUp(evt:MouseEvent)
		{
			mouseIsDown = false;
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMMove);
			var newPercent:Number = (mouseX/_width);
			newPercent = Math.max(newPercent,0);
			newPercent = Math.min(newPercent,_loadedPercent);
			percentPlayed = newPercent;
			dispatchEvent(new Event(SLIDE_UP));
		}
		private function onMMove(evt:MouseEvent)
		{
			var newPercent:Number = (mouseX/_width);
			newPercent = Math.max(newPercent,0);
			newPercent = Math.min(newPercent,_loadedPercent);
			if (mouseIsDown) {
				percentPlayed = newPercent;
				dispatchEvent(new Event(SLIDE_MOVE));
			}
		}
		private function drawTrack(mc:Sprite,color:uint,salpha:Number,percent:Number=1):void
		{
			mc.graphics.clear();
			if (percent>0)
			{
				mc.graphics.lineStyle(0,0,0);
				mc.graphics.beginFill(color,salpha);
				mc.graphics.drawRoundRect(0,0,_width*percent,_height,cornerRadius);
				mc.graphics.endFill();
			}
		}
		private function redrawAll()
		{
			drawTrack(loadbar,loadColor,loadAlpha,_loadedPercent);
			drawTrack(slide,slideColor,slideAlpha,_playedPercent);
			drawTrack(base,baseColor,baseAlpha,1);
		}
		override public function get width():Number{return _width;}
		override public function set width(_newWidth:Number):void{_width=_newWidth;redrawAll()}
		override public function get height():Number{return _height;}
		override public function set height(_newHeight:Number):void{_height=_newHeight; redrawAll()}
		public function get percentPlayed():Number{return _playedPercent;}
		public function set percentPlayed(_newPercent:Number):void{_playedPercent = _newPercent; drawTrack(slide,slideColor,slideAlpha,_newPercent);}
		public function get percentLoaded():Number{return _loadedPercent;}
		public function set percentLoaded(_newPercent:Number):void{_loadedPercent = _newPercent; drawTrack(loadbar,loadColor,loadAlpha,_newPercent);}
	}
}