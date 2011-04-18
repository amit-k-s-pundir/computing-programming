package yourminis.components
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.filters.DropShadowFilter;
	import flash.geom.ColorTransform;
	import flash.display.BlendMode;
	
	public class YMTabContainer extends Sprite
	{
		public var menuItems:Array;
		private var textFormat:TextFormat;
		public var alignBottom:Boolean = false;
		public var alignLeft:Boolean = false;
		public var activeColor:uint=0xEEEEEE;
		public var idleColor:uint=0xCCCCCC;
		public var activeTextColor:uint=0;
		public var idleTextColor:uint=0;
		public var activeBorderColor:uint = 0x444444;
		public var idleBorderColor:uint = 0xAAAAAA;
		public var borderThickness:Number = 1;
		public var borderAlpha:Number = 1;
		public var cornerRadius:Number=10;
		public var activeAlpha:Number = 1;
		public var idleAlpha:Number = 1;
		public var tabOverlap:Number = 1;
		public var tabPadding:Number = 5;
		public var tabOffsetY:Number = 0;
		public var tabOffsetX:Number = 0;
		public var activeIndex:Number = -1;
		public var activeTabHeight:Number = 2;
		public var idleTextPunch:Boolean = false;
		public var activeTextPunch:Boolean = false;
		public var dropShadow:DropShadowFilter;
		public var embed:Boolean;
		private var _width:Number=100;
		private var _height:Number=100;
		
		
		
		public function YMTabContainer()
		{
			textFormat = new TextFormat();
			menuItems = new Array();
			setTextFormat();
			//dropShadow = new DropShadowFilter(0);
		}
		public function setTextFormat(_font:String="Verdana",_size:Number=11,_activeTextColor:uint=0,_idleTextColor:uint=0,_bold:Boolean=true,_embed=false)
		{
			activeTextColor = _activeTextColor;
			idleTextColor = _idleTextColor;
			textFormat = new TextFormat(_font,_size,_activeTextColor,_bold);
			embed = _embed;
		}
		
		public function addTab(label:String, _tabEnabled:Boolean=true, _tagWidth:Number=0, _tagHeight:Number=0):void
		{
			var txt:TextField = new TextField();
			txt.embedFonts = embed;
			txt.selectable = false;
			txt.mouseEnabled = false;
			if (label != "")
			{
				txt.autoSize = "left";
				txt.defaultTextFormat = textFormat;
				txt.text = label;
				if (_tagWidth == 0) _tagWidth = txt.width+2*tabPadding;
				if (_tagHeight == 0) _tagHeight = txt.height+2*tabPadding;
				txt.x = tabPadding;
				if (alignBottom) txt.y = _tagHeight-tabPadding-txt.height+4;
				else txt.y = tabPadding-4;
			}
			var tab:Sprite = new Sprite();
			var tabgraphics:Sprite = new Sprite();
			var tabbg:Sprite = new Sprite();
			var tagbg:Sprite = new Sprite();
			var tag:Sprite = new Sprite();
			var taberaser:Sprite = new Sprite();
			var tageraser:Sprite = new Sprite();
			var tabcontent:Sprite = new Sprite();
			
			tag.name = String(menuItems.length);
			drawRoundRect(taberaser,_tagWidth,_tagHeight,idleColor,0,1,0);
			tag.addChild(tagbg);
			tag.addChild(tageraser);
			tag.addChild(txt);
			tag.visible = _tabEnabled
			tag.addEventListener(MouseEvent.CLICK, onSelectTab);
			tabgraphics.blendMode = BlendMode.LAYER;
			taberaser.blendMode = BlendMode.ERASE;
			tagbg.blendMode = BlendMode.LAYER;
			tagbg.mask = tageraser;
			tabgraphics.addChild(tabbg);
			tabgraphics.addChild(taberaser);
			taberaser.visible = false;
			tabgraphics.addChild(tag);
			tab.addChild(tabgraphics);
			tab.addChild(tabcontent);
			
			
			addChild(tab);
			menuItems.push({tagWidth:_tagWidth,tagHeight:_tagHeight,tabgraphics:tabgraphics,taberaser:taberaser,tageraser:tageraser,tabcontent:tabcontent,tabbg:tabbg,tab:tab,tag:tag,tagbg:tagbg,active:false})
		}
		private function drawRoundRect(sprite:Sprite,__width:Number,__height:Number,_color:uint,_borderColor,_alpha:Number=1,__cornerRadius:Number=-1):void
		{
			var _cornerRadius = __cornerRadius;
			if (_cornerRadius==-1) _cornerRadius = cornerRadius;
			var _borderAlpha = borderAlpha;
			if (sprite.blendMode == BlendMode.ALPHA) _borderAlpha = 0;
			sprite.graphics.clear();
			sprite.graphics.beginFill(_color,_alpha);
			sprite.graphics.lineStyle(borderThickness,_borderColor,_borderAlpha,true,"none");
			sprite.graphics.drawRoundRect(0,0,__width,__height,2*_cornerRadius)
			sprite.graphics.endFill();
		}
		private function onSelectTab(evt:MouseEvent):void
		{
			var index = int(evt.currentTarget.name);
			if (activeIndex==index) return;
			activateTab(index);
		}
		public function activateTab(index:int):void
		{
			activeIndex = index;
			removeChild(menuItems[index].tab);
			addChild(menuItems[index].tab);
			for (var i:int=0; i<menuItems.length; i++)
			{
				var obj = menuItems[i];
				var isActiveTab:Boolean = index==i;
				if (obj.active && !isActiveTab) obj.tab.dispatchEvent(new Event("deactivated"));
				if (isActiveTab) obj.tab.dispatchEvent(new Event("activated"));
				obj.active = isActiveTab;
				obj.tag.buttonMode = !obj.active;
				alignTab(obj);
				obj.tabcontent.visible = obj.tabbg.visible = isActiveTab;
				if (obj.active) 
				{
					obj.tab.tabChildren = true;
					for each (var disp1:DisplayObject in obj.tab){disp1.visible = true;}
					obj.tag.filters = [];
					if (dropShadow) obj.tabgraphics.filters = [dropShadow];
					else obj.tabgraphics.filters = [];
				}
				else
				{
					obj.tab.tabChildren = false;
					for each (var disp2:DisplayObject in obj.tab){if (disp2 != obj.tag) disp2.visible = false;}
					
					if (dropShadow) obj.tag.filters = [dropShadow];
					else obj.tag.filters = [];
					obj.tabgraphics.filters = [];
				}
			}
			setTheme();
		}
		public function setTheme(_activeColor:Number=-1, _idleColor:Number=-1):void
		{
			if (_activeColor > -1) activeColor = _activeColor;
			if (_idleColor > -1) idleColor = _idleColor;
			for (var i:int=0; i<menuItems.length; i++)
			{
				var obj = menuItems[i];
				var _color:uint = idleColor;
				var _tagAlpha = idleAlpha;
				var _borderColor:uint = idleBorderColor;
				var txt:TextField = obj.tag.getChildAt(2);
				txt.textColor=idleTextColor;
				if (idleTextPunch) txt.blendMode = BlendMode.ERASE;
				else txt.blendMode = BlendMode.NORMAL;
				if (obj.active) 
				{
					if (activeTextPunch) txt.blendMode = BlendMode.ERASE;
					else txt.blendMode = BlendMode.NORMAL;
					txt.textColor=activeTextColor;
					_color = activeColor;
					_borderColor = activeBorderColor;
					_tagAlpha = activeAlpha;
				}
				drawRoundRect(obj.tagbg,obj.tagWidth,obj.tagHeight,_color,_borderColor,_tagAlpha);
				drawRoundRect(obj.tabbg,_width,_height,_color,_borderColor,_tagAlpha);
			}
		}
		private function alignTab(obj:Object):void
		{
			var tabOffset:Number;
			if (alignBottom) 
			{
				tabOffset = -cornerRadius+activeTabHeight*int(obj.active) - tabOffsetY;
				obj.tag.y = _height + tabOffset;
				drawRoundRect(obj.tageraser,obj.tagWidth+1,obj.tagHeight,idleColor,0,1,0);
				obj.tageraser.y = cornerRadius-2;
			}
			else 
			{
				tabOffset = cornerRadius - obj.tagHeight + activeTabHeight*int(!obj.active) + tabOffsetY;
				obj.tag.y = tabOffset;
				drawRoundRect(obj.tageraser,obj.tagWidth+1,-tabOffset+1,idleColor,0,1,0);
			}
			obj.taberaser.y = obj.tag.y;
		}
		
		public function setSize(__width:Number=0, __height:Number=0)
		{
			if (__width) _width = __width;
			if (__height) _height = __height;
			for (var i:int=0; i<menuItems.length; i++)
			{
				var obj = menuItems[i];
				var _color:uint = idleColor;
				if (obj.active) _color = activeColor;
				drawRoundRect(obj.tabbg,_width,_height,_color,activeBorderColor,activeAlpha);
				alignTab(obj);
				
				if (i==0)
				{
					if (alignLeft) obj.tag.x = cornerRadius + tabOffsetX;
					else obj.tag.x = _width - obj.tag.width - cornerRadius + tabOffsetX;
				}
				else
				{
					if (alignLeft) obj.tag.x = menuItems[i-1].tag.x + menuItems[i-1].tagWidth - tabOverlap;
					else obj.tag.x = menuItems[i-1].tag.x - obj.tag.width + tabOverlap + tabOffsetX;
				}
				obj.taberaser.x = obj.tag.x;
			}
			setTheme();
		}
		public function addChildToTab(child:DisplayObject,index:int,initX:Number=0,initY:Number=0):void
		{
			if (initX) child.x = initX;
			if (initY) child.y = initY;
			menuItems[index].tabcontent.addChild(child);
		}
	}
	
}