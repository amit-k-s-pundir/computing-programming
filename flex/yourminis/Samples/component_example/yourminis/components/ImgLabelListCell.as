package yourminis.components
{
	import flash.display.Sprite;
	import flash.text.StyleSheet;
	import flash.text.*;
	import flash.display.*;
	import flash.net.URLRequest;
	import flash.events.MouseEvent;
	import yourminis.events.YMListCellEvent;
	import flash.filters.*;
	
	
	public class ImgLabelListCell extends ListCell
	{
		private var cellContent:DisplayObject;
		private var txt:TextField;
		public var txtformat:TextFormat;
		public var cellPadding:Number;
		private var thumbWidth:Number;
		private var thumbHeight:Number;
		private var glowColor:uint;
		private var this_mc;
		
		public function ImgLabelListCell( imageURL:*, label:String, data:*, w:Number, h:Number, _imageHeight:Number=60, _color:uint=0xFFFFFF, _size=11, _align=TextFormatAlign.CENTER, cp:Number=3, glowcol:uint=0, _font:String="Verdana", resizeContent:Boolean=false )
		{
			this_mc = this;
			super( data, w+cp*2, h+cp*2 );
			cellPadding = cp;
			thumbWidth = w;
			thumbHeight = h;
			glowColor = glowcol;
			
			if (imageURL is String) {
				cellContent = new Loader();
				Loader(cellContent).load(new URLRequest(imageURL));
			}
			else {
				cellContent = imageURL;
				
			}
			if (resizeContent) {
				cellContent.width = w;
				cellContent.height = h;
			}
			
			buttonMode = true;
			useHandCursor = true;
			txt = new TextField();
			txt.x = cp;
			txt.width = w-cp*2;
			txt.autoSize = "left";
			txt.wordWrap = true;
			txt.selectable = false;
			txt.y = _imageHeight;
			txt.multiline = true;
			
			txt.mouseEnabled = false;
			if (_font!="Verdana") txt.embedFonts = true;
			txtformat = new TextFormat();
			txtformat.font = "P22 Underground";
			txtformat.size = _size;
			txtformat.color = _color;
			txtformat.align = _align;
			txtformat.bold = true;
			//txt.border = true;
			txt.defaultTextFormat = txtformat;
			txt.text = label;
			cellContent.x = cp;
			cellContent.y = cp;
			addChild(cellContent);
			addChild(txt);
			
			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(MouseEvent.ROLL_OVER, overHandler);
			addEventListener(MouseEvent.ROLL_OUT, outHandler);
			outHandler(new MouseEvent(MouseEvent.ROLL_OUT));
		}
		
		private function clickHandler( evt:MouseEvent )
		{
			evt.stopPropagation();
			dispatchEvent( new YMListCellEvent(YMListCellEvent.CLICK, cellIndex, cellData) );
		}
		private function overHandler(evt:MouseEvent)
		{
			//txtformat.bold = true;
			//txt.setTextFormat(txtformat);
			//cellContent.y = cellPadding-2;
			if (glowColor != 0) this_mc.filters = [new GlowFilter(glowColor,1,10,10,2)];
		}
		private function outHandler(evt:MouseEvent)
		{
			//cellContent.y = cellPadding;
			//txtformat.bold = false;
			//txt.setTextFormat(txtformat);
			if (glowColor != 0) this_mc.filters = [];
		}
		

	}
}