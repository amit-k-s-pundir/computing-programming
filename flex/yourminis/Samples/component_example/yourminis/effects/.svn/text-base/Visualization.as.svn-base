package yourminis.effects
{
	import yourminis.utils.Visualizer;
	import flash.events.Event;
	
	public class Visualization
	{
		protected var visualizer:Visualizer;
		public var dataArray:Array;
		public function Visualization(_visualizer)
		{
			dataArray = new Array();
			visualizer = _visualizer;
			visualizer.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		public function onEnterFrame(evt:Event):void{}
	}
}