package yourminis.components
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import yourminis.events.YMListCellEvent;
	
	public class TextListCell extends ListCell
	{
		private var cellLabel:TextField;
		private static var cellPadding:Number = 3;
		public var bgmc:MovieClip;
		public var labelOut:String = "";
		public var labelOver:String = "";
		
		public function TextListCell( labelText:String, data:*, w:Number, h:Number, mc:MovieClip,  labelOverText:String = null)
		{
			super( data, w, h );
			
			//draw & add background 
			bgmc = mc;
			this.addChild(bgmc);
			//add textfield
				
			labelOut = labelText;
			
			if (labelOverText==null)
				labelOverText = labelText;
				
			labelOver = labelOverText;
								
			cellLabel = new TextField();
			var format:TextFormat = new TextFormat();
            format.font = "Verdana";
			cellLabel.defaultTextFormat = format;
			cellLabel.selectable = false;
			cellLabel.mouseEnabled = true;
			cellLabel.htmlText = labelOut;
			this.addChildAt(cellLabel,0);
			//add event handlers
			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(MouseEvent.MOUSE_OVER, overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, outHandler);
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
		
		private function dblClickHandler( evt:MouseEvent )
		{
			trace("Double Click");
		}
		
		private function outHandler( evt:MouseEvent )
		{
			//evt.stopPropagation();
			
			cellLabel.htmlText = labelOut;
			
			if(evt.target == cellLabel){
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OUT, evt.target.parent.cellIndex, evt.target.parent.cellData) );
			}else{
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OUT, evt.target.cellIndex, evt.target.cellData) );
			}
			
		}
		private function overHandler( evt:MouseEvent )
		{
			//evt.stopPropagation();
			
			cellLabel.htmlText = labelOver;
			if(evt.target == cellLabel){
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OVER, evt.target.parent.cellIndex, evt.target.parent.cellData) );
			}else{
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OVER, evt.target.cellIndex, evt.target.cellData) );
			}
			
		}
		public override function resize( w:Number, h:Number )
		{
			prototype.cellWidth = w;
			prototype.cellHeight = h;
			cellLabel.x = cellPadding;
			cellLabel.y = 0;
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