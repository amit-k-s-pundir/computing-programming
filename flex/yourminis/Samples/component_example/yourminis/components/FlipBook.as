package yourminis.components
{
	import flash.display.GradientType;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.filters.DropShadowFilter;

	public class FlipBook extends Sprite
	{
		public var pages:Array;
		private var bl:Sprite;
		private var tl:Sprite;
		private var br:Sprite;
		private var tr:Sprite;
		private var cover:Sprite;
		private var flipMask:Sprite;
		private var backMask:Sprite;
		private var pageMask:Sprite;
		private var pageHolder:Sprite;
		private var cornerArray:Array;
		private var leftPageArray:Array;
		private var rightPageArray:Array;
		private var flipPage:DisplayObjectContainer;
		private var backPage:DisplayObjectContainer;
		private var mX:Number;
		private var mY:Number;
		private var sx:Number;
		private var sy:Number;
		private var _width:Number;
		private var _height:Number;
		private var padding:Number
		private var targetX:Number;
		private var pageWidth:Number;
		private var pageHeight:Number;
		private var cornerSize:Number = 80; 
		private var turningFromRight:Boolean;
		private var turningFromBottom:Boolean;
		private var mouseIsDown:Boolean=false;
		private var rolledOverCorner:Boolean=false;
		private var coverColor:uint;
		
		public function FlipBook(__width:Number, __height:Number, _padding:Number=10, _coverColor:uint=0x000000)
		{
			_width = __width;
			_height = __height;
			padding = _padding;
			coverColor = _coverColor;
			pageHeight = _height - 2*padding;
			pageWidth = _width/2 - padding; 
			rightPageArray = new Array();
			leftPageArray = new Array();
			pages = new Array();
			cover = new Sprite();
			pageHolder = new Sprite();
			pageMask = new Sprite();
			flipMask = new Sprite();
			backMask = new Sprite();
			addChild(cover);
			addChild(pageHolder);
			addChild(pageMask);
			addChild(flipMask);
			addChild(backMask);
			var ds:DropShadowFilter = new DropShadowFilter(5,45,0x333333,1,3,3);
			cover.filters = [ds]
			cornerArray = [tl,tr,bl,br];
			for (var i in cornerArray)
			{
				cornerArray[i] = new Sprite();
				cornerArray[i].graphics.beginFill(0xFF0000,0)
				cornerArray[i].graphics.drawRect(0,0,cornerSize,cornerSize);
				cornerArray[i].addEventListener(MouseEvent.MOUSE_DOWN,cornerPressHandler);
				cornerArray[i].addEventListener(MouseEvent.ROLL_OVER,cornerOverHandler);
				cornerArray[i].addEventListener(MouseEvent.ROLL_OUT,cornerOutHandler);
				cornerArray[i].buttonMode = true;
				addChild(cornerArray[i]);
			}
			setSize(_width,_height);
			cornerArray[0].visible = cornerArray[2].visible = false;
		}
		public function setSize(w:Number,h:Number)
		{
			cornerArray[0].y = cornerArray[1].y = padding+5;
			cornerArray[0].x = cornerArray[2].x = padding+5;
			cornerArray[1].x = cornerArray[3].x = _width - cornerSize - padding-5;
			cornerArray[2].y = cornerArray[3].y = _height - cornerSize - padding-5;
			
			cover.graphics.beginFill(coverColor);
			cover.graphics.drawRoundRect(0,0,w,h,4);
			cover.graphics.endFill();
		}
		private function cornerOverHandler(evt:MouseEvent):void{if (!mouseIsDown){cornerPressHandler(evt);rolledOverCorner = true;}}
		private function cornerOutHandler(evt:MouseEvent):void{if (!mouseIsDown && rolledOverCorner) mouseUpHandler(evt);}
		private function cornerPressHandler(evt:MouseEvent)
		{
			mouseIsDown = evt.buttonDown;
			sx = mouseX;
			sy = mouseY;
			turningFromRight = sx > _width/2;
			turningFromBottom = sy > _height/2;
			if (turningFromRight) {flipPage = rightPageArray[1]; backPage = rightPageArray[0]}
			else {flipPage = leftPageArray[1]; backPage = leftPageArray[0]}
			rotationPointCheck();
			pageHolder.removeChild(flipPage);
			pageHolder.removeChild(backPage);
			pageHolder.addChild(backPage);
			pageHolder.addChild(flipPage);
			resetPages();
			flipPage.mask = flipMask;
			backPage.mask = backMask;
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler)
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			mouseMoveHandler(evt);
		}
		private function mouseUpHandler(evt:MouseEvent)
		{
			rolledOverCorner = false;
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			
			var sideX:Number = _width-padding;
			if (turningFromRight) sideX = padding; 
			if ((mX<_width/2 && turningFromRight) || (mX>_width/2 && !turningFromRight)) targetX = sideX;
			else targetX = sx;
			addEventListener(Event.ENTER_FRAME,autoFlipHandler);
		}
		private function rotationPointCheck():void
		{
			if (turningFromRight)
			{
				sx = _width-padding;
				flipPage.getChildAt(0).x = 0;
			}
			else
			{
				sx = padding;
				flipPage.getChildAt(0).x = -1*pageWidth;
			}
			if (turningFromBottom) 
			{
				sy = _height - padding;
				flipPage.getChildAt(0).y = -1*pageHeight;
			}
			else 
			{
				sy = padding;
				flipPage.getChildAt(0).y = 0;
			}
		}
		private function autoFlipHandler(evt:Event):void
		{
			mX += (targetX-mX)/2;
			
			mY = Math.abs(targetX-mX);
			if (turningFromBottom) mY = _height - padding - mY;
			else mY = padding + mY;
			if (Math.abs(targetX-mX) < 1)
			{
				removeEventListener(Event.ENTER_FRAME,autoFlipHandler);
				mX = targetX;
				if (turningFromRight && targetX < _width/2)
				{
					leftPageArray.unshift(rightPageArray.shift());
					leftPageArray.unshift(rightPageArray.shift());
				}
				else if (!turningFromRight && targetX > _width/2)
				{
					rightPageArray.unshift(leftPageArray.shift());
					rightPageArray.unshift(leftPageArray.shift());
				}
				else
				{
					pageHolder.removeChild(flipPage);
					pageHolder.removeChild(backPage);
					pageHolder.addChild(flipPage);
					pageHolder.addChild(backPage);
				}
				resetPages();
				mouseIsDown = false;
			}
			else updatePagePosition();
		}
		private function mouseMoveHandler(evt:Event)
		{
			mX = mouseX; mY = mouseY;
			updatePagePosition();
		}
		/////////////////////////////////////////////////////////////////////////////////////////
		private function updatePagePosition()
		{
			var mX2:Number = mX-_width/2;
			var mY2:Number = sy-mY;
			var angleM:Number = Math.atan2(mY2,mX2);
			//if (!turningFromRight) angleM *=-1;
			if (turningFromRight)
			{
				if (turningFromBottom && angleM<7*Math.PI/-8) return;
				if (!turningFromBottom && angleM>7*Math.PI/8) return;
			}
			else
			{
				if (turningFromBottom && angleM<0 && angleM>Math.PI/-8) return;
				if (!turningFromBottom && angleM>0 && angleM<Math.PI/8) return;
			}
			if (turningFromBottom && angleM<0) turningFromBottom = false;
			if (!turningFromBottom && angleM>0) turningFromBottom = true;
			rotationPointCheck();
			
			var mX3:Number = (_width/2)+pageWidth*Math.cos(angleM);
			var mY3:Number = sy-pageWidth*Math.sin(angleM);
			if (Math.abs(angleM) < Math.PI/2) mX = Math.min(mX,mX3);
			else mX = Math.max(mX,mX3);
			if (turningFromBottom) mY = Math.max(mY,mY3);
			else mY = Math.min(mY,mY3);
			//drawBox(mX3,mY3);	
			//drawBox(mX,mY);
			
			var mpx:Number = (sx + mX)/2;
			var mpy:Number = (sy + mY)/2;
			var slopeY:Number = sy-mY;
			var slopeX:Number = sx-mX;
			if (slopeX == 0 || slopeY == 0) return;
			var m1:Number = slopeY/slopeX;
			var m2:Number = -1/m1;
			var b2:Number = mpy - m2*mpx;
			var sidey:Number = m2*sx+b2;
			var topx:Number = (padding - b2)/m2;
			var botx:Number = ((_height - padding)-b2)/m2;
			var topm:Number = (height/-2 - b2)/m2;
			var botm:Number = ((3*_height/2)-b2)/m2;
			//var touchingTop:Boolean = false;
			//var touchingBot:Boolean = false;
			
			var sideFactor:Number = topx;
			if (turningFromBottom) sideFactor = botx;
			
			var hyp:Number  = Point.distance(new Point(sideFactor,sy),new Point(sx,sidey));
			var adj:Number = Math.abs(sx - sideFactor); 
			var angle:Number = Math.asin(adj/hyp)*180/Math.PI;
			
			flipPage.x = mX;
			flipPage.y = mY;
			//if (mY > _height - padding || mY < padding) angle *= -1;
			if (turningFromBottom) flipPage.rotation = angle*2;
			else flipPage.rotation = angle*-2;
			if (!turningFromRight) flipPage.rotation*=-1;
			
			var percentageFromEdge:Number = Math.abs(mX-padding)/(_width-padding); 
			if (turningFromRight) percentageFromEdge = Math.abs(mX-(_width-padding))/(_width-padding);
			var otherSide:Number = _width;
			if (turningFromRight) otherSide = 0;
			function drawCornerMask(mc:Sprite)
			{
				mc.graphics.clear();
				mc.graphics.beginFill(0x00FFFF);
				mc.graphics.moveTo(otherSide,_height/-2);
				mc.graphics.lineTo(topm,_height/-2);
				mc.graphics.lineTo(topx,padding);
				mc.graphics.lineTo(botx,_height-padding);
				mc.graphics.lineTo(botm,3*_height/2);
				mc.graphics.lineTo(otherSide,3*_height/2);
				mc.graphics.lineTo(otherSide,_height/-2);
				mc.graphics.endFill();
			}
			function drawAlphaShade(mc:Sprite)
			{
				var alphaSprite = mc["alphaMask"];
				var matr:Matrix = new Matrix();
				var angleFac = Math.PI/-180;
				var percent:Number = percentageFromEdge;
				var ratios:Array;
				var alphaArray:Array;
				if (mc==backPage)
				{
					if(turningFromRight) percent=(1-percent);
					if (turningFromRight) angleFac*=-1;
					if (!turningFromBottom) angleFac*=-1;
					ratios = [percent*255, (percent+0.1)*255 ,255]
					alphaArray = [0.15,0.05,0];
					if (turningFromRight) 
					{
						ratios = [0,Math.max((percent)*255,0),Math.min((percent+0.1)*255,255)];
						alphaArray = [0,0.05,0.15];
					}
					matr.createGradientBox(pageWidth,pageHeight,angle*angleFac);
				
					alphaSprite.graphics.clear();
					alphaSprite.graphics.beginGradientFill(GradientType.LINEAR,[0,0,0],alphaArray,ratios,matr);
					alphaSprite.graphics.drawRect(0,0,pageWidth,pageHeight);
					alphaSprite.graphics.endFill();
				}
				else
				{
					//if(!turningFromRight) ;
					//angleFac*=-1;
					//percent=(1-percent);
					if (turningFromBottom) 
					{
						
						//angleFac*=-1;
					}
					ratios = [0, percent*255,(percent-0.1)*255]
					alphaArray = [0,0,0.25];
				}
				//if (!turningFromRight) angleFac*=-1;
				
			}
			drawCornerMask(backMask);
			drawCornerMask(flipMask);
			drawAlphaShade(flipPage);
			drawAlphaShade(backPage);
		}
		
		public function addPage(pageContent:MovieClip)
		{
			var page:MovieClip = new MovieClip();
			var alphaMask:Sprite = new Sprite();
			page.alphaMask = alphaMask;
			pageContent.addChild(alphaMask);
			page.addChild(pageContent);
			page.x = _width/2;
			page.y = padding;
			//if (rightPageArray.length%2)	pageHolder.addChild(page);
			pageHolder.addChildAt(page,0);
			rightPageArray.push(page);
			pages.push(page);
		}
		private function resetPages()
		{
			var i:int;
			for (i=0; i<leftPageArray.length; i++)
			{
				var alphaSprite1 = leftPageArray[i]["alphaMask"];
				alphaSprite1.graphics.clear();
				leftPageArray[i].rotation = 0;
				//pageHolder.setChildIndex(leftPageArray[i],leftPageArray.length-i-1); 
				leftPageArray[i].getChildAt(0).x = 0;
				leftPageArray[i].getChildAt(0).y = 0;
				leftPageArray[i].x = leftPageArray[i].y = padding;
				
			}
			for (i=0; i<rightPageArray.length; i++)
			{
				var alphaSprite2 = rightPageArray[i]["alphaMask"];
				alphaSprite2.graphics.clear();
				rightPageArray[i].rotation = 0;
				//pageHolder.setChildIndex(rightPageArray[i],rightPageArray.length-i-1); 
				rightPageArray[i].getChildAt(0).x = 0;
				rightPageArray[i].getChildAt(0).y = 0;
				rightPageArray[i].x = _width/2;
				rightPageArray[i].y = padding;
			}
			cornerArray[0].visible = cornerArray[2].visible = leftPageArray.length>0;
			cornerArray[1].visible = cornerArray[3].visible = rightPageArray.length>0;
		}
		override public function get width():Number {return _width;}
		override public function get height():Number {return _height;}
	}
}