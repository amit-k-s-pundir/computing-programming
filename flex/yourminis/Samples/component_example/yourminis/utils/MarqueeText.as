package yourminis.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class MarqueeText extends Sprite
	{
		private var textmask:Sprite;
		private var textcontainer:Sprite;
		private var textfield1:TextField;
		private var textfield2:TextField;
		private var textformat:TextFormat;
		
		private var leadtext:TextField;
		private var lagtext:TextField;
		private var temptext:TextField;
		
		private var __width:Number;
		private var __height:Number;
		public var scrollspeed:Number = 2;
		public var spacing:Number = 50;
		public function MarqueeText()
		{
			this.mouseEnabled = false;
			textmask = new Sprite();
			textcontainer=new Sprite();
			textcontainer.mouseEnabled=textmask.mouseEnabled = false;
			textfield1 = new TextField();
			textfield2 = new TextField();
			leadtext = textfield1;
			lagtext = textfield2;
			textfield1.autoSize = textfield2.autoSize = "left";
			textfield1.mouseEnabled = textfield1.selectable = textfield2.mouseEnabled = textfield2.selectable = false;
			reset();
			setTextFormat();
			textcontainer.mask = textmask;
			addChild(textcontainer);
			textcontainer.addChild(textfield1);
			textcontainer.addChild(textfield2);
			addChild(textmask);
			this.width = 200;
		}
		public function setTextFormat(_font:String="Verdana",_size:Number=11,_color:uint=0,_bold:Boolean=true)
		{
			textformat = new TextFormat(_font,_size,_color,_bold);
			textfield1.defaultTextFormat = textformat;
			textfield2.defaultTextFormat = textformat;
			textfield1.setTextFormat(textformat);
			textfield2.setTextFormat(textformat);
			if (textfield1.text == "")
			{
				textfield1.text = "  ";
				__height = textfield1.height;
				textfield1.text = "";
			}
			else __height = textfield1.height;
		}
		public function set text(val:String):void
		{
			textfield1.text = textfield2.text = val;
			
			reset();
		}
		public function set htmlText(val:String):void{}
		
		override public function set width(w:Number):void
		{
			__width = w;
			textmask.graphics.clear();
			textmask.graphics.beginFill(0,1);
			textmask.graphics.drawRect(0,0,w,__height);
			textmask.graphics.endFill();
			reset();
		}
		public function reset()
		{
			leadtext.x = 0; 
			lagtext.x = Math.max(__width,leadtext.width) + spacing;
		}
		private function enterFrameHandler(evt:Event):void
		{
			leadtext.x -= scrollspeed;
			if (leadtext.x <= -leadtext.width)
			{
				temptext = leadtext;
				leadtext = lagtext;
				lagtext = temptext;
			}
			lagtext.x = leadtext.x + leadtext.width + spacing;
		}
		public function start():void{addEventListener(Event.ENTER_FRAME, enterFrameHandler);}
		public function stop():void{try{removeEventListener(Event.ENTER_FRAME,enterFrameHandler)}catch(e){}}
		public function get isWithinBounds():Boolean{return leadtext.width <= __width;}
	}
}