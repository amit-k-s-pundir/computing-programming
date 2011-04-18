package yourminis.effects
{
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;	
	import flash.filters.GlowFilter;
	
	public class Pulse
	{
		
		private var pulseDirection:String = "out";
		private var pulseSprite:Object;
		public var timer:Timer;
		public var filterStrength:Number = 0.1;
		public var maxPulseStrength:Number = 0.4;
		public var pulseColor;

		
		public function Pulse(sprite:Object,_pulseColor:uint=0x00CCFF)
		{
			pulseColor = _pulseColor;
			pulseSprite = sprite;
			timer = new Timer(15,0);
			timer.addEventListener("timer",doPulse);
		}
		
		public function stopPulse(...args):void
		{
			timer.reset();
			pulseSprite.filters = [];
		}
		public function startPulse(...args):void
		{
			filterStrength = 0.1;
			timer.start();
		}
		
		public function doPulse(evt:TimerEvent=null):void 
		{

			if(pulseDirection == "in" && filterStrength+.01 <= 1) filterStrength+=.02;
			else if (pulseDirection == "in" && filterStrength+.01 > 1){pulseDirection = "out"; filterStrength-=.02;}
			else if(pulseDirection == "out" && filterStrength-.01  >= maxPulseStrength) filterStrength-=.02;
			else if(pulseDirection == "out" && filterStrength-.01  < maxPulseStrength){pulseDirection = "in"; filterStrength+=.01;}
															
			var color:uint = pulseColor;
			var blurX:Number = 4;
			var blurY:Number = 4;
			var strength:Number = 2.5;
			var quality:Number = 3;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var filter:GlowFilter = new GlowFilter(color, filterStrength, blurX, blurY, strength, quality, inner, knockout);
			pulseSprite.filters = [filter];
		}
		
	}
	
}