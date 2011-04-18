package yourminis.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	import yourminis.api.Widget;
	import yourminis.components.ListCell;
	import yourminis.components.DropDownListCell;
	import yourminis.components.YMDropDown;
	import yourminis.components.YMCopyButton;
	import yourminis.components.YMColorPicker;
	
	public class YMChromeButtons extends Sprite
	{
		public var dropDown:YMDropDown;
		public var colorPicker:YMColorPicker;
		
		private var resizeHandle:Sprite;
		private var resizeLines:Sprite;
		private var resizeBorder:Sprite;
		private var close_btn:Sprite;
		private var edit_btn:Sprite;
		private var visuals_btn:Sprite;
		private var widget:Widget;
		
		private var chromeHeight:Number;
		private var chromeWidth:Number;
		
		public function YMChromeButtons(_widget:Widget)
		{
			this.visible = false;
			widget = _widget;
			close_btn = new Sprite();
			edit_btn = new Sprite();
			visuals_btn = new Sprite();
			resizeHandle = new Sprite();
			resizeLines = new Sprite();
			resizeBorder = new Sprite();
			
			edit_btn.visible = visuals_btn.visible = close_btn.visible = resizeHandle.visible = false;
			close_btn.y = edit_btn.y = visuals_btn.y = 8;
			
			drawButton(close_btn,[0xFF0000, 0xCC0000,0xAA0000,0x990000,0x770000]);
			drawButton(edit_btn,[0xAAAAAA,0x999999,0x666666,0x333333,0x000000]);
			drawButton(visuals_btn,[0xFF0000,0xFFCC00,0xFFFF00,0x00FF00,0x00FFFF]);
			drawButtonIcons();
			drawResizeHandle();
			close_btn.getChildAt(1).alpha = 0.4;
			edit_btn.getChildAt(1).alpha = 0.4;
			visuals_btn.getChildAt(1).alpha = 0.4;
			edit_btn.visible = visuals_btn.visible = false;
			close_btn.buttonMode = true;
			edit_btn.buttonMode = true;
			visuals_btn.buttonMode = true;
			resizeHandle.buttonMode = true;
			
			
			dropDown = new YMDropDown(edit_btn, true);
			colorPicker = new YMColorPicker(visuals_btn, widget.chrome.setTheme, true);
			
			this.addChild(edit_btn);
			this.addChild(visuals_btn);
			this.addChild(close_btn);
			this.addChild(resizeHandle);
			this.addChild(dropDown);
			this.addChild(colorPicker);
			
			resizeHandle.addChild(resizeLines);
			resizeHandle.addEventListener(MouseEvent.MOUSE_DOWN,resizeHandlePress);
			resizeHandle.addEventListener(MouseEvent.MOUSE_OVER,resizeHandleOver);
			resizeHandle.addEventListener(MouseEvent.MOUSE_OUT,resizeHandleOut);
			close_btn.addEventListener(MouseEvent.MOUSE_OVER,buttonOver);
			close_btn.addEventListener(MouseEvent.MOUSE_OUT,buttonOut);
			close_btn.addEventListener(MouseEvent.CLICK,closeRelease);
			edit_btn.addEventListener(MouseEvent.MOUSE_OVER,buttonOver);
			edit_btn.addEventListener(MouseEvent.MOUSE_OUT,buttonOut);
			visuals_btn.addEventListener(MouseEvent.MOUSE_OVER,buttonOver);
			visuals_btn.addEventListener(MouseEvent.MOUSE_OUT,buttonOut);
			dropDown.addEventListener(widget.DROPDOWN_LOADED, widget.onDropDownStarted);
			colorPicker.addEventListener(widget.WIDGET_THEMED, widget.onWidgetThemed);
			widget.chrome.addEventListener(MouseEvent.MOUSE_OVER,chromeOver);
			widget.chrome.addEventListener(MouseEvent.MOUSE_OUT,chromeOut);
			widget.addEventListener("widget-resized",setSize);
			widget.chrome.addEventListener("buttons-changed",chromeOver);
			widget.addTooltip(edit_btn,"Widget Options");
			widget.addTooltip(visuals_btn,"Widget Theme");
			
			var buttonFilter:DropShadowFilter = new DropShadowFilter(1, 45, 0, 1, 2, 2, 1, 3, false, true);
			var shadeFilter:DropShadowFilter = new DropShadowFilter(1, 45, 0, 1, 2, 2, 1.5, 3, false, false);
			
			close_btn.getChildAt(0).filters = [buttonFilter];
			edit_btn.getChildAt(0).filters = [buttonFilter];
			visuals_btn.getChildAt(0).filters = [buttonFilter];
			resizeLines.filters = [shadeFilter];
			
			setSize(new Event(""));
		}
				
		private function chromeOver(event:Event):void
		{
			var isVisible:Boolean = !widget.embedded && widget.chrome.enabled;
			close_btn.visible = isVisible && widget.chrome.closeEnabled;
			edit_btn.visible = isVisible && widget.chrome.editEnabled;
			visuals_btn.visible = isVisible && widget.chrome.visualsEnabled;
			resizeHandle.visible = isVisible && !widget.ajax && widget.chrome.resizable;
		}
		private function chromeOut(event:MouseEvent):void
		{
			close_btn.visible = false;
			edit_btn.visible = false;
			visuals_btn.visible = false
			resizeHandle.visible = false;
		}
		private function buttonOver(event:MouseEvent):void
		{
			var sprite:Sprite = Sprite(event.target);
			sprite.alpha = 1;
		}
		private function buttonOut(event:MouseEvent):void
		{
			var sprite:Sprite = Sprite(event.target);
			sprite.alpha = 0.4;
		}
		
		private function closeRelease(evt:MouseEvent){widget.chrome.dispatchEvent(new Event("widget-closed"));}
		
		private function resizeHandlePress(event:MouseEvent):void{
			event.stopPropagation();
			stage.addEventListener(MouseEvent.MOUSE_UP, resizeHandleRelease,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, resizeHandleMove,false,0,true);
		}
		private function resizeHandleRelease(event:MouseEvent):void{
			resizeBorder.graphics.clear();
			try{this.removeChild(resizeBorder);}
			catch(e:Error){}
			stage.removeEventListener(MouseEvent.MOUSE_UP, resizeHandleRelease);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, resizeHandleMove);
			widget.chrome.setSize(chromeWidth,chromeHeight);
		}
		private function resizeHandleMove(event:MouseEvent):void{redrawResizeBox();dispatchEvent(new Event("widget-resizing"));}
		private function resizeHandleOver(event:MouseEvent):void{}//show resize cursor
		private function resizeHandleOut(event:MouseEvent):void{}
		private function redrawResizeBox():void
		{
			try {removeChild(resizeBorder);}
			catch (e:Error){}
			addChild(resizeBorder);
			
			var x1 = 10*Math.floor(this.mouseX/10);
			var y1 = 10*Math.floor(this.mouseY/10);
			x1 = Math.max(x1,widget.chrome.boundsArray[0]+10)
			y1 = Math.max(y1,widget.chrome.boundsArray[1]+10)
			x1 = Math.min(x1,widget.chrome.boundsArray[2]+10);
			y1 = Math.min(y1,widget.chrome.boundsArray[3]+10);
			chromeWidth = x1+10*int(widget.chrome.shadowEnabled);
			chromeHeight = y1+10*int(widget.chrome.shadowEnabled);
			
			resizeBorder.graphics.clear();
			resizeBorder.graphics.lineStyle(4, 0x33CCFF);
			dashTo({x:0, y:0},{x:x1, y:0},2,10);
			dashTo({x:x1, y:0},{x:x1, y:y1},2,10);
			dashTo({x:x1, y:y1},{x:0, y:y1},2,10);
			dashTo({x:0, y:y1},{x:0, y:0},2,10);
		}
		private function drawResizeHandle():void
		{
			resizeHandle.graphics.beginFill(widget.chrome.chromeColor,0);
            resizeHandle.graphics.lineStyle(1, widget.chrome.chromeColor,0,true);
            resizeHandle.graphics.drawRect(-5, -5, 20, 20);
            resizeHandle.graphics.endFill();
			
			resizeLines.graphics.lineStyle(1, 0xFFFFFF,1,true);
			resizeLines.graphics.moveTo(10,0);
			resizeLines.graphics.lineTo(0,10);
			resizeLines.graphics.moveTo(10,3);
			resizeLines.graphics.lineTo(3,10);
			resizeLines.graphics.moveTo(10,6);
			resizeLines.graphics.lineTo(6,10);
		}
		
		private function drawButton(sprite:Sprite,colorArray:Array):void
		{
			var buttonSkin = new Sprite();
			var buttonShadow = new Sprite();
			sprite.addChild(buttonShadow);
			sprite.addChild(buttonSkin);
			
			buttonSkin.graphics.lineStyle(1.5, 0xFFFFFF,1,true,"none");
			var matr:Matrix = new Matrix();
			matr.createGradientBox(12, 12, Math.PI / 4, 0, 0);
			buttonSkin.graphics.beginGradientFill(GradientType.LINEAR, colorArray, [1, 1, 1, 1, 1], [0x00, 0x44, 0x88, 0xCC, 0xFF], matr, SpreadMethod.PAD);  
			buttonSkin.graphics.drawRoundRect(0, 0, 12, 12, 7);
			buttonSkin.graphics.endFill();
			
			buttonShadow.graphics.beginFill(0,1);
			buttonShadow.graphics.drawRoundRect(0, 0, 12, 12, 7);
			buttonShadow.graphics.endFill();
		}
		private function drawButtonIcons():void
		{
			var sprite = close_btn.getChildAt(1);
			sprite.graphics.lineStyle(1.5, 0xFFFFFF,1,true,"none");
			sprite.graphics.moveTo(4,4);
			sprite.graphics.lineTo(8,8);
			sprite.graphics.moveTo(8,4);
			sprite.graphics.lineTo(4,8);
			
			sprite = edit_btn.getChildAt(1);
			sprite.graphics.lineStyle(1.5, 0xFFFFFF,0,true,"none");
			sprite.graphics.beginFill(0xFFFFFF,1);
			sprite.graphics.moveTo(3,4);
			sprite.graphics.lineTo(9,4);
			sprite.graphics.lineTo(6,8);
			sprite.graphics.lineTo(3,4);
			sprite.graphics.endFill();
			
			sprite = close_btn.getChildAt(1);
		}
		private function dashTo(startPoint, destPoint, dashLength, spaceLength):void
		{
			var x = destPoint.x - startPoint.x;
			var y = destPoint.y - startPoint.y;
			var hyp = Math.sqrt((x)*(x) + (y)*(y));
			var units = hyp/(dashLength+spaceLength);
			var dashSpaceRatio = dashLength/(dashLength+spaceLength);
			var dashX = (x/units)*dashSpaceRatio;
			var spaceX = (x/units)-dashX;
			var dashY = (y/units)*dashSpaceRatio;
			var spaceY = (y/units)-dashY;
			resizeBorder.graphics.moveTo(startPoint.x, startPoint.y);
			while (hyp > 0) {
					startPoint.x += dashX;
					startPoint.y += dashY;
					hyp -= dashLength;
					if (hyp < 0) {
							startPoint.x = destPoint.x;
							startPoint.y = destPoint.y;
					}
					resizeBorder.graphics.lineTo(startPoint.x, startPoint.y);
					startPoint.x += spaceX;
					startPoint.y += spaceY;
					resizeBorder.graphics.moveTo(startPoint.x, startPoint.y);
					hyp -= spaceLength;
			}
			resizeBorder.graphics.moveTo(destPoint.x, destPoint.y);
		}
		public function setSize(evt:Event):void
		{
			var w:Number = widget.chrome.width;
			var h:Number = widget.chrome.height;
			resizeHandle.x = w - 13;
			resizeHandle.y = h - 13;
			close_btn.x = w - 20;
			edit_btn.x = w - 20*(2-int(!widget.chrome.closeEnabled));
			visuals_btn.x = w - 20*(3-int(!widget.chrome.editEnabled)-int(!widget.chrome.closeEnabled));
			this.visible = true;
		}
	}
	
}