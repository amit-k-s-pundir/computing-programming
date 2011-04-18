package yourminis.effects
{
    import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.filters.*;
	import flash.geom.Point;
	import flash.geom.ColorTransform;

	import flash.events.Event;

    public class Visualizer extends Sprite
    {
      	private var _width:int;
		private var _height:int;
		public var bmp:Bitmap;
		public var bmpData:BitmapData;
		public var bmpTransform:ColorTransform;
		public var displacementMap:DisplacementMapFilter;
		public var fillColor:uint;
		public var isTransparent:Boolean;
		public var var1;
		public var color1:uint = 0xFFBBCCFF;
		public var filterFunction:Function;
		public var audioManager:AudioManager;
		private var frameCounter;
		public var frameskip;
		
		public function Visualizer(initWidth:int=320,initHeight:int=240,_audioManager:AudioManager=null,_fillColor:uint=0,_isTransparent:Boolean=true,_frameskip=1)
		{
			frameskip = _frameskip;
			frameCounter = 0;
			fillColor = _fillColor;
			isTransparent = _isTransparent;
			audioManager = _audioManager;
			bmpTransform = new ColorTransform();
			displacementMap = new DisplacementMapFilter();
			filterFunction = fadeOut;
			setSize(initWidth,initHeight);
			var1 = 0.8;
			
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		public function onEnterFrame(evt:Event):void
		{
			frameCounter++;
			if (frameCounter%frameskip == 0) {
				filterFunction();
			}
		}
		public function fadeOut():void
		{
			/*var xfac:int = Math.pow(-1,Math.floor(Math.random()*2));
			var yfac:int = Math.pow(-1,Math.floor(Math.random()*2));
			var myPt:Point = new Point(xfac,yfac);
			bmpData.copyPixels(bmpData,bmpData.rect,myPt);*/
			//bmpData.applyFilter(bmpData,bmpData.rect,new Point(0,0),displacementMap);
			bmpTransform.alphaMultiplier = var1;
			//bmpTransform.greenMultiplier = 2*var1;
			bmpData.colorTransform(bmpData.rect, bmpTransform);
		}
		public function removeFilters()
		{
			this.filters = [];
		}
		public function addGlow(color:uint,strength:int,distance:int):void
		{
			var glowFilter:GlowFilter = new GlowFilter(color,1,distance,distance,strength,1);
			this.filters = [glowFilter];
		}
		public function addBlur(sx,sy) {
			var blurFilter:BlurFilter = new BlurFilter(sx,sy,1);
			this.filters = [blurFilter];
		}
		public function setSize(w:int,h:int):void
		{
			_width = w;
			_height = h;
			if (bmp) removeChild(bmp);
			bmpData = new BitmapData(w,h,isTransparent,fillColor);
			bmp = new Bitmap(bmpData);
			addChild(bmp);
			
			var b2:BitmapData = new BitmapData(bmpData.width,bmpData.height,true,0xFFFF0000);
			displacementMap.mapBitmap = b2;
			displacementMap.mapPoint = new Point(0, 0);
			displacementMap.componentX = BitmapDataChannel.RED;
			displacementMap.componentY = BitmapDataChannel.RED;
			displacementMap.scaleX = Math.pow(-1,Math.floor(Math.random()*2));
			displacementMap.scaleY = 2;
			displacementMap.mode = "ignore";
		}
		public function drawLine(x0:int,y0:int,x1:int,y1:int,c:uint):void
		{
			var dy:int = y1 - y0;
			var dx:int = x1 - x0;
			var stepx:int;
			var stepy:int;
			var fraction:int;
	
			if (dy < 0) { dy = -dy;  stepy = -1; } else { stepy = 1; }
			if (dx < 0) { dx = -dx;  stepx = -1; } else { stepx = 1; }
			dy <<= 1;                                                  // dy is now 2*dy
			dx <<= 1;                                                  // dx is now 2*dx
	
			bmpData.setPixel32(x0, y0, c);
			if (dx > dy) {
				fraction = dy - (dx >> 1);                         // same as 2*dy - dx
				while (x0 != x1) {
					if (fraction >= 0) {
						y0 += stepy;
						fraction -= dx;                                // same as fraction -= 2*dx
					}
					x0 += stepx;
					fraction += dy;                                    // same as fraction -= 2*dy
					bmpData.setPixel32(x0, y0, c);
				}
			} else {
				fraction = dx - (dy >> 1);
				while (y0 != y1) {
					if (fraction >= 0) {
						x0 += stepx;
						fraction -= dy;
					}
					y0 += stepy;
					fraction += dx;
					bmpData.setPixel32(x0, y0, c);
				}
			}
		}

		override public function get width():Number{return _width;}
		override public function get height():Number{return _height;}
		
	}
	
}