package yourminis.components 
{
	import flash.display.Sprite
	import flash.events.MouseEvent
	import flash.events.Event
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	
	public class VerticalScroller extends Sprite
	{
		public var percent:Number = 0;
		public var scrollFactor:Number;
		public var rowFactor:Number = 20;
		public var scrollArea:ScrollArea;
		public var scrollUpButton:Sprite;
		public var scrollDownButton:Sprite;
		public var scrollTrack:Sprite;
		public var scrollHandle:Sprite;
		public var scrollBarWidth:int;
		public var scrollBarHeight:int;
		public var arrowDim:Number;
		
		public function VerticalScroller(_scrollBarWidth:int,_arrowDim:Number=-1)
		{
			scrollBarWidth = _scrollBarWidth;
			if (_arrowDim == -1) arrowDim=scrollBarWidth;
			else arrowDim = _arrowDim;
			scrollDownButton = new Sprite();
			scrollUpButton = new Sprite();
			scrollHandle = new Sprite();
			scrollTrack = new Sprite();
			
			this.addChild(scrollTrack);
			this.addChild(scrollDownButton);
			this.addChild(scrollUpButton);
			this.addChild(scrollHandle);
			scrollHandle.y = arrowDim;
			//scrollHandle.x = 1;
			//scrollUpButton.x = scrollDownButton.x = -1;
			
			scrollHandle.addEventListener(MouseEvent.MOUSE_DOWN,scrollHandlePress);
			scrollUpButton.addEventListener(MouseEvent.MOUSE_DOWN,scrollUpPress);
			scrollDownButton.addEventListener(MouseEvent.MOUSE_DOWN,scrollDownPress);
			scrollUpButton.addEventListener(MouseEvent.CLICK,scrollUpClick);
			scrollDownButton.addEventListener(MouseEvent.CLICK,scrollDownClick);
			addEventListener(MouseEvent.MOUSE_WHEEL,mouseWheelMove);
			
		}
		private function scrollHandlePress(event:MouseEvent):void
		{
			event.stopPropagation();
			var dragRect:Rectangle = new Rectangle(scrollHandle.x,arrowDim,0,scrollBarHeight-scrollHandle.height-2*arrowDim);
			scrollHandle.startDrag(false,dragRect)
			root.addEventListener(MouseEvent.MOUSE_UP, scrollHandleRelease,false,0,true);
			root.addEventListener(MouseEvent.MOUSE_MOVE, scrollHandleMove,false,0,true);
		}
		private function scrollHandleRelease(event:MouseEvent):void
		{
			scrollHandle.stopDrag();
			root.removeEventListener(MouseEvent.MOUSE_UP, scrollHandleRelease);
			root.removeEventListener(MouseEvent.MOUSE_MOVE, scrollHandleMove);
		}
		private function scrollHandleMove(event:MouseEvent):void
		{
			percent = (scrollHandle.y-arrowDim)/(scrollBarHeight-scrollHandle.height-2*arrowDim);
			scrollArea.verticalScroll(percent);
		}
		public function setPos(perc) {
			percent = perc;
			scrollHandle.y = percent*(scrollBarHeight-scrollHandle.height-2*arrowDim)+arrowDim;
		}
		
		private function scrollUpPress(event:MouseEvent):void
		{
			event.stopPropagation();
			scrollFactor = -1 * (scrollArea.contentRowFactor/scrollArea.contentHeight);
			addEventListener(Event.ENTER_FRAME, scrollMove);
			root.addEventListener(MouseEvent.MOUSE_UP, scrollButtonRelease,false,0,true);
		}
		
		private function scrollDownPress(event:MouseEvent):void
		{
			event.stopPropagation();
			scrollFactor = (scrollArea.contentRowFactor/scrollArea.contentHeight);
			addEventListener(Event.ENTER_FRAME, scrollMove);
			root.addEventListener(MouseEvent.MOUSE_UP, scrollButtonRelease,false,0,true);
		}
		
		private function scrollUpClick(evt:MouseEvent) {
			scrollFactor = -1 * (scrollArea.contentRowFactor/scrollArea.contentHeight);
			scrollIt();
		}
		private function scrollDownClick(evt:MouseEvent) {
			scrollFactor = (scrollArea.contentRowFactor/scrollArea.contentHeight);
			scrollIt();
		}
		
		private function scrollButtonRelease(event:MouseEvent):void
		{
			root.removeEventListener(MouseEvent.MOUSE_UP, scrollButtonRelease);
			removeEventListener(Event.ENTER_FRAME,scrollMove);
		}
		
		public function mouseWheelMove(event:MouseEvent):void
		{
			scrollFactor = -event.delta*(scrollArea.contentRowFactor/scrollArea.contentHeight);
			scrollMove(event);
		}
		
		public function scrollMove(event:Event):void
		{
			scrollIt();
		}
		
		public function scrollIt() {
			percent += scrollFactor;
			percent = Math.max(0,percent);
			percent = Math.min(1,percent);
			scrollArea.verticalScroll(percent);
			scrollHandle.y = Math.round((scrollBarHeight-scrollHandle.height-2*arrowDim) * percent) + arrowDim;
		}

		
		
		
		public function updateScrollBar(horizontalVisibility:int):void
		{
			//scrollArea = _scrollArea;
		}
		
		
	}
}