package yourminis.utils
{
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.text.TextField;
	import flash.text.StyleSheet;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.InteractiveObject;
	import flash.filters.DropShadowFilter;
	public class Tooltip extends Sprite
	{
		private var timer:Timer;
		private var bg:Sprite;
		private var tooltipText:TextField;
		private var css:StyleSheet;
		private var _backgroundColor:uint=0xFFFFCC;
		private var _borderColor:uint=0x000000;
		private var tooltipArray:Array;
		
		public function Tooltip()
		{
			timer = new Timer(1000);
			timer.addEventListener("timer",timerHandler);
			bg = new Sprite();
			//bg.cacheAsBitmap = true;
			tooltipArray = new Array();
			tooltipText = new TextField();
			tooltipText.autoSize = "left";
			tooltipText.selectable = false;
			tooltipText.x = 3;
			tooltipText.y = 0;
			addChild(bg);
			addChild(tooltipText);
			css = new StyleSheet();
			css.setStyle("tooltip",{fontFamily:'Verdana', fontSize:'9px', color:'#000000', fontWeight:'normal', display:'inline'})
			tooltipText.styleSheet = css;
			visible = false;
			var dsf:DropShadowFilter = new DropShadowFilter(2,45,0,0.5,4,4);
			bg.filters = [dsf];
		}
		private function timerHandler(evt:Event):void
		{
			timer.reset();
			mouseMoveHandler(new MouseEvent(MouseEvent.MOUSE_MOVE));
			visible = true;
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
			
		}
		public function addTooltip(mc:InteractiveObject,tooltip:String):void
		{
			tooltipArray.push({mc:mc,tooltip:tooltip});
			mc.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			mc.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
		}
		private function rollOverHandler(evt:MouseEvent):void
		{
			var target = evt.currentTarget;
			for (var i:int=0;i<tooltipArray.length;i++){
				if (target == tooltipArray[i].mc) tooltipText.htmlText = "<tooltip>"+ tooltipArray[i].tooltip + "</tooltip>";
			}
			bg.graphics.clear();
			bg.graphics.lineStyle(1,_borderColor,1,true,"none");
			bg.graphics.beginFill(_backgroundColor);
			bg.graphics.drawRoundRect(0,0,tooltipText.width+5,tooltipText.height,6);
			bg.graphics.endFill();
			timer.start();
		}
		private function rollOutHandler(evt:MouseEvent):void
		{
			timer.reset();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			visible = false;
		}
		private function mouseMoveHandler(evt:MouseEvent):void
		{
			var container:Sprite = this["parent"];
			var xoffset = 10;
			var yoffset = -5;
			if (container.mouseX + bg.width + 3 > container.width) xoffset = -bg.width-7;
			if (container.mouseY + bg.height - 10 > container.height) yoffset = -bg.height-3;
			this.x = container.mouseX+xoffset;
			this.y = container.mouseY+yoffset;
		}
		public function setStyle(backgroundColor,borderColor,css):void
		{
			_backgroundColor = backgroundColor;	
			_borderColor = borderColor;
			if (css) tooltipText.styleSheet = css;
		}
		public function setMaxWidth(maxwidth:Number):void
		{
			tooltipText.wordWrap = true;
			tooltipText.width = maxwidth;
		}
	}
}