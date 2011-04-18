package yourminis.components
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
	dynamic public class ListCell extends MovieClip
	{
		public var _cellWidth:Number;
		public var _cellHeight:Number;
		public var bg:MovieClip;
		protected var cellIndex:int;
		protected var cellData:*;
		
		
		public function ListCell( data:*=null, w:Number=50, h:Number=50, _bg:MovieClip=null )
		{
			this.cellData = data;
			this._cellWidth = w;
			this._cellHeight = h;
			this.bg = _bg; 
		}
		
		public function resize( w:Number, h:Number )
		{
			this._cellWidth = w;
			this._cellHeight = h;
			dispatchEvent(new Event("resized"));
		}
		
		public function get index():int
		{
			return cellIndex;
		}
		
		public function set index( index:int ):void
		{
			this.cellIndex = index;
			if (this.bg) this.bg.index = index;
		}
		
		public function get data():*
		{
			return this.cellData;
		}
		
		public function set data( data:* ):void
		{
			this.cellData = data;
		}
		public function get cellWidth():Number
		{
			return _cellWidth;
		}
		public function get cellHeight():Number
		{
			return _cellHeight;
		}
		public function set cellWidth(newWidth:Number):void
		{
			_cellWidth = newWidth;
		}
		public function set cellHeight(newHeight):void
		{
			_cellHeight = newHeight;
		}
	}
}