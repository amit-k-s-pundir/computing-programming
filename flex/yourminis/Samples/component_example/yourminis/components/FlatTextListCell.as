package yourminis.components
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import yourminis.events.YMListCellEvent;
	
	public class FlatTextListCell extends ListCell
	{
		private var cellLabel:TextField;
		private static var cellPadding:Number = 3;
		private var cellBackground:Shape;
		
		public function FlatTextListCell( labelText:String, data:*, w:Number, h:Number )
		{
			super( data, w, h );
			//draw & add background 
			cellBackground = new Shape();
			drawBackground(0xFFFFFF);
			this.addChild(cellBackground);
			//add textfield
			cellLabel = new TextField();
			var format:TextFormat = new TextFormat();
            format.font = "Verdana";
			cellLabel.defaultTextFormat = format;
			cellLabel.selectable = false;
			cellLabel.mouseEnabled = false;
			cellLabel.htmlText = labelText;
			this.addChild(cellLabel);
			//add event handlers
			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(MouseEvent.ROLL_OVER, overHandler);
			addEventListener(MouseEvent.ROLL_OUT, outHandler);
		}
		
		private function clickHandler( evt:MouseEvent )
		{
			evt.stopPropagation();
			if(evt.target == cellLabel){
				dispatchEvent( new YMListCellEvent(YMListCellEvent.CLICK, evt.target.parent.cellIndex, evt.target.parent.cellData) );
			}else{
				dispatchEvent( new YMListCellEvent(YMListCellEvent.CLICK, evt.target.cellIndex, evt.target.cellData) );
			}
			
		}
		
		private function overHandler( evt:MouseEvent )
		{
			drawBackground(0xFF0000);
			if(evt.target == cellLabel){
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OVER, evt.target.parent.cellIndex, evt.target.parent.cellData) );
			}else{
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OVER, evt.target.cellIndex, evt.target.cellData) );
			}

		}
		
		private function outHandler( evt:MouseEvent )
		{
			drawBackground(0xFFFFFF);
			if(evt.target == cellLabel){
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OUT, evt.target.parent.cellIndex, evt.target.parent.cellData) );
			}else{
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OUT, evt.target.cellIndex, evt.target.cellData) );
			}
		}
		
		private function dblClickHandler( evt:MouseEvent )
		{
			trace("Double Click");
		}
		
		private function drawBackground ( color:Number )
		{
			cellBackground.graphics.clear();
			cellBackground.graphics.beginFill(color);
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
			cellLabel.y = cellPadding;
			cellLabel.width = cellWidth - (cellPadding*2);
			cellLabel.height = cellHeight - (cellPadding*2);
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