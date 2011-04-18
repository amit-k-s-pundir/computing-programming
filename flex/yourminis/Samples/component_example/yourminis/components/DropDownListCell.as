package yourminis.components
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import yourminis.components.YMList;
	import yourminis.events.YMListCellEvent;
	
	public class DropDownListCell extends ListCell
	{
		private var cellLabel:TextField;
		private static var cellPadding:Number = 2;
		private var cellBackground:Shape;
		private var moreArrow:Shape;
		private var menu:YMList;
		private var cellFunction:Function;
		private var cellAlpha:Number;
		private var cellBackgroundColor:Number;
		private var cellHighlightColor:Number;
		private var cellArrowColor:Number;
		public function DropDownListCell( labelText:String, data:*, _func:Function, w:Number, h:Number, ...args )
		{
			super( data, w, h );
			cellFunction = _func;
			cellAlpha = (args[0] != undefined)?args[0]:1;
			cellBackgroundColor = (args[1] != undefined)?args[1][0]:0x333333;
			cellHighlightColor = (args[1] != undefined)?args[1][1]:0x555555;
			cellArrowColor = (args[1] != undefined)?args[1][2]:0xFFFFFF;
			//draw & add background 
			cellBackground = new Shape();
			drawBackground(cellBackgroundColor, cellAlpha);
			this.addChild(cellBackground);
			//add textfield
			cellLabel = new TextField();
			cellLabel.selectable = false;
			cellLabel.textColor = 0xFFFFFF;
			cellLabel.htmlText = labelText;
			cellLabel.setTextFormat(new TextFormat("Verdana",10));
			this.addChild(cellLabel);
			//add event handlers
			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(MouseEvent.ROLL_OVER, overHandler);
			addEventListener(MouseEvent.ROLL_OUT, outHandler);
		}
		
		public function addItem( newCell:ListCell )
		{
			if(!menu)
			{
				menu = new YMList();
				menu.addEventListener(YMListCellEvent.CLICK, menuClickHandler);
				menu.visible = false;
				this.addChild(menu);
				menu.x = -cellWidth;
				moreArrow = new Shape();
				moreArrow.graphics.beginFill(cellArrowColor);
				var lineLength:Number = 10;
			    moreArrow.graphics.lineTo(0, lineLength);
				moreArrow.graphics.lineTo(lineLength/2,lineLength/2);
			    moreArrow.graphics.lineTo(0,0);
				this.addChild(moreArrow);
				moreArrow.x = cellWidth - moreArrow.width - cellPadding;
				moreArrow.y = (cellHeight - moreArrow.height)/2;
			}
			menu.addItem( newCell, true );
		}
		
		private function menuClickHandler( evt:YMListCellEvent )
		{
			dispatchEvent(new YMListCellEvent(YMListCellEvent.CLICK,evt.index,evt.data));
		}
		
		private function clickHandler( evt:MouseEvent )
		{
			evt.stopImmediatePropagation();
			if(evt.target == cellLabel){
				if(cellFunction != null) 
				{
					if (evt.target.parent.cellData!=null)
						cellFunction( evt.target.parent.cellData);
					else
						cellFunction();
				}
					
				dispatchEvent( new YMListCellEvent(YMListCellEvent.CLICK, evt.target.parent.cellIndex, evt.target.parent.cellData) );
			}else{
				if(cellFunction != null)
				{
					if (evt.target.cellData!=null)
						cellFunction( evt.target.cellData);
					else
						cellFunction();
				}
				dispatchEvent( new YMListCellEvent(YMListCellEvent.CLICK, evt.target.cellIndex, evt.target.cellData) );
			}

			
		}
		
		private function overHandler( evt:MouseEvent )
		{
			drawBackground(cellHighlightColor, cellAlpha);
			if(menu) menu.visible = true;
			if(evt.target == cellLabel){
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OVER, evt.target.parent.cellIndex, evt.target.parent.cellData) );
			}else{
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OVER, evt.target.cellIndex, evt.target.cellData) );
			}

		}
		
		private function outHandler( evt:MouseEvent )
		{
			if(menu) menu.visible = false;
			drawBackground(cellBackgroundColor, cellAlpha);
			if(evt.target == cellLabel){
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OUT, evt.target.parent.cellIndex, evt.target.parent.cellData) );
			}else{
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OUT, evt.target.cellIndex, evt.target.cellData) );
			}
		}
		
		private function drawBackground ( color:Number, bgalpha:Number )
		{
			cellBackground.graphics.clear();
			cellBackground.graphics.beginFill(color, bgalpha);
			cellBackground.graphics.drawRect(0,0,cellWidth,cellHeight);
			cellBackground.graphics.endFill();
		}
		public override function resize( w:Number, h:Number )
		{
			prototype.cellWidth = w;
			prototype.cellHeight = h;
			cellBackground.width = cellWidth;
			cellBackground.height = cellHeight;
			cellLabel.x = cellPadding;
			cellLabel.y = cellPadding-3;
			cellLabel.width = cellWidth - (cellPadding*2);
			cellLabel.height = cellHeight + 5 - (cellPadding*2);
		}
		
		public function get label():String
		{
			return this.cellLabel.htmlText;
		}
		
		public function set label( labelText:String):void
		{
			this.cellLabel.htmlText = labelText;
		}
		
	}
}