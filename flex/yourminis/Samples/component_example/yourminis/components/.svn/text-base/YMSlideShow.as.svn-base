package yourminis.components {
	
	import yourminis.utils.ImageLoader;
	import yourminis.components.YMPlayPauseButton;
	import yourminis.components.YMIndexSelector;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.display.Sprite;
	
	public class YMSlideShow extends Sprite
	{
		
		public var iLoader:ImageLoader; 
		public var playpause_btn:YMPlayPauseButton;
		public var indexSelector:YMIndexSelector;
		public var timer:Timer;
		public var cornerRadius=10;
		public var color:uint=0;
		public var controls:Sprite;
		public var padding:Number = 3;
		public var controlAlpha:Number=0.5;
		public var alignment:Number = 2;
		private var _speed:Number=5000;
		private var photoArray:Array;
		
		public function YMSlideShow()
		{
			iLoader = new ImageLoader("",200,200,true,true,true,padding,color);
			controls = new Sprite();
			indexSelector = new YMIndexSelector(onSelectIndex);
			playpause_btn = new YMPlayPauseButton(onPlayPause);
			timer = new Timer(_speed);
			
			addChild(iLoader);
			addChild(controls);
			controls.addChild(indexSelector);
			controls.addChild(playpause_btn);
			
			timer.addEventListener("timer",next);
		}
		public function play():void{playpause_btn.playHandler();}
		public function pause():void{playpause_btn.pauseHandler()}
		public function next(evt:Event=null):void{indexSelector.increment();}
		public function previous(evt:Event=null):void{indexSelector.decrement();}
		public function set speed(__speed:Number){_speed=__speed; timer.delay = _speed;}
		public function get speed():Number{return _speed;}
		public function setSize(w:Number,h:Number):void
		{
			iLoader.setSize(w,h);
			indexSelector.y = playpause_btn.x = padding;
			playpause_btn.y = padding + 1;
			indexSelector.x = padding + (playpause_btn.width+padding)*int(playpause_btn.visible);
			var cwidth:Number = indexSelector.x + indexSelector.width + padding;
			controls.graphics.clear();
			controls.graphics.beginFill(color,controlAlpha);
			controls.graphics.drawRoundRect(0,0,cwidth, indexSelector._height + 2*padding,2*cornerRadius);
			controls.graphics.endFill();
			
			var xalign = (alignment)%3;
			var yalign = Math.floor((alignment-1)/3);
			
			switch (xalign) {
				case 0: controls.x = w-controls.width-2*padding; break;
				case 1: controls.x = 2*padding; break;
				case 2: controls.x = (w-controls.width)/2; break;
			}
			
			switch (yalign) {
				case 0: controls.y = h-controls.height-2*padding; break;
				case 1:	controls.y = (h-controls.height)/2;	break;
				case 2:	controls.y = 2*padding;	break;
			}
			
		}
		private function onPlayPause(state:int):void
		{
			if (state) timer.start();
			else timer.reset();
		}
		public function setPhotos(_photoArray:Array,_autoplay:Boolean=true):void
		{
			photoArray = _photoArray;
			indexSelector.total = photoArray.length;
			indexSelector.index = 0;
			if (_autoplay && playpause_btn.visible) play();
		}
		public function onSelectIndex(index:int)
		{
			timer.reset();
			timer.start();
			iLoader.load(photoArray[index]);
		}
	}
}