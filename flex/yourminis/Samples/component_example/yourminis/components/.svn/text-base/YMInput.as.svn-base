package yourminis.components
{
	import flash.display.Sprite;
	import flash.events.TextEvent;
	import flash.events.KeyboardEvent;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.filters.DropShadowFilter;
	
	
	
	public class YMInput extends Sprite
	{
		public var defaultText:String = "";
		public var callback:Function;
		public var myTxtFormat:TextFormat;
		public var icon:Sprite;
		private var textFocus:Boolean;
		public var txt:TextField;
		private var isPassword:Boolean = false;
		public var boxHeight:int; 
		private var boxWidth:int;
		public var themeColor:uint;
		public var button:YMButton;
		private var bg:Sprite;
		public var bgLineThickness:Number;
		public var bgLineAlpha:Number;
		public var fillColor:uint = 0x999999;
		public var borderColor:uint = 0xFFFFFF;
		public var fillAlpha:Number = 0.4;
		public var cornerRadius:Number = 6;
		private var margin:Number = 4;
		
		public function YMInput(w:int,_defaultText:String, initX:int, initY:int, ...args)
		{
			boxWidth = w;
			if (_defaultText.length) defaultText = _defaultText;
			x = initX;
			y = initY;
			boxHeight = 16;
			callback = args[0];
			var buttonText:String = args[1];
			themeColor = args[2];
			if (args[2]==undefined || args[2] == null) themeColor = 0xFFFFFF;
			borderColor = themeColor
			bg = new Sprite();
			bgLineThickness = 1;
			if (args[3]!=null) bgLineThickness = args[3];
			bgLineAlpha = 0.5;
			if (args[4]!=null) bgLineAlpha = args[4];
			addChild(bg);
			icon = new Sprite();
			txt = new TextField();
			addChild(txt);
			addChild(icon);
			icon.x = icon.y = 2;
			if (buttonText)	
			{
				var btnColArr:Array = [themeColor,themeColor];
				if (themeColor == 0xFFFFFF) btnColArr = [];
				button = new YMButton(buttonText,submit,boxWidth+8,0,btnColArr);
				button.y = -1;
				addChild(button);
			}
			txt.type = "input";
			txt.x = margin;
			//txt.tabIndex = _root.tIndex;
			myTxtFormat = new TextFormat();
			myTxtFormat.font = "Verdana";
			myTxtFormat.size = 10;
			myTxtFormat.color = themeColor;
			txt.defaultTextFormat = myTxtFormat;
			txt.text = defaultText;
			
			txt.addEventListener(KeyboardEvent.KEY_DOWN,onKeyIsDown);
			txt.addEventListener(FocusEvent.FOCUS_IN,onTextFocusIn);
			txt.addEventListener(FocusEvent.FOCUS_OUT,onTextFocusOut);
			txt.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			resize();
		}
		
		private function mDown(evt:MouseEvent) {
			evt.stopImmediatePropagation();
		}
		
		public function setTabIndex(index:int){txt.tabIndex = index;}
		public function setFocus():void
		{
			try{stage.focus = txt}catch(e:Error){};
			txt.setSelection(0,txt.text.length);
		}
	
		public function get text():String{
			if (txt.text == defaultText) return "";
			else return txt.text;
		}
		public function set text(str):void{
			txt.text = str;
			if (txt.text == "")
			{
				txt.displayAsPassword = false;
				txt.text = defaultText;
			}
		}
		public override function get width():Number {return txt.width+2;}
		public override function set width(val:Number):void{boxWidth=val; resize();}
		public override function get height():Number {return txt.height-5;}
		public override function set height(val:Number):void{boxHeight=val; resize();}
		public function set password(val:Boolean):void{isPassword = val;}
	
		private function resize():void
		{
			txt.x = margin+icon.width+icon.x;
			txt.width = boxWidth - 2*margin - icon.width;
			txt.height = boxHeight+5;
			bg.graphics.clear();
			bg.graphics.lineStyle(bgLineThickness,borderColor,bgLineAlpha,true);
			bg.graphics.beginFill(fillColor,fillAlpha);
			bg.graphics.drawRoundRect(0,0,boxWidth,boxHeight,cornerRadius);
			if (button) button.x = boxWidth + 8;
			myTxtFormat.color = themeColor;
			txt.textColor = themeColor;
			txt.defaultTextFormat = myTxtFormat;
			if (button) button.y = -1 * button.txt.filters.length; 
		}
		private function onTextFocusOut(evt:FocusEvent):void
		{
			textFocus = false;
			if (txt.text == "")
			{
				txt.displayAsPassword = false;
				txt.text = defaultText;
			}
		}
		private function onTextFocusIn(evt:FocusEvent):void
		{
			textFocus = true;
			txt.displayAsPassword = isPassword;
			if (txt.text == defaultText) txt.text = "";
		}
		private function onKeyIsDown(evt:KeyboardEvent):void
		{
			if (textFocus == true && evt.keyCode == 13)
			{
				submit();
			}
		}
		private function submit():void
		{
			callback();
		}
	}
}