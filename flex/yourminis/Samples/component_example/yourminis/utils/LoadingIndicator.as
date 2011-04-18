package yourminis.utils
{
	import flash.display.Shape;
	import flash.utils.Timer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	public class LoadingIndicator extends Sprite
	{
		private var hand:Shape;
		private var timer:Timer;
		private var bg:Shape;
		private var textbox:TextField;
		private var _loading:Boolean=false;
		private var color:uint=0x888888;
		private var init:Boolean = false;
		private var _width:Number = 100;
		private var _height:Number = 26;
		private var counter;
		private var lengths:Array;
		private var curlengths:Array;
		private var anglesx:Array;
		private var anglesy:Array;
		private static var minlen = 2;
		private static var maxlen = 7;
		private static var innerlen = 6;
		public function LoadingIndicator()
		{
			visible = false;
			timer = new Timer(20);
			timer.addEventListener("timer",timerHandler);
			anglesx = new Array();
			anglesy = new Array();
			lengths = new Array();
			curlengths = new Array();
			
			for (var i = 0; i < 8; i++) {
				lengths.push(minlen);
				curlengths.push((maxlen+minlen)/2);
				anglesx.push(Math.cos(i*Math.PI/4));
				anglesy.push(Math.sin(i*Math.PI/4));
			}
			counter = 0;
			bg = new Shape();
			hand = new Shape();
			textbox = new TextField();
			addChild(bg);
			addChild(hand);
			addChild(textbox);
			hand.x = 16;
			hand.y = 13;
			textbox.x = 30;
			textbox.y = 2;
			textbox.autoSize = "left";
			textbox.selectable = false;
			textbox.defaultTextFormat = new TextFormat("Arial Black",13,color,false);
			
			var z;
			var r;
			var rat;
			for (var k = 0; k < 24; k++) {
				counter++;
				z = (Math.floor(counter/6))%8;
				lengths[z] = 4;
				for (i = 0; i < 8; i++) {
					if (i!=z) lengths[i] = minlen;
					curlengths[i] += (lengths[i]-curlengths[i])/2.0;
				}
			}
			drawAll();
		}
		private function timerHandler(evt:Event):void
		{
			drawAll();
		}
		private function drawAll() {
			counter++;
			hand.graphics.clear();
			
			var z = (Math.floor(counter/6))%8;
			var r;
			var rat;
			
			lengths[z] = 4;
			for (var i = 0; i < 8; i++) {
				if (i!=z) lengths[i] = minlen;
				curlengths[i] += (lengths[i]-curlengths[i])/2.0;
				r = Math.max(innerlen + curlengths[i],5);
				rat = (curlengths[i]-minlen)/(maxlen-minlen);
				hand.graphics.lineStyle(3.5+rat*2,0,Math.max(Math.pow( rat,.1),.1),true);
				hand.graphics.moveTo(anglesx[i]*innerlen,anglesy[i]*innerlen);
				hand.graphics.lineTo(anglesx[i]*r,anglesy[i]*r);
			}
		}
		private function drawShapes():void
		{
			textbox.text = "loading...";
			
			/*
			hand.graphics.lineStyle(1.5,color,1)
			hand.graphics.moveTo(0,0);
			hand.graphics.lineTo(4,0);
			hand.graphics.endFill();
			*/
			//Main Background
			//bg.graphics.lineStyle(2,color,1,false,"none");
			bg.graphics.beginFill(0xFFFFFF,0.8);
			bg.graphics.drawRoundRect(0,0,_width,_height,20);
			bg.graphics.endFill();
			//Clock Background
			//bg.graphics.beginFill(0xFFFFFF,1);
			//bg.graphics.drawRoundRect(5,3,12,12,10);
			//bg.graphics.endFill();
		}
		public function set loading(val:Boolean):void
		{
			if (!init) drawShapes();
			init = true;
			_loading = val;
			this.visible = val;
			if (val) timer.start();
			else timer.reset();
		}
		public function get loading():Boolean{return _loading;}
		override public function get width():Number{return _width;}
		override public function get height():Number{return _height;}
	}
}
