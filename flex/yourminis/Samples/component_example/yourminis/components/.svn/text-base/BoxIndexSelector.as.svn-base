package yourminis.components
{
	import yourminis.utils.IndexSelector;
	import yourminis.components.PulseButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class BoxIndexSelector extends IndexSelector
	{
		private var color:uint;
		private var bgcolor:uint;
		private var boxArray:Array;
		private var boxDim:Number = 10;
		
		public function BoxIndexSelector(_callback:Function,totalBoxes:int=5,_color:uint=0x000000,_bgcolor:uint=0xCCCCCC)
		{
			super(_callback);
			color = _color;
			bgcolor = _bgcolor;
			_total = totalBoxes;
			boxArray = new Array();
			drawButtons();
		}
		private function drawButtons():void
		{
			for (var i=0;i<_total;i++)
			{
				boxArray.push(boxButton(i));
				boxArray[i].x = i*(boxDim+5);
				addChild(boxArray[i]);
			}
		}
		private function boxButton(idx:int):Sprite
		{
			var sprite:Sprite = new Sprite();
			sprite.name = String(idx);
			sprite.buttonMode = true;
			sprite.addEventListener(MouseEvent.CLICK,mouseClickHandler);
			drawBox(sprite);
			return sprite;
		}
		private function drawBox(sprite:Sprite)
		{
			var idx = Number(sprite.name);
			sprite.graphics.clear();
			sprite.graphics.beginFill(0,0);
			sprite.graphics.lineStyle(1,color);
			sprite.graphics.drawRect(0,0,boxDim,boxDim);
			sprite.graphics.endFill();
			sprite.graphics.lineStyle(0,0,0);
			if (idx == index) sprite.graphics.beginFill(color);
			else sprite.graphics.beginFill(bgcolor);
			sprite.graphics.drawRect(2,2,boxDim-3,boxDim-3);
			sprite.graphics.endFill();
		}
		private function mouseClickHandler(evt:MouseEvent):void
		{
			var idx = Number(evt.target.name);
			index = idx;
		}
		
		override public function update():void{for (var i=0;i<_total;i++) drawBox(boxArray[i])}
	}
}