package yourminis.components {
	
	import flash.display.Graphics
	import flash.display.JointStyle
	import flash.display.SpreadMethod
	import flash.display.GradientType
	import flash.geom.Matrix
	import flash.geom.ColorTransform
	import flash.filters.DropShadowFilter
	import flash.display.*;
	
	public class FancyVerticalScroller extends VerticalScroller
	{
		private var fillColor:uint;
		public var fillColor2:uint;
		private var fillAlpha:Number;
		private var cornerRadius:int;
		public var scrollBack:Sprite;
		
		public function FancyVerticalScroller(_fillColor:uint,_fillAlpha:Number,_cornerRadius:int,_scrollBarWidth:int)
		{
			super(_scrollBarWidth);
			fillColor = _fillColor;
			fillAlpha = _fillAlpha;
			fillColor2 = 0xDDDDDD;
			scrollBack = new Sprite();
			addChildAt(scrollBack,0);
			cornerRadius = _cornerRadius;
			drawButtons();
			scrollUpButton.buttonMode = true;
			scrollDownButton.buttonMode = true;
		}
		
		private function drawButtons():void
		{
			scrollBarWidth -= 2;
			with (scrollDownButton.graphics) {
				clear();
				beginFill(0,0);
				drawRect(0,0,scrollBarWidth,scrollBarWidth);
				endFill();
				
				beginFill(fillColor,fillAlpha);
				drawEllipse(1,1,scrollBarWidth-2,scrollBarWidth-2);
				endFill();
				
				//lineStyle(0, 0xFFFFFF,1,true,"none",null,JointStyle.ROUND);
				beginFill(0xFFFFFF,fillAlpha);
				moveTo(3,5);
				lineTo(scrollBarWidth-3,5);
				lineTo(scrollBarWidth/2,scrollBarWidth-4);
				lineTo(3,5);
				endFill();
			}
			
			with (scrollUpButton.graphics) {
				clear();
				
				beginFill(0,0);
				drawRect(0,0,scrollBarWidth,scrollBarWidth);
				endFill();
				
				beginFill(fillColor,fillAlpha);
				drawEllipse(1,1,scrollBarWidth-2,scrollBarWidth-2);
				endFill();
				
				//lineStyle(0, 0xFFFFFF,1,true,"none");
				beginFill(0xFFFFFF,fillAlpha);
				moveTo(3,scrollBarWidth-5);
				lineTo(scrollBarWidth-3,scrollBarWidth-5);
				lineTo(scrollBarWidth/2,4);
				lineTo(3,scrollBarWidth-5);
				endFill();
			}
			scrollBarWidth += 2;
		}
		
		function drawScrollHandle():void
		{
			scrollBarWidth -= 2;
			var newHandleHeight = Math.max(20,((scrollBarHeight-2*scrollBarWidth)/scrollArea.contentHeight)*(scrollBarHeight-2*scrollBarWidth));
			var matr = new Matrix();
			var matr2 = new Matrix();
			matr.createGradientBox(scrollBarWidth-1, newHandleHeight, 0, 0, 0);
			matr2.createGradientBox(scrollBarWidth-1, scrollBarHeight, 0, 0, 0);
			
			with(scrollHandle.graphics) {
				clear();
				lineStyle(1, fillColor,0.5,true,"none");
				beginFill(fillColor,fillAlpha);  
				drawRoundRect(0, 0, scrollBarWidth-1, newHandleHeight, cornerRadius*2);
				endFill();
				lineStyle(1, fillColor,0,true,"none");
				beginGradientFill(GradientType.LINEAR, [0x333333, 0xFFFFFF], [Math.max(fillAlpha-0.5,0), 0], [0x00, 0xAA], matr, SpreadMethod.PAD);  
				drawRoundRect(0, 0, scrollBarWidth-1, newHandleHeight, cornerRadius*2);
				endFill();
			}
			scrollBarWidth += 2;
			
			with(scrollBack.graphics) {
				clear();
				lineStyle(1, fillColor2,0.5,true,"none");
				beginFill(fillColor2,fillAlpha);  
				drawRoundRect(-1, -1, scrollBarWidth-1, scrollBarHeight, cornerRadius*2);
				endFill();
				lineStyle(1, fillColor2,0,true,"none");
				beginGradientFill(GradientType.LINEAR, [0x333333, 0xFFFFFF], [Math.max(fillAlpha-0.5,0), 0], [0x00, 0xAA], matr, SpreadMethod.PAD);  
				drawRoundRect(-1, -1, scrollBarWidth-1, scrollBarHeight, cornerRadius*2);
				endFill();
			}
		}
		public override function updateScrollBar(horizontalVisibility:int):void
		{
			scrollBarHeight = scrollArea.scrollAreaHeight - horizontalVisibility * scrollBarWidth - 2;
			drawScrollHandle();
			scrollHandle.y = (scrollBarHeight-scrollHandle.height-2*scrollBarWidth) * percent + scrollBarWidth;
			scrollDownButton.y = scrollBarHeight - scrollBarWidth; 
			this.x = scrollArea.scrollAreaWidth+scrollArea.x-scrollBarWidth+5;
			this.y = scrollArea.y;
			scrollArea.verticalScroll(percent);
		}
		
		
		
	}
}