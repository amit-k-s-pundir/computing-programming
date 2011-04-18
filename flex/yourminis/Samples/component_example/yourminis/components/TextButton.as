package yourminis.components
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TextButton extends Sprite
	{
		public var txt:TextField;
		public var textFormat:TextFormat;
		public var rollColor:uint;
		public var color:uint;
		public var callback:Function;
		
		public function TextButton( initString:String,_callback:Function,_font:String="Verdana",_size:Number=11,_color:uint=0xFFFFFF,_rollColor:uint=0xFF0000,_bold:Boolean=false)
		{
			color = _color;
			rollColor = _rollColor;
			callback = _callback;
			txt = new TextField(); 
			textFormat = new TextFormat(_font,_size,_color,_bold);
			txt.defaultTextFormat = textFormat;
			txt.mouseEnabled = false;
			txt.selectable = false;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.text = initString;
			drawBackground();
			addChild(txt);
			addEventListener(MouseEvent.ROLL_OVER,rolloverHandler);
			addEventListener(MouseEvent.ROLL_OUT,rolloutHandler);
			addEventListener(MouseEvent.CLICK,clickHandler);
			this.buttonMode = true;
		}
		private function rolloverHandler(evt:MouseEvent):void{txt.textColor = rollColor;}
		private function rolloutHandler(evt:MouseEvent):void{txt.textColor = color;}
		private function clickHandler(evt:MouseEvent):void{callback();}
		private function drawBackground()
		{
			this.graphics.clear();
			this.graphics.beginFill(0,0);
			this.graphics.drawRect(0,0,txt.width,txt.height);
			this.graphics.endFill();
		}
		public function set text(newText:String):void{txt.text = newText; drawBackground();}
		public function get text():String{return txt.text;}
	}
}
		