package yourminis.components {
	
	import flash.display.Graphics
	import flash.display.JointStyle
	import flash.display.SpreadMethod
	import flash.display.GradientType
	import flash.geom.Matrix
	import flash.geom.ColorTransform
	import flash.filters.DropShadowFilter
	
	public class SlideVerticalScroller extends VerticalScroller
	{
		private var fillColor:uint;
		private var fillAlpha:Number;
		private var cornerRadius:int;
		
		public function SlideVerticalScroller(_fillColor:uint,_fillAlpha:Number,_cornerRadius:int,_scrollBarWidth:int)
		{
			super(_scrollBarWidth,2);
			fillColor = _fillColor;
			fillAlpha = _fillAlpha;
			cornerRadius = _cornerRadius;
			scrollHandle.x = 2;
		}
		
		
		
		function drawScrollHandle():void
		{
			var newHandleHeight = Math.max(20,((scrollBarHeight-2*scrollBarWidth)/scrollArea.contentHeight)*(scrollBarHeight-2*scrollBarWidth));
			
			scrollHandle.graphics.clear();
			//scrollHandle.graphics.lineStyle(1, fillColor,0.5,true,"none");
			scrollHandle.graphics.beginFill(0xFFFFFF,1);  
			scrollHandle.graphics.drawRoundRect(0, 0, scrollBarWidth-5, newHandleHeight, (cornerRadius-2)*2);
			scrollHandle.graphics.endFill();
		}
		function drawScrollTrack():void
		{
			scrollTrack.graphics.clear();
			//scrollHandle.graphics.lineStyle(1, fillColor,0.5,true,"none");
			scrollTrack.graphics.beginFill(fillColor,fillAlpha);  
			scrollTrack.graphics.drawRoundRect(0, 0, scrollBarWidth-1, scrollBarHeight, cornerRadius*2);
			scrollTrack.graphics.endFill();
		}
		public override function updateScrollBar(horizontalVisibility:int):void
		{
			scrollBarHeight = scrollArea.scrollAreaHeight - horizontalVisibility * scrollBarWidth - 2;
			drawScrollHandle();
			drawScrollTrack();
			scrollHandle.y = (scrollBarHeight-scrollHandle.height-2*arrowDim) * percent + arrowDim;
			//scrollDownButton.y = scrollBarHeight - scrollBarWidth; 
			this.x = scrollArea.scrollAreaWidth+scrollArea.x-scrollBarWidth+3;
			this.y = scrollArea.y;
			scrollArea.verticalScroll(percent);
		}
		
		
		
	}
}