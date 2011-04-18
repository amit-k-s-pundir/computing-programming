package yourminis.components 
{
	import flash.display.Sprite
	import flash.events.MouseEvent
	import flash.events.Event
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	
	public class HorizontalScroller extends Sprite
	{
		public var percent:Number = 0;
		public var scrollFactor:int;
		public var scrollArea:ScrollArea;
		public var scrollLeftButton:Sprite;
		public var scrollRightButton:Sprite;
		public var scrollHandle:Sprite;
		public var scrollBarWidth:int;
		public var scrollBarHeight:int;

		public function HorizontalScroller(_scrollBarHeight:int)
		{
			scrollBarHeight = _scrollBarHeight;
			scrollRightButton = new Sprite();
			scrollLeftButton = new Sprite();
			scrollHandle = new Sprite();
			this.addChild(scrollRightButton);
			this.addChild(scrollLeftButton);
			this.addChild(scrollHandle);
			scrollHandle.x = scrollBarHeight;
			//scrollHandle.x = 1;
			//scrollUpButton.x = scrollDownButton.x = -1;
			
			scrollHandle.addEventListener(MouseEvent.MOUSE_DOWN,scrollHandlePress);
			scrollLeftButton.addEventListener(MouseEvent.MOUSE_DOWN,scrollLeftPress);
			scrollRightButton.addEventListener(MouseEvent.MOUSE_DOWN,scrollRightPress);
			
		}
		private function scrollHandlePress(event:MouseEvent):void
		{
			event.stopPropagation();
			var dragRect:Rectangle = new Rectangle(scrollBarHeight,scrollHandle.y,scrollBarWidth-scrollHandle.width-2*scrollBarHeight,0);
			scrollHandle.startDrag(false,dragRect)
			stage.addEventListener(MouseEvent.MOUSE_UP, scrollHandleRelease,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, scrollHandleMove,false,0,true);
		}
		private function scrollHandleRelease(event:MouseEvent):void
		{
			scrollHandle.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, scrollHandleRelease);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, scrollHandleMove);
		}
		private function scrollHandleMove(event:MouseEvent):void
		{
			percent = (scrollHandle.x-scrollBarHeight)/(scrollBarWidth-scrollHandle.width-2*scrollBarHeight);
			scrollArea.horizontalScroll(percent);
		}
		public function setPos(perc) {
			percent = perc;
			scrollHandle.x = percent*(scrollBarWidth-scrollHandle.width-2*scrollBarHeight)+scrollBarHeight;
		}
		
		private function scrollLeftPress(event:MouseEvent):void
		{
			event.stopPropagation();
			scrollFactor = -1;
			addEventListener(Event.ENTER_FRAME, scrollMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, scrollButtonRelease,false,0,true);
		}
		
		private function scrollRightPress(event:MouseEvent):void
		{
			event.stopPropagation();
			scrollFactor = 1;
			addEventListener(Event.ENTER_FRAME, scrollMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, scrollButtonRelease,false,0,true);
		}
		
		private function scrollButtonRelease(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, scrollButtonRelease);
			removeEventListener(Event.ENTER_FRAME,scrollMove);
		}
		
		public function scrollMove(event:Event):void
		{
			percent += scrollFactor*0.1;
			percent = Math.max(0,percent);
			percent = Math.min(1,percent);
			scrollArea.horizontalScroll(percent);
			scrollHandle.x = Math.round((scrollBarWidth-scrollHandle.width-2*scrollBarHeight) * percent) + scrollBarHeight;
		}

		
		
		
		public function updateScrollBar(verticalVisibility:int):void
		{
			//scrollArea = _scrollArea;
		}
		
		
	}
}