package yourminis.components
{
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	
	public class YMButton extends Sprite
	{
		private var shine:Sprite;
		private var over:Sprite;
		private var off:Sprite;
		private var shade:Sprite;
		public var callback:Function;
		public var txt:TextField;
		private var myTxtFormat:TextFormat;
		private var mouseIsDown:Boolean=false;
		private var mouseIsOver:Boolean;
		public var fillAlpha:Number=1;
		public var lineAlpha:Number = 0.5;
		public var cornerRadius:int = 3;
		public var lineWidth:int = 1;
		public var standardColors:Array;
		public var hoverColors:Array;
		public var lineColor:uint=0xFFFFFF;
		public var boxHeight:int = 16;
		private var textOffset:Number;
		
		
		public function YMButton(sText:String,cb:Function, initX:int, initY:int, ...args)
		{
			callback = cb;
			x = initX;
			y = initY;
			
			standardColors = args[0];
			hoverColors = args[1];
			
			if (standardColors == null) standardColors = [0x3979B8,0x92D3FD];
			if (standardColors.length == 1) standardColors = [0x222222,0xAAAAAA];
			if (hoverColors == null) hoverColors = [0x137D27,0x1EC10B];
			if (hoverColors.length == 1) hoverColors = [0x440000,0xFF0000];

			shade = new Sprite();
			off = new Sprite();
			over = new Sprite();
			shine = new Sprite();
			
			txt = new TextField()
			txt.selectable = false;
			
			txt.autoSize = "left";
			txt.mouseEnabled = false;
			myTxtFormat = new TextFormat();
			myTxtFormat.font = "Verdana";
			myTxtFormat.size = 11;
			myTxtFormat.color = 0xFFFFFF;
			myTxtFormat.bold = true;
			txt.defaultTextFormat = myTxtFormat;
			txt.text = sText;
			over.visible = false;
			
			
			var df1:DropShadowFilter = new DropShadowFilter(1,45,0x000000,1,1,1,0.9,2,false,true,false);
			var df2:DropShadowFilter = new DropShadowFilter(1,45,0x000000,100,1,1,0.9,2,false,false,false);
			shade.filters = [df1];
			txt.filters = [df2];

			addEventListener(MouseEvent.MOUSE_DOWN,onPressButton);
			addEventListener(MouseEvent.ROLL_OVER,onRollOverButton);
			addEventListener(MouseEvent.ROLL_OUT,onRollOutButton);
			
			buttonMode = true;
			useHandCursor = true;
			
			addChild(over);
			addChild(off);
			addChild(shine);
			addChild(shade);
			addChild(txt);
			
			redraw();
			
		}
		public function removeShadows():void{shade.filters=txt.filters=[];}
		public function setTextFormat(_font:String="Verdana",_size:Number=11,_color:uint=0,_bold:Boolean=true)
		{
			myTxtFormat = new TextFormat(_font,_size,_color,_bold);
			txt.setTextFormat(myTxtFormat);

		}
		public function redraw():void
		{
			var boxWidth:int = txt.width + 10;
			textOffset = 0//Number(myTxtFormat.size)-11;
			drawRoundedRectangle(off,boxWidth,boxHeight,cornerRadius,standardColors,fillAlpha,lineAlpha,lineWidth);
			drawRoundedRectangle(over,boxWidth,boxHeight,cornerRadius,hoverColors,fillAlpha*2,lineAlpha,lineWidth);
			drawRoundedRectangle(shade,boxWidth,boxHeight,cornerRadius,standardColors,fillAlpha,lineAlpha,lineWidth);
			drawRoundedRectangle(shine,boxWidth,boxHeight/2,cornerRadius,[0xFFFFFF,0xFFFFFF],fillAlpha/5,0,lineWidth);
			onRollOutButton();
		}
		
		private function drawRoundedRectangle(sprite:Sprite, boxWidth:int, boxHeight:int, cornerRadius:int, colorArray:Array, _fillAlpha:Number,_lineAlpha:Number,lineWidth:int):void 
		{
			sprite.graphics.clear();
			sprite.graphics.lineStyle(lineWidth,lineColor,_lineAlpha,true);
			var matr:Matrix = new Matrix()
			matr.createGradientBox(boxWidth,boxHeight,Math.PI/2);
			sprite.graphics.beginGradientFill(GradientType.LINEAR, colorArray, [_fillAlpha, _fillAlpha], [0x00, 0xFF], matr, SpreadMethod.PAD);
			sprite.graphics.drawRoundRect(0, 0, boxWidth, boxHeight, cornerRadius*2);
			sprite.graphics.endFill();
		}
	
		public function set text(newText):void
		{
			txt.text = newText;
		}
		
		private function onPressButton(evt:MouseEvent):void
		{
			//evt.stopImmediatePropagation();
			off.visible = true;
			over.visible = false;
			shade.visible = false;
			off.x = 1;
			off.y = 1;
			shine.x = 2
			shine.y = 2
			txt.x = 6;
			txt.y = 0+textOffset;
			mouseIsDown = true;
			try{stage.addEventListener(MouseEvent.MOUSE_UP, onReleaseButton,false,0,true);}catch(e){}
		}
		
		private function onRollOverButton(evt:MouseEvent):void
		{
			mouseIsOver = true;
			if (mouseIsDown)
			{
				onPressButton(new MouseEvent(""));
			}
			else
			{
				off.visible = false;
				over.visible = true;
			}
		}
		
		private function onRollOutButton(evt:MouseEvent=null):void
		{
			mouseIsOver = false;
			off.x = 0;
			off.y = 0;
			shine.x = 1
			shine.y = 1
			txt.x = 5;
			txt.y = -1 + textOffset;
			shade.visible = true;
			off.visible = true;
			over.visible = false;
		}
		
		private function onReleaseButton(evt:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onReleaseButton);
			mouseIsDown = false;
			off.x = 0;
			off.y = 0;
			shine.x = 1
			shine.y = 1
			txt.x = 5;
			txt.y = -1 + textOffset;
			shade.visible = true;
			off.visible = false;
			over.visible = true;
			if (mouseIsOver) callback.call();
		}
	}
}