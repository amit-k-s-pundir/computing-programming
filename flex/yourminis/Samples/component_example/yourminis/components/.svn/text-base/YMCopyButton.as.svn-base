package yourminis.components
{
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.geom.Matrix;
	import yourminis.api.Widget;
	import yourminis.effects.Flare;
	import yourminis.components.YMLogo;	
	import yourminis.components.PulseButton;
	import yourminis.utils.ColorExtended;
	
	public class YMCopyButton extends Sprite
	{
		private var bg:Sprite;
		private var shine:Sprite;
		private var over:Sprite;
		private var off:Sprite;
		private var colorExtender:ColorExtended;
		public var callback:Function;
		public var txt:TextField;
		private var myTxtFormat:TextFormat;
		private var mouseIsDown:Boolean=false;
		private var mouseIsOver:Boolean;
		private var widget;
		private var flare:Flare;
		private var pulseButton:PulseButton;
		private var boxWidth:int=73;
		private var boxHeight:int=16;
		
		public function YMCopyButton(_widget:Widget)
		{
			widget = _widget;
			colorExtender = new ColorExtended();
		}
		public function initializeCopyButton():void
		{
			bg = new Sprite();
			off = new Sprite();
			over = new Sprite();
			shine = new Sprite();
			txt = new TextField()
			
			var icon = widget.syndication.buttonIcon;
			if (!icon) icon = new YMLogo(12,12);
			icon.x = 6;
			icon.y = (boxHeight-icon.height)/2;
			
			txt.x = 8+icon.width;
			txt.y = -1;
			txt.selectable = false;
			
			txt.autoSize = "left";
			txt.mouseEnabled = false;
			myTxtFormat = new TextFormat();
			myTxtFormat.font = "Trebuchet MS";
			myTxtFormat.size = 11;
			myTxtFormat.color = 0;
			myTxtFormat.bold = true;
			txt.defaultTextFormat = myTxtFormat;
			txt.text = widget.syndication.buttonText.toUpperCase();
			over.visible = false;
			
			boxWidth = txt.width + txt.x + 5;
			var cornerRadius:Number = 7;
			var lineWidth:int = 1;
			flare = new Flare(35,boxHeight,boxWidth);
			
			icon.mouseEnabled = flare.mouseEnabled = false;
			var color1:uint = widget.syndication.buttonColor;
			var color2:uint = colorExtender.gradient(color1,0.9);
			var color3:uint = colorExtender.gradient(color1,1.1);
			var colors1:Array = [color1,color2];
			var colors2:Array = [color3,color1];
			drawRoundedRectangle(off,boxWidth,boxHeight,cornerRadius,colors1,1,1,color2);
			drawRoundedRectangle(over,boxWidth,boxHeight,cornerRadius,colors2,1,1,color2);
			drawRoundedRectangle(flare.flareMask,boxWidth,boxHeight,cornerRadius,colors1,1,1,color2);
			drawRoundedRectangle(shine,boxWidth,boxHeight/2,cornerRadius,[0xFFFFFF,0xFFFFFF],0.2,0,color2);
			addEventListener(MouseEvent.MOUSE_DOWN,onPressButton);
			addEventListener(MouseEvent.ROLL_OVER,onRollOverButton);
			addEventListener(MouseEvent.ROLL_OUT,onRollOutButton);
			
			buttonMode = true;
			useHandCursor = true;
			
			addChild(bg);
			bg.addChild(over);
			bg.addChild(off);
			bg.addChild(shine);
			bg.addChild(icon);
			bg.addChild(flare);
			addChild(txt);
			pulseButton = new PulseButton(bg,null,onRollOutButton,widget.syndication.buttonPulseColor);
			if (color1!=0xE5E5E5) txt.textColor = 0xFFFFFF;
		}
		private function drawRoundedRectangle(sprite:Sprite, boxWidth:int, boxHeight:int, cornerRadius:int, colorArray:Array, fillAlpha:Number,lineAlpha:Number,lineColor:int):void 
		{
			sprite.graphics.clear();
			sprite.graphics.lineStyle(1,lineColor,lineAlpha,true);
			var matr:Matrix = new Matrix()
			matr.createGradientBox(boxWidth,boxHeight,Math.PI/2);
			sprite.graphics.beginGradientFill(GradientType.LINEAR, colorArray, [fillAlpha, fillAlpha], [0x00, 0xFF], matr, SpreadMethod.PAD);
			sprite.graphics.drawRoundRect(0, 0, boxWidth, boxHeight, cornerRadius*2);
			sprite.graphics.endFill();
		}
	    override public function get width():Number{return boxWidth;}
		private function onPressButton(evt:MouseEvent):void
		{
			off.visible = true;
			over.visible = false;
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
			off.visible = true;
			over.visible = false;
		}
		
		private function onReleaseButton(evt:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onReleaseButton);
			mouseIsDown = false;
			off.visible = false;
			over.visible = true;
			widget.syndication.openSyndication();
		}
		public function set pulseColor(color:uint):void{pulseButton.pulseColor = color;}
		public function get pulseColor():uint{return pulseButton.pulseColor;}
	}
}