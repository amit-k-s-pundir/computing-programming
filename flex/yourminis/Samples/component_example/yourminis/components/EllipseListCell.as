package yourminis.components
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import yourminis.events.YMListCellEvent;
	
	public class EllipseListCell extends ListCell
	{
		private var cellLabel:TextField;
		private var labelTxt:String;
		private static var cellPadding:Number = 3;
		private var cellBackground:Shape;
		
		public function EllipseListCell( labelText:String, data:*, w:Number, h:Number )
		{
			super( data, w, h );
			//draw & add background 
			cellBackground = new Shape();
			cellBackground.y = 2;
			drawBackground(0x000000);
			this.addChild(cellBackground);
			//add textfield
			cellLabel = new TextField();
			cellLabel.y=4;
			var format:TextFormat = new TextFormat();
            format.font = "Verdana";
			format.size = 10;
			format.color = 0xFFFFFF;
			format.bold = true;
			format.align="center";
			//cellLabel.background = true;
			cellLabel.defaultTextFormat = format;
			cellLabel.selectable = false;
			cellLabel.mouseEnabled = false;
			cellLabel.height = 25;
			cellLabel.htmlText = labelText;
			labelTxt = labelText;

			this.buttonMode = true;
			this.useHandCursor = true;
			
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
			drawBackground(0x99CCFF);
			cellLabel.htmlText = "<font color='#000000'><b>" + labelTxt + "</b></font>";
			
			if(evt.target == cellLabel){
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OVER, evt.target.parent.cellIndex, evt.target.parent.cellData) );
			}else{
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OVER, evt.target.cellIndex, evt.target.cellData) );
			}

		}
		
		private function outHandler( evt:MouseEvent )
		{
			drawBackground(0x000000);
			cellLabel.htmlText = "<font color='#ffffff'><b>" + labelTxt + "</b></font>";
			
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
			var cornerRadius = 10;
			var boxWidth = cellWidth-10;
			var boxHeight = cellHeight - 5;
			
			cellBackground.graphics.lineStyle(2,0xFFFFFF,100,true);
			cellBackground.graphics.beginFill(color,100);
			cellBackground.graphics.moveTo(cornerRadius, 0);
			cellBackground.graphics.lineTo(boxWidth - cornerRadius, 0);
			cellBackground.graphics.curveTo(boxWidth, 0, boxWidth, cornerRadius);
			cellBackground.graphics.lineTo(boxWidth, cornerRadius);
			cellBackground.graphics.lineTo(boxWidth, boxHeight - cornerRadius);
			cellBackground.graphics.curveTo(boxWidth, boxHeight, boxWidth - cornerRadius, boxHeight);
			cellBackground.graphics.lineTo(boxWidth - cornerRadius, boxHeight);
			cellBackground.graphics.lineTo(cornerRadius, boxHeight);
			cellBackground.graphics.curveTo(0, boxHeight, 0, boxHeight - cornerRadius);
			cellBackground.graphics.lineTo(0, boxHeight - cornerRadius);
			cellBackground.graphics.lineTo(0, cornerRadius);
			cellBackground.graphics.curveTo(0, 0, cornerRadius, 0);
			cellBackground.graphics.lineTo(cornerRadius, 0);
			cellBackground.graphics.endFill();
			
			/*
			cellBackground.graphics.clear();
			cellBackground.graphics.lineStyle(2,0xFFFFFF,100,true);
			cellBackground.graphics.beginFill(color);
			cellBackground.graphics.drawEllipse(0,0,cellWidth-10,cellHeight-5);
			cellBackground.graphics.endFill();
			*/
		}
		public override function resize( w:Number, h:Number )
		{
			cellWidth = w;
			cellHeight = 25;
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