package yourminis.components {
	
	import yourminis.components.HorizontalScroller
	import yourminis.components.VerticalScroller
	import flash.events.MouseEvent
	import flash.display.Shape
	import flash.display.Sprite
	import flash.text.TextField
	import flash.events.Event
	
	public class ScrollArea extends Sprite
	{
		
		private var vScroller:VerticalScroller;
		private var hScroller:HorizontalScroller;
		private var scrollAreaMask:Shape;
		private var scrollAreaBackground:Shape;
		private var scrollAreaContent:*;
		private var scrollAreaColor:uint;
		private var cornerRadius:int;
		private var scrollAreaAlpha:Number;
		
		public var scrollAreaWidth:int=100;
		public var scrollAreaHeight:int=100;
		public var maskAreaHeight:int=100;
		public var maskAreaWidth:int=100;
		public var contentWidth:int=100;
		public var contentHeight:int=100;
		public var contentRowFactor:int = 25;
		
		private var sliding:Boolean;
		private var targetX:Number;
		private var targetY:Number;
		
		//set dimensions of scrollbars
		//check if scrollbars needed
		//set size of scrollarea
		//update scrollbar
		//update objects inside
		//

		public function ScrollArea(_scrollAreaContent:*,_vScroller:VerticalScroller,_hScroller:HorizontalScroller,_cornerRadius:int,_scrollAreaColor:uint,_scrollAreaAlpha:Number)
		{
			sliding = false;
			targetX = 0;
			targetY = 0;
			scrollAreaContent = _scrollAreaContent;
			vScroller = _vScroller;
			hScroller = _hScroller;
			cornerRadius = _cornerRadius;
			scrollAreaColor = _scrollAreaColor;
			scrollAreaAlpha = _scrollAreaAlpha;
			scrollAreaMask = new Shape();
			scrollAreaBackground = new Shape();
			this.addChild(scrollAreaBackground);
			this.addChild(scrollAreaContent);
			this.addChild(scrollAreaMask);
			scrollAreaContent.mask = scrollAreaMask;
			addEventListener(MouseEvent.MOUSE_WHEEL,mouseWheelMove);
			addEventListener(Event.ENTER_FRAME, onEnter);
		}
		public function onEnter(evt:Event) {
			if (sliding) {
				var xmod = (targetX-scrollAreaContent.x)/4;
				var ymod = (targetY-scrollAreaContent.y)/4;
				
				
				
				scrollAreaContent.x += xmod;
				scrollAreaContent.y += ymod;
				
				/*var sx = scrollAreaContent.x;
				var sy = scrollAreaContent.y;
				var mw = scrollAreaMask.width;
				var mh = scrollAreaMask.height;
				var cw = scrollAreaContent.width;
				var ch = scrollAreaContent.height;
				
				sx = Math.max(sx,-(cw-mw));
				//sx = Math.max(sx,0);
				sy = Math.max(sy,-(ch-mh));
				//sy = Math.max(sy,0);
				
				scrollAreaContent.x = sx;
				scrollAreaContent.y = sy;
				*/
				
				var perc;
				if (vScroller) {
					perc = Math.min(Math.max(scrollAreaContent.y/(maskAreaHeight - contentHeight),0), 1);
					vScroller.setPos(perc);
				}
				if (hScroller) {
					perc = Math.min(Math.max(0,scrollAreaContent.x/(maskAreaWidth - contentWidth)), 1);
					hScroller.setPos(perc);
				}
				
				//if (xmod > .1 && ymod > .1) {
				//	
				//}
				//else sliding = false;
			}
		}
		
		public function slideTo(tx:*=null,ty:*=null,bypage:Boolean=false) {
			var pxmod = 1;
			var pymod = 1;
			if (bypage) {
				pxmod = maskAreaWidth;
				pymod = maskAreaHeight;
			}
			if (tx != null) targetX = -tx*pxmod;
			if (ty != null) targetY = -ty*pymod;
			sliding = true;
		}
		
		public function setSize(newWidth:int, newHeight:int):void
		{
			scrollAreaWidth = maskAreaWidth = newWidth;
			scrollAreaHeight = maskAreaHeight = newHeight;
			if (vScroller) maskAreaWidth = scrollAreaWidth-(int(vScroller.visible) * vScroller.scrollBarWidth);
			if (hScroller && hScroller.scrollHandle.width) maskAreaHeight = scrollAreaHeight-(int(hScroller.visible) * hScroller.scrollBarHeight);

			scrollAreaContent.setSize(maskAreaWidth,maskAreaHeight);
			redrawScrollArea();
		}
		
		public function horizontalScroll(percent:Number):void
		{
			var totalWidth:Number = contentWidth - maskAreaWidth;
			targetX = scrollAreaContent.x = -1*Math.round(percent*totalWidth);
			
		}
		public function verticalScroll(percent:Number):void
		{
			var totalHeight:Number = contentHeight - maskAreaHeight;
			targetY = scrollAreaContent.y = -1*Math.round(percent*totalHeight);
		}
		public function updateScrollBars(newContentWidth:Number,newContentHeight:Number,reset:Boolean=true):void
		{
			contentWidth = newContentWidth;
			contentHeight = newContentHeight;
			var oldVerticalVisibility:Boolean = false;
			var newVerticalVisibility:Boolean = false;
			var oldHorizontalVisibility:Boolean = false;
			var newHorizontalVisibility:Boolean = false;
			
			if (vScroller) 
			{
				oldVerticalVisibility = vScroller.visible; 
				vScroller.visible = newVerticalVisibility = (contentHeight > scrollAreaHeight); 
				if (!newVerticalVisibility || reset) {
					vScroller.percent = 0;
					targetY = scrollAreaContent.y = 0;
				}
				else if (scrollAreaContent.y + contentHeight < scrollAreaHeight) {
					targetY = scrollAreaContent.y = scrollAreaHeight - contentHeight;
				}
			}
			if (hScroller)
			{
				oldHorizontalVisibility = hScroller.visible; 
				hScroller.visible = newHorizontalVisibility = (contentWidth > scrollAreaWidth);
				if (!newHorizontalVisibility || reset) {
					hScroller.percent = 0;
					targetX = scrollAreaContent.x = 0;
				}
				else if (scrollAreaContent.x + contentWidth < scrollAreaWidth) {
					targetX = scrollAreaContent.x = scrollAreaWidth - contentWidth;
				}
			}
			
			
			if (vScroller) vScroller.updateScrollBar(int(newHorizontalVisibility));
			if (hScroller) hScroller.updateScrollBar(int(newVerticalVisibility));
			if (oldVerticalVisibility != newVerticalVisibility || oldHorizontalVisibility != newHorizontalVisibility) setSize(scrollAreaWidth,scrollAreaHeight);
			
		}
		
		private function redrawScrollArea():void
		{
			
			scrollAreaMask.graphics.clear();
			scrollAreaMask.graphics.beginFill(scrollAreaColor,scrollAreaAlpha);
            scrollAreaMask.graphics.lineStyle(0, scrollAreaColor,0,true);
            scrollAreaMask.graphics.drawRoundRect(0, 0, maskAreaWidth, maskAreaHeight, cornerRadius*2);
            scrollAreaMask.graphics.endFill();
			
			scrollAreaBackground.graphics.clear();
			scrollAreaBackground.graphics.beginFill(scrollAreaColor,scrollAreaAlpha);
            scrollAreaBackground.graphics.lineStyle(0, scrollAreaColor,0,true);
            scrollAreaBackground.graphics.drawRoundRect(0, 0, scrollAreaWidth, scrollAreaHeight, cornerRadius*2);
            scrollAreaBackground.graphics.endFill();
			
		}
		
		public function mouseWheelMove(event:MouseEvent):void
		{
			if (vScroller)
			{
				vScroller.scrollFactor = -event.delta*(contentRowFactor/contentHeight);
				if (vScroller.visible) vScroller.scrollMove(event);
			}
		}
	}
	
}