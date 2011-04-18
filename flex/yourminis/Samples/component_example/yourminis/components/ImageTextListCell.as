package yourminis.components
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import yourminis.utils.ImageLoader;
	
	public class ImageTextListCell extends ListCell
	{
		public var cellLabel:TextField;
		public var cellPadding:Number = 3;
		public var cellBackground:Shape;
		public var highlightColor:uint;
		public var imageWidth:Number=80;
		public var imageLoader:ImageLoader;
		public var callback:Function;
		public var textFormat:TextFormat;
		public var divider:Shape;
		public function ImageTextListCell(data:*, w:Number, h:Number, _callback:Function, labelText:String="", imageURL:String="",_highlightColor:uint=0xCCCCCC )
		{
			callback = _callback;
			highlightColor = _highlightColor;
			super( data, w, h );
			
			divider = new Shape();
			cellBackground = new Shape();
			cellBackground.alpha = 0;
			imageLoader = new ImageLoader(imageURL,imageWidth,cellHeight-2*cellPadding);
			textFormat = new TextFormat();
			cellLabel = new TextField();
			
			this.buttonMode = true;
			imageLoader.setErrorTextFormat("");
			setTextFormat();
			cellLabel.wordWrap = true;
			cellLabel.selectable = false;
			cellLabel.mouseEnabled = false;
			cellLabel.htmlText = labelText;
			
			addChild(cellBackground);
			addChild(cellLabel);
			addChild(divider);
			addChild(imageLoader);
			
			
			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(MouseEvent.ROLL_OVER, overHandler);
			addEventListener(MouseEvent.ROLL_OUT, outHandler);
			
		}
		
		public function setTextFormat(_font:String="Verdana",_size:Number=11,_color:uint=0,_bold:Boolean=false)
		{
			textFormat = new TextFormat(_font,_size,_color,_bold);
			cellLabel.defaultTextFormat = textFormat;
		}
		
		private function clickHandler( evt:MouseEvent )
		{
			callback(data);
		}
		
		private function overHandler( evt:MouseEvent )
		{
			cellBackground.alpha = 1;
		}
		
		private function outHandler( evt:MouseEvent )
		{
			cellBackground.alpha = 0;
		}

		public override function resize( w:Number, h:Number )
		{
			cellWidth = w;
			cellHeight = h;
			var imageOffset:Number = (cellPadding+imageWidth)*int(imageLoader.url != "");
			cellLabel.x = cellPadding+imageOffset;
			cellLabel.y = cellPadding;
			cellLabel.width = cellWidth - 2*cellPadding - imageOffset;
			cellLabel.height = cellHeight - 2*cellPadding;
			divider.graphics.clear();
			divider.graphics.lineStyle(1,0);
			divider.graphics.moveTo(0,cellHeight);
			divider.graphics.lineTo(cellWidth,cellHeight);
			cellBackground.graphics.clear();
			cellBackground.graphics.beginFill(highlightColor);
			cellBackground.graphics.drawRect(0,0,cellWidth,cellHeight);
			cellBackground.graphics.endFill();
			imageLoader.x = imageLoader.y = cellPadding;
			imageLoader.setSize(imageWidth,cellHeight-2*cellPadding);
		}
				
	}
}