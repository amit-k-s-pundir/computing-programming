package yourminis.components
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import yourminis.utils.ColorExtended;
	
	public class YMColorPicker extends Sprite
	{
		private var hasMouseFocus:Boolean = false;
		private var spectrum:Bitmap;
		private var spectrumData:BitmapData;
		private var bg:Sprite;
		private var colorPickerButton:Sprite;
		private var colorExtender:ColorExtended;
		private var followButton:Boolean;
		private var cwidth=124;
		private var cheight=110;
		private var swidth:int;
		private var sheight:int;
		private var color:uint;
		public var callback:Function;
		public var alignLeft:Boolean = true;
		
		public function YMColorPicker( button:Sprite, _callback:Function, fb:Boolean=true ) 
		{
			visible = false;
			callback = _callback;
			followButton = fb;
			swidth = cwidth-4;
			sheight = cheight-4;
			spectrumData = new BitmapData(swidth,sheight,false,0xFF000000)
			spectrum = new Bitmap(spectrumData);
			colorExtender = new ColorExtended();
			bg = new Sprite();
			this.addChild(bg);
			this.addChild(spectrum);
			spectrum.x = spectrum.y = 2;
			colorPickerButton = button;
			bg.addEventListener(MouseEvent.MOUSE_DOWN, spectrumPress);
			colorPickerButton.addEventListener(MouseEvent.CLICK, togglecolorPicker);
			colorPickerButton.addEventListener(MouseEvent.ROLL_OVER, buttonOver);
			colorPickerButton.addEventListener(MouseEvent.ROLL_OUT, buttonOut);
			drawColorPicker();
		}
		private function spectrumPress(event:MouseEvent):void{		
			event.stopPropagation();
			root.addEventListener(MouseEvent.MOUSE_UP, spectrumRelease,false,0,true);
			root.addEventListener(MouseEvent.MOUSE_MOVE, spectrumMove,false,0,true);
			spectrumMove(event);
		}
		private function spectrumRelease(event:MouseEvent):void{
			
			root.removeEventListener(MouseEvent.MOUSE_UP, spectrumRelease);
			root.removeEventListener(MouseEvent.MOUSE_MOVE, spectrumMove);
			callback(color,false);
		}
		private function spectrumMove(event:MouseEvent):void
		{
			this.color = spectrumData.getPixel(spectrum.mouseX,spectrum.mouseY);
			callback(color,true)
		}
		
		private function drawColorPicker()
		{
			bg.graphics.beginFill(0x333333);
			bg.graphics.drawRect(0,0,cwidth,cheight);
			bg.graphics.endFill();
			var c:uint = 0;
			var o:Object;
			var l:int=0;
			for (var j = 0; j<sheight; j++)
			{
			    for (var i = 0; i < swidth; i++)
				{
					l = Math.round(((sheight-j)*240)/sheight);
					o = colorExtender.HLSToRGB(i*2,l,240); 
					c = colorExtender.RGBToHEX(o.r,o.g,o.b);
					spectrumData.setPixel(i,j,c);
				}
			}
		}
		
		
		private function setPosition()
		{
			this.x = colorPickerButton.x + int(alignLeft)*(colorPickerButton.width - this.width);
			this.y = colorPickerButton.y + colorPickerButton.height+2;
		}
		public function togglecolorPicker( evt:MouseEvent ):void 
		{ 
			if(followButton) setPosition(); this.visible = !this.visible; 
			if (this.visible) root.addEventListener(MouseEvent.MOUSE_UP, mouseClickHandler,false,0,true);
		}
		private function buttonOver( evt:MouseEvent ):void { hasMouseFocus = true; }
		private function buttonOut( evt:MouseEvent ):void { hasMouseFocus = false; }
		private function mouseClickHandler( evt:MouseEvent ):void 
		{ 
			if(!hasMouseFocus) this.visible = false;
			root.removeEventListener(MouseEvent.MOUSE_UP, mouseClickHandler);
		}
	}
}