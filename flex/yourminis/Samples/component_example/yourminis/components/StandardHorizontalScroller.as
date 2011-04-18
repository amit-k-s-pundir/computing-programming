package yourminis.components {
	
	import flash.display.Graphics
	import flash.display.JointStyle
	import flash.display.SpreadMethod
	import flash.display.GradientType
	import flash.geom.Matrix
	import flash.geom.ColorTransform
	import flash.filters.DropShadowFilter
	
	public class StandardHorizontalScroller extends HorizontalScroller
	{
		private var fillColor:uint;
		private var fillAlpha:Number;
		private var cornerRadius:int;
		
		public function StandardHorizontalScroller(_fillColor:uint,_fillAlpha:Number,_cornerRadius:int,_scrollBarWidth:int)
		{
			super(_scrollBarWidth);
			fillColor = _fillColor;
			fillAlpha = _fillAlpha;
			cornerRadius = _cornerRadius;
			drawButtons();
		}
		
		private function drawButtons():void
		{
			scrollRightButton.graphics.beginFill(0,0);
			scrollRightButton.graphics.drawRect(0,0,scrollBarHeight,scrollBarHeight);
			scrollRightButton.graphics.endFill();
			
			scrollRightButton.graphics.lineStyle(1, fillColor,1,true,"none",null,JointStyle.ROUND);
			scrollRightButton.graphics.beginFill(fillColor,fillAlpha);
			scrollRightButton.graphics.moveTo(3,2);
			scrollRightButton.graphics.lineTo(3,scrollBarHeight-3);
			scrollRightButton.graphics.lineTo(scrollBarHeight-4,scrollBarHeight/2);
			scrollRightButton.graphics.lineTo(scrollBarHeight-4,scrollBarHeight/2-1);
			scrollRightButton.graphics.lineTo(3,2);
			scrollRightButton.graphics.endFill();
			
			scrollLeftButton.graphics.beginFill(0,0);
			scrollLeftButton.graphics.drawRect(0,0,scrollBarHeight,scrollBarHeight);
			scrollLeftButton.graphics.endFill();
			
			scrollLeftButton.graphics.lineStyle(1, fillColor,1,true,"none");
			scrollLeftButton.graphics.beginFill(fillColor,fillAlpha);
			scrollLeftButton.graphics.moveTo(scrollBarHeight-3,2);
			scrollLeftButton.graphics.lineTo(scrollBarHeight-3,scrollBarHeight-3);
			scrollLeftButton.graphics.lineTo(4,scrollBarHeight/2);
			scrollLeftButton.graphics.lineTo(4,scrollBarHeight/2-1);
			scrollLeftButton.graphics.lineTo(scrollBarHeight-3,2);
			scrollLeftButton.graphics.endFill();
		}
		
		function drawScrollHandle():void
		{
			var newHandleWidth = Math.max(20,((scrollBarWidth-2*scrollBarHeight)/scrollArea.contentWidth)*(scrollBarWidth-2*scrollBarHeight));
			
			scrollHandle.graphics.clear();
			scrollHandle.graphics.lineStyle(1, fillColor,0.5,true,"none");
			scrollHandle.graphics.beginFill(fillColor,fillAlpha);  
			scrollHandle.graphics.drawRoundRect(0, 0, newHandleWidth, scrollBarHeight-1, cornerRadius*2);
			scrollHandle.graphics.endFill();
			
			scrollHandle.graphics.lineStyle(1, fillColor,0,true,"none");
			var matr = new Matrix();
			matr.createGradientBox(newHandleWidth,scrollBarHeight-1 , Math.PI/2, 0, 0);
			scrollHandle.graphics.beginGradientFill(GradientType.LINEAR, [0x333333, 0xFFFFFF], [0.3, 0], [0x00, 0xAA], matr, SpreadMethod.PAD);  
			scrollHandle.graphics.drawRoundRect(0, 0, newHandleWidth, scrollBarHeight-1, cornerRadius*2);
			scrollHandle.graphics.endFill();
		}
		public override function updateScrollBar(verticalVisibility:int):void
		{
			scrollBarWidth = scrollArea.scrollAreaWidth - verticalVisibility * scrollBarHeight - 2;
			drawScrollHandle();
			scrollHandle.x = (scrollBarWidth-scrollHandle.width-2*scrollBarHeight) * percent + scrollBarHeight;
			scrollRightButton.x = scrollBarWidth - scrollBarHeight; 
			this.y = scrollArea.scrollAreaHeight+scrollArea.y-scrollBarHeight;
			this.x = scrollArea.x;
			scrollArea.horizontalScroll(percent);
		}
		
		
		
	}
}