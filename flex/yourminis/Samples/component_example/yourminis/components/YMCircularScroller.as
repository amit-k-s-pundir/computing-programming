package yourminis.components{
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class YMCircularScroller extends Sprite
	{
		public var menuItems:Array;
		public var container_mc:MovieClip;
		public var itemWidth:int; 
		public var itemHeight:int;
		public var selectedIndex:int;
		public var scrollWidth:int;
		public var scrollHeight:int;
		public var scrollFactor:int = 1;
		public var centerItem:int;
		public var noScale:Boolean = true;
	
		public function YMCircularScroller(list_container_mc:MovieClip, listItemWidth:int, listItemHeight:int) 
		{
			this.tabChildren = false;
			itemWidth = listItemWidth;
			itemHeight = listItemHeight;
			container_mc = list_container_mc;
			
			container_mc.itemholder.mask = container_mc.bgmask;
			menuItems = new Array();
			
			container_mc.right_btn.addEventListener(MouseEvent.MOUSE_DOWN,scrollRight);
			container_mc.left_btn.addEventListener(MouseEvent.MOUSE_DOWN,scrollLeft);
			container_mc.right_btn.addEventListener(MouseEvent.MOUSE_UP,onArrowRelease);
			container_mc.left_btn.addEventListener(MouseEvent.MOUSE_UP,onArrowRelease);
		}
		
		public function mouseWheel(evt:MouseEvent):void
		{			
			if (evt.delta > 0) scrollLeft(new MouseEvent(MouseEvent.MOUSE_DOWN));
			else scrollRight(new MouseEvent(MouseEvent.MOUSE_DOWN));
		}

		public function addItem(label:String, data:Object, callback:Function, item:Object)
		{
			item.tabEnabled = false;
			container_mc.itemholder.addChild(item)
			var newItem:Object = new Object();
			
			//item.buttonMode = true;
			newItem.mc = item;
			//newItem.mc.index = menuItems.length;
			newItem.mc.label = label;
			newItem.mc.data = data;
			newItem.mc.callback = callback;
			newItem.mc.addEventListener(MouseEvent.CLICK,onReleaseItem);
			newItem.mc.addEventListener(MouseEvent.MOUSE_OVER,onRollOverItem);
			newItem.mc.addEventListener(MouseEvent.MOUSE_OUT,onRollOutItem);
			//var myfilter:GlowFilter = new GlowFilter(0xFFFFFF,100,10,10,2,3,false,false);
			//newItem.mc.filters = [myfilter];
			menuItems.push(newItem);
			//scrollRight(new Event(""));
		}
		
		public function removeAll()
		{
			for (var i=0; i<menuItems.length; i++) {
				container_mc.itemholder.removeChild(menuItems[i].mc);
			}
			menuItems = [];
			//reset scroll
		}
		
		private function onArrowRelease(evt:MouseEvent)
		{
			//container_mc.onReleaseArrow();
		}
		
		public function scrollLeft(evt:Event=null)
		{
			//item on end to front
			for (var i=0; i<scrollFactor; i++)
			{
				var temp:Array = menuItems.splice(menuItems.length-1,1);
				menuItems = temp.concat(menuItems);			
				if (!noScale) container_mc.info_txt.htmlText = menuItems[centerItem].mc.label;
				container_mc.itemholder.x -= itemWidth;
				alignItems();
			}
			addEventListener(Event.ENTER_FRAME,recenterItems);
		}
		public function scrollRight(evt:Event=null)
		{
			//item in front to end
			for (var i=0; i<scrollFactor; i++)
			{
				var temp:Array = menuItems.splice(0,1);
				menuItems = menuItems.concat(temp);
				if (!noScale) container_mc.info_txt.htmlText = menuItems[centerItem].mc.label;
				container_mc.itemholder.x += itemWidth;
				alignItems();
			}
			addEventListener(Event.ENTER_FRAME,recenterItems);
		}
		
		private function recenterItems(evt:Event)
		{
			container_mc.itemholder.x += Math.round((((scrollWidth/2 - centerItem*itemWidth) - container_mc.itemholder.x)/10));
			alignItems();
			if (Math.abs(container_mc.itemholder.x - (scrollWidth/2 - centerItem*itemWidth)) < 1) 
			{
				removeEventListener(Event.ENTER_FRAME,recenterItems);
				container_mc.itemholder.x = Math.round((scrollWidth/2 - centerItem*itemWidth));
			}
			
		}
		
		private function onRollOverItem(evt:MouseEvent)
		{
			var _obj:Object = evt.currentTarget;
			container_mc.info_txt.htmlText = _obj.label;
		}
		private function onRollOutItem(evt:MouseEvent)
		{
			var _obj:Object = evt.currentTarget;
			container_mc.info_txt.htmlText = "";
		}
		
		private function onReleaseItem(evt:MouseEvent)
		{
			var _obj:Object = evt.currentTarget;
			_obj.callback(_obj.data);
		}
		
		private function alignItems()
		{
			for (var i:int=0; i<menuItems.length; i++) 
			{
				if (noScale)
				{
					menuItems[i].mc.x = Math.round(i*itemWidth);
					//menuItems[i].mc.y = (itemHeight-menuItems[i].mc.height)/2;
				}
				else
				{
					var itemx:Number = i*itemWidth + container_mc.itemholder.x;
					var centerx:Number = scrollWidth/2;
					var xfac:Number = itemx-centerx;
					var distancefac:Number = 1+Math.abs(xfac)/40;
					menuItems[i].mc.scaleX = menuItems[i].mc.scaleY = menuItems[i].mc.alpha =  Math.max(1/distancefac,0.1);
					menuItems[i].mc.x = Math.round(i*itemWidth-menuItems[i].mc.scaleX*itemWidth/2);
					var maxHeight = scrollHeight - itemHeight-20;
					menuItems[i].mc.y = -maxHeight*(4*Math.pow(xfac,2)-Math.pow(scrollWidth,2))/Math.pow(scrollWidth,2)-(menuItems[i].mc.scaleY*itemHeight)/2;
				}
				
			}
		}
		
		public function setSize(w:int=0,h:int=0)
		{
			if (w==0) w = scrollWidth;
			if (h==0) h = scrollHeight;
			centerItem = Math.round((menuItems.length-1)/2);
			if (!noScale) container_mc.info_txt.htmlText = menuItems[centerItem].mc.label;
			scrollWidth = w;
			scrollHeight = h;
			
			container_mc.info_txt.width = w;
			container_mc.itemholder.x = Math.round((scrollWidth/2 - centerItem*itemWidth));
			container_mc.right_btn.x = scrollWidth;
			container_mc.left_btn.x = 0;
			container_mc.bgmask.width = w;
			container_mc.bgmask.height = h;
			if (menuItems.length) alignItems();
		}
	}
}
