package yourminis.events
{
	import flash.events.Event;
	
	public class YMListCellEvent extends Event
	{
		public static const CLICK:String = "list-cell-click";
		public static const ROLL_OVER:String = "list-cell-roll_over";
		public static const ROLL_OUT:String = "list-cell-roll_out";
		public static const SIZE_CHANGE:String = "list-cell-size_change";
		private var cellData:*;
		private var cellIndex:int;
		public function YMListCellEvent( type:String, idx:int, data:*)
		{
			super(type);
			cellData = data;
			cellIndex = idx;
		}
		
		public function get index():int
		{
			return cellIndex;
		}
		
		public function get data():*
		{
			return cellData;
		}
	}
}