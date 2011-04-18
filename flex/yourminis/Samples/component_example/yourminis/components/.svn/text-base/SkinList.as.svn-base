package yourminis.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class SkinList extends Sprite
	{
		public var this_mc;
		public var cellType:Class;
		public var scrollType:Class;
		public var enableScroll:Boolean;
		public var cornerRadius:Number;
		public var dataArray:Array;
		public var scrollSpeed:uint;
		public var scrolling:Boolean;
		public var percentage:Number;
		public var cellHeight:Number;
		public var scrollModifier:Number;
		
		private var w;
		private var h;
		private var cells:Sprite;
		private var cellArray:Array;
		private var scrollbar;
		private var myMask:Sprite;
		private var myMask2:Sprite;
		private var totalHeight;
		private var parent_mc;
		private var currentScroll:Number //in pixels
		
		private var scrollTop:Sprite;
		private var scrollMid:Sprite;
		private var scrollBot:Sprite;
		private var scrollTopO:Sprite;
		private var scrollMidO:Sprite;
		private var scrollBotO:Sprite;
		
		private var scrollBut:Sprite;
		
		private var butTop:Sprite;
		private var butMid:Sprite;
		private var butBot:Sprite;
		private var butTopO:Sprite;
		private var butMidO:Sprite;
		private var butBotO:Sprite;
		
		private var leeway;
		private var buttonDown;
		
		
		public function SkinList(_parent_mc, _w, _h, _cellHeight, _cellType:Class,_scrollType:Class,_cornerRadius:Number,_enableScroll:Boolean, _dataArray:Array)
		{
			this_mc = this;
			parent_mc = _parent_mc;
			dataArray = _dataArray;
			cellType = _cellType;
			scrollType = _scrollType;
			cornerRadius = _cornerRadius;
			enableScroll = _enableScroll;
			cellHeight = _cellHeight;
			
			
			w = _w;
			h = _h;
			
			
			scrollSpeed = 6;
			scrolling = false;
			buttonDown = false;
			percentage = 0;
			
			cells = new Sprite();
			addChild(cells);
			cells.x = 0;
			cells.y = 0;
			
			
			scrollbar = new scrollType();
			addChild(scrollbar);
			
			
			myMask = new Sprite();
			addChild(myMask);
			cells.mask = myMask;
			myMask2 = new Sprite();
			addChild(myMask2);
			scrollbar.mask = myMask2;
			
			
			scrollTop = scrollbar["scrollTop"];
			scrollMid = scrollbar["scrollMid"];
			scrollBot = scrollbar["scrollBot"];
			scrollTopO = scrollbar["scrollTop"]["over"];
			scrollMidO = scrollbar["scrollMid"]["over"];
			scrollBotO = scrollbar["scrollBot"]["over"];
			
			scrollBut = scrollbar["scrollBut"];
			
			butTop = scrollbar["scrollBut"]["butTop"];
			butMid = scrollbar["scrollBut"]["butMid"];
			butBot = scrollbar["scrollBut"]["butBot"];
			butTopO = scrollbar["scrollBut"]["butTop"]["over"];
			butMidO = scrollbar["scrollBut"]["butMid"]["over"];
			butBotO = scrollbar["scrollBut"]["butBot"]["over"];
			
			scrollTopO.visible = false;
			scrollMidO.visible = false;
			scrollBotO.visible = false;
			
			butTopO.visible = false;
			butMidO.visible = false;
			butBotO.visible = false;
			
			scrollBut.buttonMode = true;
			scrollTop.buttonMode = true;
			scrollMid.buttonMode = true;
			scrollBot.buttonMode = true;
			
			scrollTop.addEventListener(MouseEvent.ROLL_OVER, scrollTopOver);
			scrollTop.addEventListener(MouseEvent.ROLL_OUT, scrollTopOut);
			scrollTop.addEventListener(MouseEvent.CLICK, scrollTopClick);
			function scrollTopOver(evt:MouseEvent) {scrollTopO.visible = true;}
			function scrollTopOut(evt:MouseEvent) {scrollTopO.visible = false;}
			function scrollTopClick(evt:MouseEvent) {}
			scrollTop.addEventListener(MouseEvent.MOUSE_DOWN, scrollTopDown);
			scrollTop.addEventListener(MouseEvent.MOUSE_UP, scrollTopRelease);
			function scrollTopDown(evt:MouseEvent) {scrollMod(evt,-1)}
			function scrollTopRelease(evt:MouseEvent) {endScrollMod(evt);}
			
			scrollMid.addEventListener(MouseEvent.ROLL_OVER, scrollMidOver);
			scrollMid.addEventListener(MouseEvent.ROLL_OUT, scrollMidOut);
			scrollMid.addEventListener(MouseEvent.CLICK, scrollMidClick);
			function scrollMidOver(evt:MouseEvent) {scrollMidO.visible = true;}
			function scrollMidOut(evt:MouseEvent) {scrollMidO.visible = false;}
			function scrollMidClick(evt:MouseEvent) {}
			scrollMid.addEventListener(MouseEvent.MOUSE_DOWN, scrollMidDown);
			scrollMid.addEventListener(MouseEvent.MOUSE_UP, scrollMidRelease);
			function scrollMidDown(evt:MouseEvent) {beginScroll(evt,true);}
			function scrollMidRelease(evt:MouseEvent) {endScroll(evt);}
			
			scrollBot.addEventListener(MouseEvent.ROLL_OVER, scrollBotOver);
			scrollBot.addEventListener(MouseEvent.ROLL_OUT, scrollBotOut);
			scrollBot.addEventListener(MouseEvent.CLICK, scrollBotClick);
			function scrollBotOver(evt:MouseEvent) {scrollBotO.visible = true;}
			function scrollBotOut(evt:MouseEvent) {scrollBotO.visible = false;}
			function scrollBotClick(evt:MouseEvent) {}
			scrollBot.addEventListener(MouseEvent.MOUSE_DOWN, scrollBotDown);
			scrollBot.addEventListener(MouseEvent.MOUSE_UP, scrollBotRelease);
			function scrollBotDown(evt:MouseEvent) {scrollMod(evt,1);}
			function scrollBotRelease(evt:MouseEvent) {endScrollMod(evt);}
			
			
			function scrollMod(evt:MouseEvent,num) {
				scrollModifier = num;
				buttonDown = true;
				evt.stopImmediatePropagation();
			}
			function endScrollMod(evt:MouseEvent) {
				scrollModifier = 0;
				buttonDown = false;
				evt.stopImmediatePropagation();
			}
			
			
			scrollBut.addEventListener(MouseEvent.ROLL_OVER, scrollButOver);
			scrollBut.addEventListener(MouseEvent.ROLL_OUT, scrollButOut);
			scrollBut.addEventListener(MouseEvent.MOUSE_DOWN, scrollButDown);
			
			function scrollButOver(evt:MouseEvent) {butTopO.visible = butMidO.visible = butBotO.visible = true;}
			function scrollButOut(evt:MouseEvent) {butTopO.visible = butMidO.visible = butBotO.visible = false;}
			function scrollButDown(evt:MouseEvent) {
				beginScroll(evt,false);
			}
			
			//this_mc.addEventListener(MouseEvent.MOUSE_UP, endScroll);
			parent_mc.addEventListener(MouseEvent.MOUSE_UP, scrollbarRelease2);
			//parent_mc.parent.parent.parent.parent.parent.addEventListener(MouseEvent.MOUSE_UP, scrollbarRelease);
			function scrollbarRelease2(evt:MouseEvent) {endScroll(evt,false)}
			
			function beginScroll(evt:MouseEvent,bool) {
				var myRect:Rectangle = new Rectangle(scrollBut.x,scrollMid.y,0,scrollMid.height-scrollBut.height)
				scrollBut.startDrag(bool,myRect);
				scrolling = true;
				evt.stopImmediatePropagation();
			}
			function endScroll(evt:MouseEvent,bool=true) {
				scrollBut.stopDrag();
				scrolling = false;
				if (bool) {
					evt.stopImmediatePropagation();
				}
			}
			
			
			setSize(w,h,true);
			
			addEventListener(Event.ENTER_FRAME, mainLoop);
			
		}
		
		private function mainLoop(evt:Event) {
			if (scrolling) {
				percentage = (scrollBut.y-scrollMid.y)/(scrollMid.height-scrollBut.height);
				cells.y = -percentage*(totalHeight-h)
			}
			if (buttonDown) {
				percentage = Math.max(Math.min(percentage+scrollModifier*scrollSpeed/totalHeight,1),0)
				scrollBut.y = percentage*(scrollMid.height-scrollBut.height) + scrollMid.y;
				cells.y = -percentage*(totalHeight-h)
			}
		}
		
		public function setSize(__width:Number,__height:Number,bRefresh:Boolean = false) {
			w = __width;
			h = __height;
			
			/*
			percentage = 0;
			cells.y = 0;
			scrollBut.y = scrollMid.y;
			*/
			
			refreshList(bRefresh);
		}
		
		public function refreshList(bRefresh:Boolean = false) {
			
			var i;
			
			if (bRefresh) {
				
				percentage = 0;
				cells.y = 0;
				scrollBut.y = scrollMid.y;
				
				
				cellArray = [];
				while (cells.numChildren) {
					cells.removeChildAt(0);
				}
				
				for (i = 0; i < dataArray.length; i++) {
					cellArray.push(new cellType());
					cells.addChild(cellArray[i]);
					cellArray[i]["onInit"](parent_mc,i,dataArray[i]);
				}
			}
			
			
			scrollbar.x = w-scrollbar.width;
			scrollbar.y = 0;
			
			for (i = 0; i < cells.numChildren; i++) {
				cellArray[i]["onResize"](w,cellHeight);
			}
			
			
			myMask.graphics.clear();
			myMask.graphics.beginFill(0xFF0000);
			myMask.graphics.drawRoundRect(0,0,w,h,cornerRadius);
			myMask.graphics.endFill();
			myMask2.graphics.clear();
			myMask2.graphics.beginFill(0xFF0000);
			myMask2.graphics.drawRoundRect(0,0,w,h,cornerRadius);
			myMask2.graphics.endFill();
			
			totalHeight = 0;
			for (i = 0; i < cells.numChildren; i++) {
				cellArray[i].y=totalHeight;
				totalHeight += cellArray[i].cellHeight;
			}
			if ( (totalHeight > h) && (enableScroll) ) {
				scrollbar.visible = true;
			}
			else {
				scrollbar.visible = false;
			}
			
			var resultWidth = w-((scrollbar.width)*Number(scrollbar.visible));
			
			for (i = 0; i < cells.numChildren; i++) {
				cellArray[i]["onResize"](resultWidth,cellHeight);
			}
			
			if (scrollbar.visible) {
				scrollMid.height = h - scrollTop.height*2;
				scrollBot.y = scrollMid.height + scrollMid.y;
				leeway = scrollMid.height-butTop.height*2;
				
				butMid.height = (h/totalHeight)*leeway;
				butBot.y = butMid.y + butMid.height;
				
				scrollBut.y = scrollTop.height+percentage*(scrollMid.height-scrollBut.height);
				
			}
			
			
			
		}
		
	}
}