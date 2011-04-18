package yourminis.components
{
	import flash.display.*;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import yourminis.events.YMListCellEvent;
	import yourminis.utils.ImageLoader;
	
	public class ThumbListCell extends ListCell
	{
		private var cellLabel:TextField;
		private static var cellPadding:Number = 3;
		private var cellMargin:Number;
		private var cellBackground:Sprite;
		private var cellContent:DisplayObject;
		private var loaderContent:Loader;
		private var cwidth:Number;
		private var cheight:Number;
		private var twidth:Number;
		private var theight:Number;
		private var mytext:Array;
		private var overColor:Number;
		private var overAlpha:Number;
		private var outColor:Number;
		private var outAlpha:Number;
		private var isLoader:Boolean;
		private var this_mc
		
		public function ThumbListCell( cc:*, labelText:Array, data:*, w:Number, h:Number, tw:Number = 0, cm:Number = 0, overc:Number = 0, overa:Number = 0.5, outc:Number = 0, outa:Number = 0, preserveRatio:Boolean = true)
		{
			this_mc = this;
			super( data, w, h );
			cwidth = w;
			twidth = 0;
			cellMargin = 0;
			cellMargin = cm;
			twidth = tw;
			theight = cheight = h;
			//draw & add background 
			cellBackground = new Sprite();
			drawBackground(0,0);
			this.addChild(cellBackground);
			//add textfield
			cellLabel = new TextField();
			var format:TextFormat = new TextFormat();
            format.font = "Verdana";
			format.color = 0xFFFFFF;
			cellLabel.wordWrap = true;
			//cellLabel.autoSize = "left";
			cellLabel.defaultTextFormat = format;
			cellLabel.selectable = false;
			cellLabel.mouseEnabled = false;
			mytext = labelText;
			cellBackground.buttonMode = true;
			
			overColor = overc;
			overAlpha = overa;
			outColor = outc;
			outAlpha = outa;
			
			if (cc is String) {
				isLoader = true;
				cellContent = new ImageLoader(cc,tw,h,preserveRatio,false,true);
			}
			else {
				isLoader = false;
				cellContent = cc;
			}
			
			cellContent.x = cellPadding;
			cellContent.y = cellPadding;
			this.addChild(cellLabel);
			this.addChild(cellContent);
			
			//add event handlers
			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(MouseEvent.ROLL_OVER, overHandler);
			addEventListener(MouseEvent.ROLL_OUT, outHandler);
			
			
			drawBackground(outColor,outAlpha);
			resize(w,h)
		}
		
		/*
		public function loadImage(url:String) {
			var urlReq:URLRequest = new URLRequest(url);
			loaderContent = Loader(cellContent);
			loaderContent.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
			loaderContent.load(urlReq);
		}
		public function imageLoaded(evt:Event) {
			if (twidth != 0) {
				theight = evt.target.height;
			}
			else {
				twidth = evt.target.width
				theight = evt.target.height;
			}
			
			imgLoaded = true;
			imgRatio = evt.target.width/evt.target.height;
			resize(cwidth,cheight);
		}
		*/
		
		private function clickHandler( evt:MouseEvent )
		{
			dispatchEvent( new YMListCellEvent(YMListCellEvent.CLICK, cellIndex, cellData) );
		}
		
		private function overHandler( evt:MouseEvent )
		{
			drawBackground(overColor,overAlpha);
			if (this_mc.parent) this_mc.parent.dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OVER, cellIndex, cellData) );

		}
		
		private function outHandler( evt:MouseEvent )
		{
			drawBackground(outColor,outAlpha);
			if (this_mc.parent) this_mc.parent.dispatchEvent(new YMListCellEvent(YMListCellEvent.ROLL_OUT, cellIndex, cellData) );
		}
		
		private function dblClickHandler( evt:MouseEvent )
		{
			trace("Double Click");
		}
		
		private function drawBackground ( color:Number, a:Number )
		{
			cellBackground.graphics.clear();
			cellBackground.graphics.beginFill(color,a);
			cellBackground.graphics.drawRect(0,0,10,10);
			cellBackground.graphics.endFill();
		}
		public override function resize( w:Number, h:Number )
		{
			cellWidth = w;
			cellHeight = theight + cellPadding*2 + cellMargin;
			prototype.cellWidth = w;
			prototype.cellHeight = theight + cellPadding*2 + cellMargin;
			cellBackground.width = cellWidth;
			cellBackground.height = cellHeight - cellMargin;
			cellLabel.x = cellPadding*2 + twidth;
			cellLabel.y = cellPadding;
			cellLabel.width = cellWidth - (cellPadding*3) - twidth - 16;
			cellLabel.height = cellHeight - (cellPadding*2);
			
			if (isLoader) {
				ImageLoader(cellContent).setSize(twidth,theight);
			}
			
			var n:Number;
			var str:String;
			var total_str:String;
			total_str = "";
			if (cellLabel.width) {
				for (var i = 0; i < mytext.length; i++) {
					n = mytext[i][1];
					str = mytext[i][0];
					
					
					if (n == 0) {
						total_str += str;
					}
					else {
						total_str += getTextFit(str,cellLabel.width/n);
					}
				}
				cellLabel.htmlText = total_str;
			}
			
		}
		private function getTextFit(content:String,strLen:Number):String {
		
			if(content == "" || content == null || typeof(content) == "undefined") {
				return content;
			}
			var oldlen = content.length;
			content = content.substr(0,strLen);
			if (content.length != oldlen) content += "...";
			return content;
		}
		
		public function get label():Array
		{
			return this.mytext;
		}
		
		public function set label( labelText:Array):void
		{
			this.mytext = labelText;
		}
		
	}
}