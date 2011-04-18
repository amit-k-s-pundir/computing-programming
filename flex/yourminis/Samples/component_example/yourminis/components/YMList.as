package yourminis.components{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import yourminis.events.YMListCellEvent
	
	public class YMList extends Sprite{
		public var scrollArea:ScrollArea;
		public var menuItems:Array;
		public var listWidth:Number;
		public var listHeight:Number;
		public var sortable:Boolean = false;
		public var themeColor:uint = 0xFFFFFF;
		protected var maxDimension:Number;
		protected var isHorizontal:Boolean;
		protected var hasMouseFocus:Boolean;
		private var currentInsertIndex:int;
		private var currentDragIndex:int;
		private var currentDragCell:ListCell;
		private var placeHolderCell:ListCell;
		
		
		
		public function YMList() 
		{
			this.tabChildren = false;
			menuItems = new Array();
			maxDimension = 1;
			isHorizontal = false;
			listWidth = 200;
			listHeight = 200;
			hasMouseFocus = false;
		}
		
		public function setDimensions(_isHorizontal:Boolean, _maxDimension:Number):void
		{
			isHorizontal = _isHorizontal;
			maxDimension = _maxDimension;
		}
	   
		public function addItem(newCell:ListCell,shouldUpdate:Boolean=true):void
		{
			var index:Number = menuItems.length;
			initCell(newCell,index)
			if (shouldUpdate) updateAfterEdit();
		}
		public function initCell(newCell:ListCell,index:int):void
		{
			newCell.addEventListener(YMListCellEvent.CLICK, clickHandler);
			newCell.addEventListener(YMListCellEvent.ROLL_OVER, overHandler);
			newCell.addEventListener(YMListCellEvent.ROLL_OUT, outHandler);
			newCell.index = index;
			
			if (index==menuItems.length) menuItems.push(newCell);
			else
			{
				var temp:Array = menuItems.splice(index);
				menuItems.push(newCell);
				menuItems = menuItems.concat(temp);
				refreshIndexes();
			}
			this.addChildAt(newCell,0);
			if (sortable && newCell.bg) newCell.bg.addEventListener(MouseEvent.MOUSE_DOWN,startCellDrag);
			newCell.addEventListener(YMListCellEvent.SIZE_CHANGE,onCellSizeChange);
		}
		
		public function onCellSizeChange(event:YMListCellEvent):void{updateAfterEdit();}
		
		public function updateAfterEdit():void
		{
			setSize(listWidth,listHeight);
		}
		public function startCellDrag(event:MouseEvent):void
		{
			//if (event.eventPhase>2) return;
			event.stopImmediatePropagation();
			currentDragIndex = event.target.index;
			try{
				menuItems[currentDragIndex].startDrag();
				currentDragCell = removeItemAt(currentDragIndex,true);			
				placeHolderCell = new PlaceHolderCell(currentDragCell.cellWidth,currentDragCell.cellHeight,themeColor);
				addItemAt(placeHolderCell,currentDragIndex);
				//placeHolderCell.index=currentDragIndex;
				root.addEventListener(MouseEvent.MOUSE_UP, endCellDrag,false,0,true);
				root.addEventListener(MouseEvent.MOUSE_MOVE, moveCellDrag,false,0,true);
			}
			catch(e){}
		}
		public function moveCellDrag(event:MouseEvent):void
		{
			var xdim = menuItems[0].cellWidth;
			var ydim = menuItems[0].cellHeight;
			var xfac = Math.max(0,Math.floor(this.mouseX/xdim));
			var yfac = Math.max(0,Math.floor(this.mouseY/ydim));
			var newIndex:int;
			
			if (isHorizontal)
			{
				yfac = Math.min(maxDimension-1,yfac);
				xfac = Math.min(Math.floor((menuItems.length-1)/maxDimension),xfac);
				newIndex = maxDimension*xfac + yfac;
			
			}
			else
			{
				xfac = Math.min(maxDimension-1,xfac);
				yfac = Math.min(Math.floor((menuItems.length-1)/maxDimension),yfac);
				newIndex = maxDimension*yfac + xfac;
			}
			removeItemAt(placeHolderCell.index);
			addItemAt(placeHolderCell,newIndex);
		
		}
		
		private function endCellDrag(event:MouseEvent):void
		{
			stopDrag();
			removeItemAt(placeHolderCell.index);
			addItemAt(currentDragCell,placeHolderCell.index);
			dispatchEvent(new Event("changed"));
			root.removeEventListener(MouseEvent.MOUSE_UP, endCellDrag);
			root.removeEventListener(MouseEvent.MOUSE_MOVE, moveCellDrag);
		}
		
		public function swapItems(index1:int,index2:int):void
		{
			if (index1 != index2)
			{
				var tempCell:ListCell = menuItems[index1];
				menuItems[index1] = menuItems[index2];
				menuItems[index1].index = index2;
				//menuItems[index1].x = menuItems[index2].x;
				//menuItems[index1].y = menuItems[index2].y;
				menuItems[index2] = tempCell;
				menuItems[index2].index = index1;
				currentDragIndex = index2;
				//menuItems[index2].x = tempCell.x;
				//menuItems[index2].y = tempCell.y;
				updateAfterEdit();
				
			}
		}
		
		protected function clickHandler(evt:YMListCellEvent):void
		{
			dispatchEvent(new YMListCellEvent(YMListCellEvent.CLICK,evt.index,evt.data));
		}
		private function overHandler(evt:YMListCellEvent):void
		{
			// places the current cell on top of the layers
			//var obj:Sprite = Sprite(evt.target);
			//var topPos:uint = this.numChildren - 1;
			//setChildIndex(obj,topPos);
			
			hasMouseFocus = true;
			dispatchEvent(new YMListCellEvent(YMListCellEvent.ROLL_OVER,evt.index,evt.data));
		}
		
		private function outHandler(evt:YMListCellEvent):void
		{
			hasMouseFocus = false;
			dispatchEvent(new YMListCellEvent(YMListCellEvent.ROLL_OUT,evt.index,evt.data));
		}
		
		public function removeAll():void
		{
			for (var i:int=0; i<menuItems.length; i++)
			{
				this.removeChild(menuItems[i]);
			}
			menuItems = [];
		}
		
		public function setTheme(color:uint):void
		{
			for (var i:int=0; i<menuItems.length; i++)
			{
				//update cell color
			}
		}
		private function refreshIndexes():void
		{
			for (var i:int=0; i < menuItems.length; i++)
			{
				menuItems[i].index = i;
			}
		}
		public function removeItemAt(index:int,dragging:Boolean=false):ListCell
		{
			var removedItem:ListCell = menuItems[index];
			if (!dragging) this.removeChild(removedItem);
			menuItems.splice(index,1);
			refreshIndexes();
			updateAfterEdit();
			return removedItem;
			dispatchEvent(new Event(Event.CHANGE));
			//destroy cell at index
		}
		public function addItemAt(newCell:ListCell,index:int)
		{
			initCell(newCell,index);
			updateAfterEdit();
		}
		
		
		public function setSize(w:Number,h:Number):void
		{
			listWidth = w;
			listHeight = h;
			for (var i:int=0; i<menuItems.length; i++)
			{
				if (isHorizontal)
				{
					if (i%maxDimension > 0) menuItems[i].y = Math.round(menuItems[i-1].y + menuItems[i-1].cellHeight);
					else menuItems[i].y = 0;
				
					if (i<maxDimension) menuItems[i].x = 0; 
					else menuItems[i].x = Math.round(menuItems[i-maxDimension].x + menuItems[i-maxDimension].cellWidth);
				}
				else
				{
					if (i%maxDimension > 0) menuItems[i].x = Math.round(menuItems[i-1].x + menuItems[i-1].cellWidth);
					else menuItems[i].x = 0;
				
					if (i<maxDimension) menuItems[i].y = 0; 
					else menuItems[i].y = Math.round(menuItems[i-maxDimension].y + menuItems[i-maxDimension].cellHeight);
					
					if (maxDimension == 1) menuItems[i].resize(w,menuItems[i].cellHeight)
				}
			}
			var newContentWidth:Number = 0;
			var newContentHeight:Number = 0;
			if (menuItems[0])
			{
				var cellw:Number = menuItems[0].cellWidth;
				var cellh:Number = menuItems[0].cellHeight;
				if (isHorizontal) 
				{
					newContentWidth = Math.ceil(menuItems.length/maxDimension)*cellw;
					if (menuItems[0]) newContentHeight = menuItems[0].cellHeight * maxDimension; 
				}
				else
				{
					newContentWidth = menuItems[0].cellWidth * maxDimension;
					newContentHeight = Math.ceil(menuItems.length/maxDimension)*cellh;
					
				}
			}
			if (scrollArea) scrollArea.updateScrollBars(newContentWidth,newContentHeight);
		}
	}
}

