package yourminis.effects
{
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.geom.Matrix;
	import flash.events.Event;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
		
	public class Flare extends Sprite
	{
		public var timer:Timer;
		public var frequency:Number;
		public var angle:Number;
		public var speed:Number;
		public var distance:Number;
		public var flareWidth:Number;
		public var flareHeight:Number;
		private var flare:Sprite;
		private var flareSprite:Sprite;
		public var flareMask:Sprite;
		public var offset:int = 2000;
		
		
		public function Flare(_width, _height, _distance, _speed=6, _angle=0.485, _frequency=2500)
		{
			flareWidth = _width;
			flareHeight = _height;
			distance = _distance;
			angle = _angle;
			speed = _speed;
			frequency = _frequency;
			flare = new Sprite();
			flareSprite = new Sprite();
			flareMask = new Sprite();
			flareMask.graphics.beginFill(0);
			flareMask.graphics.drawRect(0,0,distance,flareHeight);
			flareSprite.x = -flareWidth/2;
			flare.x = -flareWidth;
			drawFlare();
			flare.mouseEnabled = flareSprite.mouseEnabled = flareMask.mouseEnabled = false;
			addChild(flare);
			flare.addChild(flareSprite);
			addChild(flareMask);
			flare.mask = flareMask;
			resetTimer();
			
		}
		public function resetTimer():void
		{
			timer = new Timer(Math.round(Math.random()*frequency+offset),1);
			timer.addEventListener("timer", timerHandler);
			timer.start();
		}
		public function drawFlare():void
		{
			var matr:Matrix = new Matrix()
			matr.createGradientBox(flareWidth,flareHeight,angle);
			flareSprite.graphics.clear();
			flareSprite.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF,0xFFFFFF,0xFFFFFF], [0, 0.8, 0], [88, 128, 168], matr, SpreadMethod.PAD);
			flareSprite.graphics.drawRect(0, 0, flareWidth, flareHeight);
			flareSprite.graphics.endFill();
		}
		private function timerHandler(evt:Event):void
		{
			flare.x = -flareWidth;
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		private function enterFrameHandler(evt:Event)
		{
			flare.x += speed;
			var dist = (1+Math.abs(flare.x-(distance/2))/(distance/2))*2;
			flare.scaleX = flareSprite.scaleY = 4/dist;
			if (flare.x>distance+flareWidth)
			{
				removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
				resetTimer();
			}
		}
		
	}
	
}