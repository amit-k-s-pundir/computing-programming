﻿package yourminis.components {
	
	import flash.display.Graphics
	import flash.display.JointStyle
	import flash.display.SpreadMethod
	import flash.display.GradientType
	import flash.geom.Matrix
	import flash.geom.ColorTransform
	import flash.filters.DropShadowFilter
	
	public class StandardVerticalScroller extends VerticalScroller
	{
		private var fillColor:uint;
		private var fillAlpha:Number;
		private var cornerRadius:int;
		
		public function StandardVerticalScroller(_fillColor:uint,_fillAlpha:Number,_cornerRadius:int,_scrollBarWidth:int)
		{
			super(_scrollBarWidth);
			fillColor = _fillColor;
			fillAlpha = _fillAlpha;
			cornerRadius = _cornerRadius;
			drawButtons();
		}
		
		private function drawButtons():void
		{
			scrollDownButton.graphics.beginFill(0,0);
			scrollDownButton.graphics.drawRect(0,0,scrollBarWidth,scrollBarWidth);
			scrollDownButton.graphics.endFill();
			
			scrollDownButton.graphics.lineStyle(1, fillColor,1,true,"none",null,JointStyle.ROUND);
			scrollDownButton.graphics.beginFill(fillColor,fillAlpha);
			scrollDownButton.graphics.moveTo(2,3);
			scrollDownButton.graphics.lineTo(scrollBarWidth-3,3);
			scrollDownButton.graphics.lineTo(scrollBarWidth/2,scrollBarWidth-4);
			scrollDownButton.graphics.lineTo(scrollBarWidth/2-1,scrollBarWidth-4);
			scrollDownButton.graphics.lineTo(2,3);
			scrollDownButton.graphics.endFill();
			
			scrollUpButton.graphics.beginFill(0,0);
			scrollUpButton.graphics.drawRect(0,0,scrollBarWidth,scrollBarWidth);
			scrollUpButton.graphics.endFill();
			
			scrollUpButton.graphics.lineStyle(1, fillColor,1,true,"none");
			scrollUpButton.graphics.beginFill(fillColor,fillAlpha);
			scrollUpButton.graphics.moveTo(2,scrollBarWidth-3);
			scrollUpButton.graphics.lineTo(scrollBarWidth-3,scrollBarWidth-3);
			scrollUpButton.graphics.lineTo(scrollBarWidth/2,4);
			scrollUpButton.graphics.lineTo(scrollBarWidth/2-1,4);
			scrollUpButton.graphics.lineTo(2,scrollBarWidth-3);
			scrollUpButton.graphics.endFill();
		}
		
		function drawScrollHandle():void
		{
			var newHandleHeight = Math.max(20,((scrollBarHeight-2*scrollBarWidth)/scrollArea.contentHeight)*(scrollBarHeight-2*scrollBarWidth));
			
			scrollHandle.graphics.clear();
			scrollHandle.graphics.lineStyle(1, fillColor,0.5,true,"none");
			scrollHandle.graphics.beginFill(fillColor,fillAlpha);  
			scrollHandle.graphics.drawRoundRect(0, 0, scrollBarWidth-1, newHandleHeight, cornerRadius*2);
			scrollHandle.graphics.endFill();
			
			scrollHandle.graphics.lineStyle(1, fillColor,0,true,"none");
			var matr = new Matrix();
			matr.createGradientBox(scrollBarWidth-1, newHandleHeight, 0, 0, 0);
			scrollHandle.graphics.beginGradientFill(GradientType.LINEAR, [0x333333, 0xFFFFFF], [Math.max(fillAlpha-0.5,0), 0], [0x00, 0xAA], matr, SpreadMethod.PAD);  
			scrollHandle.graphics.drawRoundRect(0, 0, scrollBarWidth-1, newHandleHeight, cornerRadius*2);
			scrollHandle.graphics.endFill();
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