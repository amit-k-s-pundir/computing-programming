package yourminis.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class SkinIndex extends Sprite
	{
		public var this_mc;
		public var cellType:Class;
		public var scrollType:Class;
		public var enableScroll:Boolean;
		public var cornerRadius:Number;
		public var dataArray:Array;
		public var cellArray:Array;
		private var w;
		private var h;
		private var cells:Sprite;
		private var totalLength;
		private var parent_mc;
		private var vertical:Boolean;
		
		public function SkinIndex(_parent_mc, _w, _h, _cellType:Class, _dataArray, _vertical:Boolean = false)
		{
			this_mc = this;
			cellArray = [];
			parent_mc = _parent_mc;
			dataArray = new Array();
			cellType = _cellType;
			vertical = _vertical;
			dataArray = _dataArray;
			w = _w;
			h = _h;
			cells = new Sprite;
			addChild(cells);
			
			setSize(w,h,true);
		}
		
		public function setSize(__width:Number,__height:Number,bRefresh:Boolean = false) {
			w = __width;
			h = __height;
			refreshList(bRefresh);
		}
		
		public function refreshList(bRefresh:Boolean = false) {
						
			if (bRefresh) {
				cellArray = [];
				while (cells.numChildren) {
					cells.removeChildAt(0);
				}
				var i;
				for (i = 0; i < dataArray.length; i++) {
					cellArray.push(new cellType());
					cells.addChild(cellArray[i]);
					cellArray[i]["onInit"](parent_mc,i,dataArray[i]);
				}
			}
			
			totalLength = 0;
			
			for (i = 0; i < cellArray.length; i++) {
				if (vertical) {
					cellArray[i]["onResize"](w, h/cellArray.length);
					cellArray[i].y=totalLength;
					totalLength += cellArray[i].height;
				}
				else {
					cellArray[i]["onResize"](w/cellArray.length, h);
					cellArray[i].x=totalLength;
					totalLength += cellArray[i].width;
				}
					
			}
			
		}
		
	}
}