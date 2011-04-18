package yourminis.effects
{
	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.*
	
	public class Splats extends Visualization
	{
		private var particles:Array;
		private var drips:Array;
		public var timer:Timer;
		public var gravity:Number = 0.2;
		public var particlesPerSplat = 20;
		public var dripsPerSplat = 6;
		//public var color:uint = 0xFFFFFFFF;
		public var baseTime:int=500;
		public var maxDrips:int=20;
		public var maxParticles:int=400;
		public var count:int = 0;
		public var precomp:Array;
		public var frameCounter:int;
		public var frameskip;
		public var mywidth;
		public var myheight;
		
		public function Splats(_visualizer:Visualizer)
		{
			frameskip = _visualizer.frameskip;
			mywidth = _visualizer.width;
			myheight = _visualizer.height;
			frameCounter = 0;
			super(_visualizer);
			
			precomp = new Array();
			var tnum;
			for (var i = 0; i < 300; i++) {
				tnum = 0xFF - (uint((63.0+i*192.0)/256.0));
				precomp.push(0xFF000000 + tnum*0x010000 + tnum*0x0100 + tnum)
			}
			
			particles = new Array();
			drips = new Array();
			
			//timer = new Timer(1,0);
			//timer.addEventListener("timer",createSplat);
			//timer.start();
		}
		
		override public function onEnterFrame(evt:Event):void
		{
			frameCounter++;
			
			if (frameCounter%frameskip == 0) {
				var currentParticle:Object;
				var wid:int;
				var p:Object
				//visualizer.bmpData.fillRect(new Rectangle(0,0,300,250),0);
				
				for (var i = 0; i < 30; i++) {
					visualizer.bmpData.setPixel32(Math.random()*mywidth, Math.random()*myheight, 0);
				}
				for(p in particles)
				{
					currentParticle = particles[p];
					wid = (Math.random()*4+10)*currentParticle.my/128;
					//
					visualizer.bmpData.fillRect(new Rectangle(currentParticle.x, currentParticle.y,wid,wid), precomp[uint(currentParticle.my)]&currentParticle.color)
					positionParticle(currentParticle);
					
				}
				for(p in drips)
				{
					currentParticle = drips[p];
					wid = (Math.random()*4+4)*currentParticle.my/256;
					visualizer.bmpData.fillRect(new Rectangle(currentParticle.x-wid/2, currentParticle.y,wid,currentParticle.vy), precomp[uint(currentParticle.my)]&currentParticle.color);
					positionDrip(currentParticle);
					
				}
			}
		}
		private function positionParticle(particle:Object)
		{
			particle.x += particle.vx;
			particle.y += particle.vy;
			
			particle.my -= int(Math.random()*40)+4;
			//if (particle.my <= 0 || particle.vy <= 0) particles.pop();
			
			/*if (particle.y > visualizer.height)
			{
				particle.y = visualizer.height;
				particle.vy = -Math.abs(particle.vy/3);
			}
			*/
			//particle.vy += gravity;
		}
		private function positionDrip(drip:Object)
		{
			drip.vy -= .4;
			drip.y += drip.vy;
			//var i:int = Math.round(randoms[randomIndex]*2);
			//while (i--) particles.unshift(createParticle(drip.x, drip.y, 0.5-randoms[randomIndex], 16, 0x33FFFF00));
			//if (particles.length > maxParticles) particles.length = maxParticles;
			drip.my-=int(Math.random()*8)+1;
			if (drip.my <= 0 || drip.vy <= 0) drips.pop();
			
		}
		
		private function createParticle(sx:int,sy:int,power:Number,angle:Number,size:Number,pcolor:uint):Object
		{
			var particle = new Object();
			particle.x = sx;
			particle.y = sy;
			particle.color = pcolor;
			power = power/2 + power*Math.random();
			particle.vx = Math.cos(angle)*power;
			particle.vy = -Math.sin(angle)*power;
			if (particle.vy < 0) particle.vy *= .5;
			particle.my = size;
			return particle;
		}
		
		private function createDrip(sx:int,sy:int, my:int, power:Number, rcolor:uint):Object
		{
			count++;
			var drip = new Object();
			drip.x = sx;
			drip.y = sy;
			drip.vy = power;
			drip.my = my;
			drip.color = rcolor;
			return drip;
			
		}
		
		private function startDrip(sx,sy,col)
		{
			//var sx:int = 15+Math.round(Math.random()*(visualizer.width-30));
			//var sy:int = visualizer.height;
			var my:int = int(Math.random()*128+127);
			var power:Number = 4 + Math.random()*8;
			drips.unshift(createDrip(sx, sy, my, power, col));
			if (drips.length > maxDrips) drips.length = maxDrips;
		}
		public function createSplat(px,py,col:uint = 0xFF0000):void
		{
			var mycol:uint = 0xFF000000 + col;//0xFF000000+(Math.floor(Math.random()*0xFF)*0x010000);
			var i:int = particlesPerSplat;
			
			while (i--) particles.unshift(createParticle(px, py, Math.random()*4+1, Math.random()*Math.PI*2, Math.random()*128+127, mycol));
			if (particles.length > maxParticles) particles.length = maxParticles;
			
			i = Math.ceil(Math.random()*dripsPerSplat);
			while (i--)	startDrip(Math.floor(px+Math.random()*40-20),Math.floor(py+Math.random()*40-20),mycol)
		}
	}
}