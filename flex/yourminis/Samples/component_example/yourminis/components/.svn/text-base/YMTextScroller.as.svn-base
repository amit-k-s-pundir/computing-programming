package yourminis.components
{
	import yourminis.components.TextFieldScroll;
	import yourminis.components.StandardVerticalScroller;
	import yourminis.components.ScrollArea;
	import flash.display.Sprite;
	
	public class YMTextScroller extends Sprite
	{
		public var txt:TextFieldScroll;
		public var vscroll:StandardVerticalScroller;
		public var scrollarea:ScrollArea;
		public function YMTextScroller(_font:String="Verdana",_size:int=11,_color:uint=0xFFFFFF,initWidth:Number=100,initHeight:Number=100)
		{
			this.tabChildren = false;
			txt = new TextFieldScroll(_font,_size,_color);
			vscroll = new StandardVerticalScroller(_color,0.8,6,12);
			scrollarea = new ScrollArea(txt,vscroll,null,0,_color,0)
			txt.scrollArea = scrollarea;
			vscroll.scrollArea = scrollarea;
			addChild(scrollarea);
			addChild(vscroll);
			setSize(initWidth,initHeight);
		}
		public function setSize(w:Number, h:Number):void
		{
			scrollarea.setSize(w,h);
			txt.setSize(w-5);
		}
		public function set text(_text:String):void{txt.text = _text;}
		public function set htmlText(_text:String):void{txt.htmlText = _text;}
		public function get text():String{return txt.text;}
		public function get htmlText():String{return txt.htmlText;}
	}
}