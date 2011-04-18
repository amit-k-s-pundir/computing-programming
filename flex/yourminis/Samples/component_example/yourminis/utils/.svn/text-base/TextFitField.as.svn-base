package yourminis.utils
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	public class TextFitField extends TextField
	{
		private var _text:String;
		private var maxWidth:Number;
		private var _minWidth:Number=30;
		public var textFormat:TextFormat;
		public var _maxLines:int=1;
		public var appendString:String = "...";
		public var headerString:String = "";
		public function TextFitField(_maxWidth:Number=100,__maxLines:int=1,initX:Number=0,initY:Number=0,_font:String="Verdana",_size:Number=11,_color:uint=0xFFFFFF,_bold:Boolean=false, initString:String="")
		{
			maxWidth = _maxWidth;
			_maxLines = __maxLines;
			this.x = initX;
			this.y = initY;
			this.selectable = false;
			this.autoSize = TextFieldAutoSize.LEFT;
			if (_maxLines > 1) this.wordWrap = true;
			textFormat = new TextFormat(_font,_size,_color,_bold);
			this.defaultTextFormat = textFormat;
			this.text = initString;
		}
		
		override public function set width(newWidth:Number):void
		{
			maxWidth = Math.max(newWidth,_minWidth);
			updateField();
		}
		override public function set text(newText:String):void{_text = newText; updateField();}
		override public function get text():String{return _text;}
		public function set maxLines(newVal:int):void{_maxLines = newVal; updateField();}
		public function get maxLines():int{return _maxLines;}
		public function fitText(newText:String,newWidth:Number=0):void
		{
			_text = newText;
			if (newWidth) maxWidth = newWidth;
			updateField();
		}
		public function updateField()
		{
			var val:Boolean = (this.visible == true);
			if (maxWidth==_minWidth){super.htmlText = appendString; return;}
			this.visible = false;
			var index:int = 1;
			if (_maxLines <= 1)
			{
				super.htmlText = headerString + _text;
				if (super.width <= maxWidth){this.visible = val; return;}
				else super.htmlText = appendString;
				while (super.width < maxWidth - 5 && index < 10000){super.htmlText = headerString + _text.substr(0,index)+appendString; index++;}
			}
			else
			{
				super.width = maxWidth;
				super.htmlText = headerString + _text;
				if (this.numLines < _maxLines+1) {this.visible = val; return;}
				else super.htmlText = appendString;
				while (this.numLines < _maxLines+1 && index < 10000){super.htmlText = headerString + _text.substr(0,index)+appendString; index++;}
				index-=2;
				super.htmlText = headerString + _text.substr(0,index)+appendString;
			}
			this.visible = val;
		}
	}
									  
}