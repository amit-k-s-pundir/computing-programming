package yourminis.components
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	
	public class YMCheckbox extends Sprite
	{
		public var textbox:TextField;
		public var callback:Function;
		public var data:*;
		private var _selected:Boolean;
		private var box:Sprite;
		
		public function YMCheckbox(_text:String="",_callback:Function=null,_isSelected:Boolean=false,defaultColor:uint=0x000000) 
		{
			_selected=_isSelected;
			callback = _callback;
			textbox = new TextField();
			textbox.autoSize = TextFieldAutoSize.LEFT;
			textbox.text = _text;   
			textbox.defaultTextFormat = new TextFormat("Verdana",10,defaultColor);
			textbox.selectable = false;
			textbox.x = 15;
			box = new Sprite();
			box.x = box.y = 3;
			drawBox();
			addChild(box);
			addChild(textbox);
			box.addEventListener(MouseEvent.CLICK,onMouseClick);
		}
		public function onMouseClick(evt:MouseEvent)
		{
			_selected = !_selected;
			drawBox();
			callback(_selected);
		}
		public function drawBox()
		{
			box.graphics.clear();
			box.graphics.lineStyle(1,0x999999,1);
			box.graphics.beginFill(0xFFFFFF,0.9);
			box.graphics.drawRect(0,0,10,10);
			box.graphics.endFill();
			if (_selected)
			{
				box.graphics.lineStyle(1,0x333333);
				box.graphics.moveTo(2,6);
				box.graphics.lineTo(5,9);
				box.graphics.lineTo(9,2);
			}
		}
		public function get selected():Boolean{return _selected;}
		public function set selected(_isSelected:Boolean):void{_selected = _isSelected; drawBox();}
		public function get text():String{return textbox.text;}
		public function set text(_text:String):void{textbox.text=_text;}
	}
}