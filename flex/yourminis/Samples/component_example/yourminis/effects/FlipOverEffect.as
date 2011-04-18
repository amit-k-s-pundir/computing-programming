package yourminis.effects
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	public class FlipOverEffect extends TransitionEffect
	{
		private var targetScale:Number;
		private var flipSpeed:Number = 2;
		private var originalXb:Number;
		private var originalXf:Number;
		private var originalYb:Number;
		private var originalYf:Number;
		private var blurFilter:BlurFilter;
		
		public function FlipOverEffect(_front:DisplayObjectContainer,_back:DisplayObjectContainer)
		{
			super(_front,_back);
		}
		override public function flip():void
		{
			if (!front.hasEventListener(Event.ENTER_FRAME))
			{
				originalXb = back.x;
				originalXf = front.x;
				originalYb = back.y;
				originalYf = back.y;
				flipped = !flipped;
				targetScale = 0;
				front.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
			}
		}
		public function flipY():void
		{
			originalYb = back.y;
			originalYf = front.y;
			flipped = !flipped;
			targetScale = 0;
			if (!front.hasEventListener(Event.ENTER_FRAME))
			{
				front.addEventListener(Event.ENTER_FRAME,enterFrameHandlerY);
				
			}
		}
		
		private function enterFrameHandler(evt:Event):void
		{
			back.scaleX = front.scaleX = front.scaleX+(targetScale - front.scaleX)/flipSpeed;
			blurFilter = new BlurFilter((1-front.scaleX)*10,1,2);
			back.x = originalXb + ((1-front.scaleX)*front.width)/2;
			front.x = originalXf + ((1-front.scaleX)*front.width)/2;
			if (targetScale)
			{
				
				back.visible=flipped;
				front.visible=!flipped;
				if (back.visible) back.filters = [blurFilter];
				if (front.visible) front.filters = [blurFilter];
				if (Math.abs(targetScale-front.scaleX)<0.01)
				{
					front.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
					front.scaleX = back.scaleX = targetScale;
					back.x = originalXb;
					front.x = originalXf;
					front.filters = back.filters = [];
				}
			}
			else
			{
				back.visible=!flipped;
				front.visible=flipped;
				if (back.visible) back.filters = [blurFilter];
				if (front.visible) front.filters = [blurFilter];
				if (Math.abs(targetScale-front.scaleX)<0.01)
				{
					targetScale = 1;
				}
			}
		}
		
		private function enterFrameHandlerY(evt:Event):void
		{
			trace("enter frame: " + targetScale);
			back.scaleY = front.scaleY = front.scaleY+(targetScale - front.scaleY)/flipSpeed;
			blurFilter = new BlurFilter((1-front.scaleY)*10,1,2);
			back.y = originalYb + ((1-front.scaleY)*front.width)/2;
			front.y = originalYf + ((1-front.scaleY)*front.width)/2;
			if (targetScale)
			{
				
				back.visible=flipped;
				front.visible=!flipped;
				if (back.visible) back.filters = [blurFilter];
				if (front.visible) front.filters = [blurFilter];
				if (Math.abs(targetScale-front.scaleY)<0.01)
				{
					front.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
					front.scaleY = back.scaleY = targetScale;
					back.y = originalYb;
					front.y = originalYf;
					front.filters = back.filters = [];
				}
			}
			else
			{
				back.visible=!flipped;
				front.visible=flipped;
				if (back.visible) back.filters = [blurFilter];
				if (front.visible) front.filters = [blurFilter];
				if (Math.abs(targetScale-front.scaleY)<0.01)
				{
					targetScale = 1;
				}
			}
		}
		
	}
}