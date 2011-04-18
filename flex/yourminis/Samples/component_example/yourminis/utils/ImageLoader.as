package yourminis.utils
{
	import yourminis.utils.LoadingIndicator;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.IOErrorEvent;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ImageLoader extends Sprite
	{
		private var _url:String;
		private var _maxWidth:Number;
		private var _maxHeight:Number;
		private var loader:Loader;
		private var clickurl:String;
		public var preserveRatio:Boolean;
		public var centerImage:Boolean;
		public var padding:Number;
		public var widget;
		public var loadingIndicator:LoadingIndicator;
		public var frameColor:int;
		public var frameBorderColor:int;
		public var frameAlpha:Number=1;
		public var frame:Sprite;
		public var error_txt:TextField
		public var loaderContent:*;

		
		public function ImageLoader(__url:String="",__maxWidth:Number=0,__maxHeight:Number=0,_preserveRatio:Boolean=false,_showIndicator:Boolean=false,_centerImage:Boolean=false,_padding:Number=0,_frameColor:int=-1,_frameBorderColor:int=-1)
		{
			_url = __url;
			preserveRatio = _preserveRatio;
			centerImage = _centerImage;
			padding = _padding;
			frameColor = _frameColor;
			frameBorderColor = _frameBorderColor;
			frame = new Sprite();
			error_txt = new TextField();
			error_txt.selectable = error_txt.mouseEnabled = false;
			setErrorTextFormat("No Image Available");
			addChild(frame);
			addChild(error_txt);
			loader = new Loader();
			addChild(loader);
			if (_showIndicator)
			{
				loadingIndicator = new LoadingIndicator();
				addChild(loadingIndicator);
			}
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			setSize(__maxWidth,__maxHeight);
			load(url);
		}
		public function setErrorTextFormat(label:String,_font:String="Verdana",_size:Number=10,_color:uint=0,_bold:Boolean=false)
		{
			var textFormat:TextFormat = new TextFormat(_font,_size,_color,_bold);
			textFormat.align = "center";
			error_txt.defaultTextFormat = textFormat;
			error_txt.text = label;
			error_txt.autoSize = "left"
			error_txt.wordWrap = true;
			error_txt.width = _maxWidth;
			error_txt.y = Math.round((_maxHeight-error_txt.height)/2);
		}
		public function drawFrame(color:uint=0x000000):void
		{
			frameColor = color;
			var sx:Number = 0;
			var sy:Number = 0;
			var w:Number = _maxWidth;
			var h:Number = _maxHeight;
			/*
			if (preserveRatio && loader.width)
			{
				w = loader.width + 2*padding;
				h = loader.height + 2*padding;
			}*/
			frame.graphics.clear();
			if (frameBorderColor > -1) frame.graphics.lineStyle(1,frameBorderColor);
			if (frameColor > -1) 
			{
				frame.graphics.beginFill(color,frameAlpha);
				frame.graphics.drawRect(sx,sy,w,h);
				frame.graphics.endFill();
			}
		}
		private function clickHandler(evt:MouseEvent):void
		{
			if (widget) widget.reporting.trackURL(clickurl); 
			else navigateToURL(new URLRequest(clickurl),"_blank");
		}
		private function errorHandler(evt:Event):void{error_txt.visible = true; if (loadingIndicator) loadingIndicator.loading = false; loader.visible = false;dispatchEvent(evt);}
		public function unload():void{loader.unload();}
		public function load(__url:String):void
		{
			var validURL:Boolean = (__url!="" && __url!=null);
			loader.visible = validURL;
			error_txt.visible = !validURL;
			_url = __url;
			if (loadingIndicator) loadingIndicator.loading = validURL;
			if (validURL) loader.load(new URLRequest(url));
		}
		private function loadHandler(evt:Event):void
		{
			try{loaderContent = evt.target.content;}catch(e){}
			frame.visible = true;
			if (loadingIndicator) loadingIndicator.loading = false;
			setSize(_maxWidth,_maxHeight);
			dispatchEvent(evt);
		}
		public function setSize(w:Number,h:Number)
		{
			//if (_maxWidth==w && _maxHeight==h) return;
			_maxWidth = w;
			_maxHeight = h;
			error_txt.width = _maxWidth;
			error_txt.y = Math.round((_maxHeight-error_txt.height)/2);
			if (loadingIndicator)
			{
				var mWidth:Number = (_maxWidth)?_maxWidth:loader.width/2;
				var mHeight:Number = (_maxHeight)?_maxHeight:loader.width/2;
				loadingIndicator.x = (mWidth-loadingIndicator.width)/2;
				loadingIndicator.y = (mHeight-loadingIndicator.height)/2;
			}
			if (frameColor>-1) drawFrame(frameColor);
			if (!loader.width) return;
			var ratio:Number;
			
			if (_maxWidth)
			{
				if (!preserveRatio) loader.width = _maxWidth-2*padding;
				else 
				{
					if (_maxWidth>=_maxHeight || !_maxHeight)
					{
						ratio = loader.height/loader.width;
						loader.width = _maxWidth-2*padding;
						loader.height = (_maxWidth-2*padding)*ratio;
						if (loader.height > _maxHeight-2*padding)
						{
							ratio = loader.width/loader.height;
							loader.height = _maxHeight-2*padding;
							loader.width = (_maxHeight-2*padding)*ratio;
						}
					}
				}
			}
			if (_maxHeight)
			{
				if (!preserveRatio) loader.height = _maxHeight-2*padding;
				else 
				{
					if (_maxHeight>=_maxWidth || !_maxWidth)
					{
						ratio = loader.width/loader.height;
						loader.height = _maxHeight-2*padding;
						loader.width = (_maxHeight-2*padding)*ratio;
						if (loader.width > _maxWidth-2*padding)
						{
							ratio = loader.height/loader.width;
							loader.width = _maxWidth-2*padding;
							loader.height = (_maxWidth-2*padding)*ratio;
						}
					}
				}
			}
			if (centerImage)
			{
				loader.x = (_maxWidth-loader.width)/2;
				loader.y = (_maxHeight-loader.height)/2;
				return;
			}
			else loader.x = loader.y = padding;
		}
		public function get loading():Boolean{return loadingIndicator.loading;}
		public function get url():String{return _url;}
		public function set loading(val:Boolean):void{loadingIndicator.loading = val;}
		public function get maxWidth():Number{return _maxWidth;}
		public function get maxHeight():Number{return _maxHeight;}
		public function set clickURL(_clickurl:String):void{this.buttonMode = true; this.clickurl = _clickurl; addEventListener(MouseEvent.CLICK,clickHandler);}
		override public function get width():Number{return loader.width;}
	}
}