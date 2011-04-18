package yourminis.events
{
	import flash.events.Event;
	
	public class YMCustomEvent extends Event
	{
		private var myData:*;
		public function YMCustomEvent( type:String, data:*)
		{
			super(type);
			myData = data;
		}
		
		public function get data():*
		{
			return myData;
		}
	}
}