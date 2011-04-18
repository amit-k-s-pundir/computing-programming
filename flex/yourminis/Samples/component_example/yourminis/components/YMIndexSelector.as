package yourminis.components
{
	import yourminis.utils.IndexSelector
	import yourminis.components.PulseButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class YMIndexSelector extends IndexSelector
	{
		public var header:String = "";
		public var separator:String = " of ";
		public var footer:String = "";
		public var textbox:TextField;
		public var left:Sprite;
		public var right:Sprite;
		private var bg:Sprite;
		private var ah:Number = 12;
		private var aw:Number = 6;
		public var _height:Number = 18;
		private var color:uint;
		private var bgcolor:uint;
		
		public function YMIndexSelector(_callback:Function,_color:uint=0xFFFFFF,_bgcolor:uint=0,_pulseColor:uint=0x00CCFF,_bold:Boolean=true,_size:int=11,_font:String="Verdana",_textColor=null)
		{
			super(_callback);
			color = _color;
			bgcolor = _bgcolor;
			bg = new Sprite();
			left = new Sprite();
			right = new Sprite();
			left.x = 3;
			left.y = right.y = Math.round((_height-ah)/2);
			textbox = new TextField();
			textbox.height = _size+10;
			textbox.y = Math.round((_height - _size)/2)-4;
			textbox.selectable = false;
			textbox.mouseEnabled = false;
			if (_textColor == null) textbox.defaultTextFormat = new TextFormat(_font,_size,_color,_bold,null,null,null,null,"center");
			else textbox.defaultTextFormat = new TextFormat(_font,_size,_textColor,_bold,null,null,null,null,"center");
			drawArrows();
			addChild(bg);
			addChild(textbox);
			addChild(left);
			addChild(right);
			var pb1:PulseButton = new PulseButton(left,null,decrement,_pulseColor);
			var pb2:PulseButton = new PulseButton(right,null,increment,_pulseColor);
			setSize(100);
			update();								 
		}
		private function drawArrows():void
		{
			left.graphics.clear();
			left.graphics.beginFill(color);
			left.graphics.moveTo(0,ah/2);
			left.graphics.lineTo(aw,0);
			left.graphics.lineTo(aw,ah);
			left.graphics.lineTo(0,ah/2);
			left.graphics.endFill();
			
			right.graphics.clear();
			right.graphics.beginFill(color);
			right.graphics.moveTo(0,0);
			right.graphics.lineTo(0,ah);
			right.graphics.lineTo(aw,ah/2);
			right.graphics.lineTo(0,0);
			right.graphics.endFill();
		}
		public function setSize(w:int):void
		{
			right.x = w - right.width - 3;
			textbox.width = w; 
			bg.graphics.clear();
			if (bgcolor>=0)
			{
				bg.graphics.beginFill(bgcolor,0.9);
				bg.graphics.drawRoundRect(0,0,w,_height,16);
				bg.graphics.endFill();
			}
		}
		public function setTheme(_color:uint)
		{
			color = _color;
			drawArrows();
			textbox.textColor = _color;
		}
		
		override public function update():void{textbox.text = header + (index+1) + separator + total + footer;}
	}
}