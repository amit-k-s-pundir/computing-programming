package yourminis.components
{
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Carousel extends Sprite
	{
		private var _width:Number;
		private var _height:Number;
		public var rollover_mc:Object;
		public var rollout_mc:Object;
		public var centerPiece:DisplayObjectContainer;
		public var currentPosition:Number=0;
		public var selectedIndex:int = -1;
		private static var circle:Number = Math.PI*2;
		private static var scaleArea:Number = Math.PI/6;
		
		public var menuItems:Array;
		public function Carousel(initWidth,initHeight,_centerPiece:DisplayObjectContainer=null)
		{
			_width = initWidth;
			_height = initHeight;
			centerPiece = _centerPiece;
			menuItems = new Array();
			if (centerPiece) addChild(centerPiece);
		}
		public function addItem(item:DisplayObjectContainer,data:*,callback:Function, itemWidth:Number, itemHeight:Number, title:String="")
		{
			var newItem:Object = new Object();
			this.addChild(item);
			item.mouseChildren = false;
			item.addEventListener(MouseEvent.CLICK,clickHandler);
			item.addEventListener(MouseEvent.ROLL_OUT,rollOutHandler);
			item.addEventListener(MouseEvent.ROLL_OVER,rollOverHandler);
			
			newItem.mc = item;
			newItem.width = itemWidth;
			newItem.height = itemHeight;
			newItem.mc.title = title;
			newItem.mc.data = data;
			newItem.mc.callback = callback;
			newItem.mc.index = menuItems.length;
			menuItems.push(newItem);
			updatePositions();
		}
		private function clickHandler(evt:MouseEvent):void
		{
			var mc:Object = evt.target;
			selectedIndex = mc.index;
			trace(mc.index);
			mc.callback(mc.data);
		}
		private function rollOutHandler(evt:MouseEvent):void
		{
			rollout_mc = evt.target;
			dispatchEvent(new Event("rollout"));
		}
		private function rollOverHandler(evt:MouseEvent):void
		{
			rollover_mc = evt.target;
			dispatchEvent(new Event("rollover"));
		}
		public function rotate(speed:Number=0)
		{
			currentPosition+=speed;
			if (currentPosition > circle) currentPosition -= circle;
			if (currentPosition < 0) currentPosition += circle;
			updatePositions();
		}
	
		
		public function setSize(w:Number,h:Number)
		{
			_width = w;
			_height = h;
			if (centerPiece)
			{
				centerPiece.x = (w-centerPiece.width)/2;
				centerPiece.y = (h-centerPiece.height)/2;
			}
			updatePositions();
		}
		public function updatePositions()
		{
			var spacing:Number = circle/menuItems.length;
			var radiusX = _width/2;
			var radiusY = _height/2;
			for (var i:int=0; i < menuItems.length; i++)
			{
				var mc:DisplayObjectContainer = menuItems[i].mc;
				var position = (currentPosition + (i * spacing));
				if (position > circle) position -= circle;
				if (position < 0) position += circle;
				if (position > circle/2) setChildIndex(mc,0);
 				if (centerPiece) setChildIndex(centerPiece,Math.round(menuItems.length/2));
				mc.y = radiusY*(Math.sin(position) + 1);
				var scaleFac:Number = mc.y/_height + 0.3//1.4*mc.y/_height+0.05;
				scaleFac = Math.max(0.3,scaleFac);
				scaleFac = Math.min(1,scaleFac);
				scaleFac = Math.round(100*scaleFac)/100
				mc.scaleX = mc.scaleY = scaleFac;
				mc.cacheAsBitmap = (mc.scaleX == 1 || mc.scaleX == 0.3) 
				mc.alpha = Math.min(1,mc.scaleX);
				mc.x = radiusX*(Math.cos(position) + 1)-(menuItems[i].width*mc.scaleX)/2;
				mc.y -= (menuItems[i].height*scaleFac)/2;
			}
		}
		override public function get width():Number{return _width;}
		override public function get height():Number{return _height;}
	}
}