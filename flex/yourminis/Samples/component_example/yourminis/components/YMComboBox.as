package yourminis.components
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import yourminis.components.YMListScroller;
	
	public class YMComboBox extends Sprite
	{
		private var scroller:YMListScroller;
		private var bg:Sprite;
		private var scrollerbg:Sprite;
		private var selected_txt:TextField;
		public var cornerRadius:Number = 6;
		public var fillColor:uint;
		public var highlightColor:uint;
		public var textColor:uint;
		public var selectedData:Object;
		public var selectedLabel:String="";
		public var selectedIndex:int=-1;
		private var _width:Number;
		private var _height:Number;
		private var cellHeight:Number = 16;
		private var margin:Number = 4;
		public var maxHeight:Number = 300;
		public var borderThickness:Number = 2;
		
		public function YMComboBox(defaultText:String="",_initX:Number=0,_initY:Number=0,__width:Number=150,_fillColor:uint=0xFFFFFF,_highlightColor:uint=0xCCCCCC,_textColor:uint=0x444444)
		{
			this.x = _initX;
			this.y = _initY;
			fillColor=_fillColor;
			highlightColor=_highlightColor;
			textColor = _textColor;
			scroller = new YMListScroller(highlightColor);
			selected_txt = new TextField();
			selected_txt.x = margin;
			//selected_txt.y = 1;
			selected_txt.height = 20;
			selected_txt.defaultTextFormat = new TextFormat("Verdana",10,textColor);
			selected_txt.selectable = selected_txt.mouseEnabled = false;
			selected_txt.text = defaultText;
			bg = new Sprite();
			scrollerbg = new Sprite();
			scroller.visible = false;
			bg.buttonMode = true;
			scroller.y=cellHeight;
			addChild(bg);
			addChild(selected_txt);
			addChild(scroller);
			scroller.addChildAt(scrollerbg,0);
			this.width = __width;
			bg.addEventListener(MouseEvent.CLICK,comboClickHandler);
		}
		private function comboClickHandler(evt:MouseEvent):void
		{
			//if (scroller.visible) && 
			if (mouseX < _width && mouseX > 0 && mouseY < cellHeight+_height && mouseY >cellHeight) return;
			evt.stopImmediatePropagation();
			try {bg.removeEventListener(MouseEvent.CLICK,comboClickHandler);}catch(e){}
			try {root.removeEventListener(MouseEvent.CLICK,comboClickHandler);}catch(e){}
			scroller.visible = !scroller.visible;
			if (scroller.visible) root.addEventListener(MouseEvent.CLICK,comboClickHandler);
			else bg.addEventListener(MouseEvent.CLICK,comboClickHandler);
		}
		public override function get width():Number {return _width;}
		public override function set width(w:Number):void
		{
			var fullHeight = cellHeight*scroller.list.menuItems.length;
			_width = w;
			_height = Math.min(fullHeight,maxHeight);
			bg.graphics.clear();
			bg.graphics.lineStyle(borderThickness,highlightColor);
			bg.graphics.beginFill(fillColor);
			bg.graphics.drawRoundRect(0,0,w,cellHeight,cornerRadius);
			bg.graphics.endFill();
			bg.graphics.moveTo(w-20,5);
			bg.graphics.lineTo(w-15,11);
			bg.graphics.lineTo(w-10,5);
			selected_txt.width = w - 15 - 2*margin;
			scroller.setSize(w-10*int(fullHeight>maxHeight),_height);
			scrollerbg.graphics.clear();
			scrollerbg.graphics.lineStyle(borderThickness,highlightColor);
			scrollerbg.graphics.beginFill(fillColor);
			scrollerbg.graphics.drawRoundRect(0,0,_width,_height,cornerRadius);
			scrollerbg.graphics.endFill();
			for (var i=0; i<scroller.list.menuItems.length; i++)
			{
				drawCell(scroller.list.menuItems[i].getChildAt(0));
				scroller.list.menuItems[i].getChildAt(1).width = _width - 2*margin;
			}
		}
		public function addItem(label:String,data:Object=null):void
		{
			if (data==null) data = new Object();
			data.label = label;
			var newItem = new ListCell(data,_width,cellHeight);
			var cellbg:Sprite = new Sprite();
			drawCell(cellbg);
			cellbg.name = String(scroller.list.menuItems.length);
			cellbg.alpha = 0;
			cellbg.buttonMode = true;
			cellbg.addEventListener(MouseEvent.ROLL_OUT,cellRollOut);
			cellbg.addEventListener(MouseEvent.ROLL_OVER,cellRollOver);
			cellbg.addEventListener(MouseEvent.CLICK,cellClick);
			var cell_txt = new TextField();
			cell_txt.x = margin;
			//cell_txt.y = 1;
			cell_txt.defaultTextFormat = new TextFormat("Verdana",10,textColor);
			cell_txt.selectable = cell_txt.mouseEnabled = false;
			cell_txt.width = _width - 2*margin;
			cell_txt.text = label;
			cell_txt.height = cellHeight-1;
			newItem.addChild(cellbg);
			newItem.addChild(cell_txt);
			scroller.list.addItem(newItem);
		}
		public function addItems(labels:String)
		{
			var arr:Array = labels.split(",");
			for (var i:int=0; i<arr.length; i++) addItem(arr[i]);
		}
		public function selectItem(index:int):void
		{
			selectedIndex=index;
			selectedData = scroller.list.menuItems[index].data;
			selectedLabel = selectedData.label;
			selected_txt.text = selectedLabel;
			dispatchEvent(new Event(Event.CHANGE));
		}
		private function drawCell(sprite:Sprite):void
		{
			sprite.graphics.clear();
			sprite.graphics.beginFill(highlightColor);
			sprite.graphics.drawRoundRect(0,0,_width,cellHeight,cornerRadius);
			sprite.graphics.endFill();
		}
		private function cellRollOver(evt:MouseEvent):void{evt.currentTarget.alpha = 1;}
		private function cellRollOut(evt:MouseEvent):void{evt.currentTarget.alpha = 0;}
		private function cellClick(evt:MouseEvent):void
		{
			evt.stopImmediatePropagation();
			scroller.visible = !scroller.visible;
			root.removeEventListener(MouseEvent.CLICK,comboClickHandler);
			bg.addEventListener(MouseEvent.CLICK,comboClickHandler);
			selectItem(int(evt.currentTarget.name));
			
		}
		public function get text():String{return selectedLabel;}
		public function set text(str):void{selected_txt.text = str;selectedLabel = str;}
	}
}