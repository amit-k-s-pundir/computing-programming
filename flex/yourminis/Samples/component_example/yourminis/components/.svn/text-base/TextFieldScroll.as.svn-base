package yourminis.components
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	public class TextFieldScroll extends TextField
	{
		public var scrollArea:ScrollArea;
		public var _width:Number;
		public var format:TextFormat;
		public function TextFieldScroll(_font:String="Verdana",_size:int=11,_color:uint=0xFFFFFF)
		{
			format = new TextFormat();
            format.font = _font;
			format.color = _color;
			format.size = _size;

			this.wordWrap = true;
			this.multiline = true;
			this.defaultTextFormat = format;
			this.autoSize = TextFieldAutoSize.LEFT;
			
		}
		public function setTheme(color:uint):void
		{
			format.color = color;
			this.defaultTextFormat = format;
		}
		public function setSize(w:Number, h:Number=0)
		{
			this.width = w;
			if (scrollArea) 
			{
				if (this.textHeight+10>scrollArea.scrollAreaHeight) this.width = w - 5;
				scrollArea.updateScrollBars(this.width,this.textHeight+10);
			}
			
		}
		override public function set text(newText:String):void
		{
			super.text = newText;
			setSize(this.width);
		}
		override public function set htmlText(newText:String):void
		{
			super.htmlText = newText;
			setSize(this.width);
		}
	}
}