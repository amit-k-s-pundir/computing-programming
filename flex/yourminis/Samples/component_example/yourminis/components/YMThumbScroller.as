package yourminis.components{
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.events.*;
	import flash.events.MouseEvent;
	import yourminis.utils.IndexedImageLoader;
	
	public class YMThumbScroller extends Sprite
	{
		public var this_mc;
		
		public var vertical:Boolean;
		public var spacing:Number;
		
		public var thumbHolder:Sprite;
		
		public var listWidth:Number;
		public var listHeight:Number;
		public var thumbWidth:Number;
		public var thumbHeight:Number;
		
		public var callBack:Function;
		
		public var targetX:Number;
		public var targetY:Number;

		
		public var curIndex:Number;
		
		public var init:Boolean;
		
		var ilArray:Array = new Array();
		
		
		
		public function YMThumbScroller(_thumbWidth, _thumbHeight, _callBack, _spacing:Number = 4, _vertical:Boolean = false) 
		{
			callBack = _callBack;
			init = false;
			this_mc = this;
			
			listWidth = 100;
			listHeight = 100;
			
			curIndex = 0;
			targetX = 0;
			targetY = 0;
			
			
			thumbHolder = new Sprite();
			this_mc.addChild(thumbHolder);
			
			thumbWidth = _thumbWidth;
			thumbHeight = _thumbHeight;
			
			spacing = _spacing;
			vertical = _vertical;
			
			
			addEventListener(Event.ENTER_FRAME,mainLoop);
		}
		
		private function mainLoop(evt:Event) {
			
			if (init) {
				if (vertical) {
					targetY = listHeight/2 - (curIndex*(thumbHeight+spacing) + thumbHeight/2);
				}
				else {
					targetX = listWidth/2 - (curIndex*(thumbWidth+spacing) + thumbWidth/2);
				}
				
				
				thumbHolder.x += (targetX-thumbHolder.x)/4;
				thumbHolder.y += (targetY-thumbHolder.y)/4;
				
			}
			
		}
		
		public function setIndex(ind) {
			curIndex = ind;
		}
		
		public function nextIndex() {
			curIndex++;
			if (curIndex == ilArray.length) curIndex = 0;
		}
		public function prevIndex() {
			curIndex--;
			if (curIndex == -1) curIndex = ilArray.length-1;
		}
		
		public function setArray(a:Array) {
			ilArray = [];
			
			var i;
			
			while(this_mc.thumbHolder.numChildren) {
				this_mc.thumbHolder.removeChildAt(0);
			}
			
			for (i = 0; i < a.length; i++) {
				ilArray.push(new IndexedImageLoader(i,clickit,a[i],thumbWidth,thumbHeight,true,false,true,0,0xFFFFFF,0x333333));
				thumbHolder.addChild(ilArray[i]);
				ilArray[i].frameAlpha = .4;
				ilArray[i].buttonMode = true;
			}
		}
		
		public function clickit(i) {
			setIndex(i);
			callBack(i);
		}
		
		public function setSize(w,h) {
			listWidth = w;
			listHeight = h;
			
			var i;
			
			if (vertical) {
				thumbWidth = w;
				for (i = 0; i < ilArray.length; i++) {
					ilArray[i].setSize(thumbWidth,thumbHeight);
					
					ilArray[i].x = 0;
					ilArray[i].y = i*(thumbHeight+spacing);
				}
			}
			else {
				thumbHeight = h;
				for (i = 0; i < ilArray.length; i++) {
					ilArray[i].setSize(thumbWidth,thumbHeight);
					
					ilArray[i].y = 0;
					ilArray[i].x = i*(thumbWidth+spacing);
				}
			}
			
			init = true;
		}
		
		
	}
}
