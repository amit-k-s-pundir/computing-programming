package yourminis.components
{
	import yourminis.components.YMList;
	import yourminis.components.StandardVerticalScroller;
	import yourminis.components.FancyVerticalScroller;
	//import yourminis.components.SlideVerticalScroller;
	import yourminis.components.ScrollArea;
	import flash.display.Sprite;
	public class YMListScroller extends Sprite
	{
		public var vscroll:VerticalScroller;
		public var scrollarea:ScrollArea;
		public var list:YMList;
		public function YMListScroller(_fillColor:uint=0xFFFFFF,_fillAlpha:Number=0.8,_cornerRadius:int=6,_scrollBarWidth:int=12,scrollClass:String="StandardVerticalScroller")
		{
			this.tabChildren = false;
			list = new YMList();
			
			switch(scrollClass) {
				case "StandardVerticalScroller":
					vscroll = new StandardVerticalScroller(_fillColor,_fillAlpha,_cornerRadius,_scrollBarWidth);
				break;
				case "FancyVerticalScroller":
					vscroll = new FancyVerticalScroller(_fillColor,_fillAlpha,_cornerRadius,_scrollBarWidth);
				break;
				case "SlideVerticalScroller":
					vscroll = new SlideVerticalScroller(_fillColor,_fillAlpha,_cornerRadius,_scrollBarWidth);
				break;
			}
			
			scrollarea = new ScrollArea(list,vscroll,null,0,_fillColor,0);
			addChild(scrollarea);
			addChild(vscroll);
			vscroll.scrollArea = scrollarea;
			list.scrollArea = scrollarea;
			list.setDimensions(false,1);
		}
		public function setSize(w:Number, h:Number):void
		{
			scrollarea.setSize(w,h);
			list.setSize(scrollarea.maskAreaWidth,h);
		}
	}
}