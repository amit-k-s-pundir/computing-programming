package yourminis.effects
{
	import flash.display.DisplayObjectContainer;
	public class TransitionEffect
	{
		public var front:DisplayObjectContainer;
		public var back:DisplayObjectContainer;
		public var flipped:Boolean = false;
		{
			public function TransitionEffect(_front:DisplayObjectContainer,_back:DisplayObjectContainer)
			{
				front=_front;
				back=_back;
				back.visible = false;
			}
			public function flip():void
			{
				flipped = !flipped;
				back.visible = flipped;
				front.visible = !flipped;
			}
		}
	}
}