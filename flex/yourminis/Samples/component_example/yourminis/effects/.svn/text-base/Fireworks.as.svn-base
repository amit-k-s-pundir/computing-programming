package yourminis.effects
{
	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;	
	
	public class Fireworks extends Visualization
	{
		private var particles:Array;
		private var rockets:Array;
		public var timer:Timer;
		public var gravity:Number = 0.2;
		public var particlesPerRocket = 100;
		public var color:uint = 0xFFFFFFFF;
		public var baseTime:int=500;
		public var maxRockets:int=4;
		public var maxParticles:int=400;
		public var count:int = 0;
		
		public function Fireworks(_visualizer:Visualizer)
		{
			super(_visualizer);
			particles = new Array();
			rockets = new Array();
			timer = new Timer(1,0);
			timer.addEventListener("timer",launchRocket);
			timer.start();
			visualizer.addGlow(0xFFFFFF,3,2);
			visualizer.var1 = 0.8;
		}
		
		override public function onEnterFrame(evt:Event):void
		{
			for(var p:Object in particles)
			{
				var currentParticle:Object = particles[p];
				var particleColor = currentParticle.color;
				visualizer.bmpData.setPixel32(currentParticle.x, currentParticle.y, particleColor);
				positionParticle(currentParticle);
			}
			for(var r:Object in rockets)
			{
				var currentRocket:Object = rockets[r];
				visualizer.bmpData.fillRect(new Rectangle(currentRocket.x, currentRocket.y,3,8), currentRocket.color);
				positionRocket(currentRocket);
			}
		}
		private function positionParticle(particle:Object)
		{
			particle.x += particle.vx;
			particle.y += particle.vy;
			if (particle.y > visualizer.height)
			{
				particle.y = visualizer.height;
				particle.vy = -Math.abs(particle.vy/3);
			}
			particle.vy += gravity;
		}
		private function positionRocket(rocket:Object)
		{
			rocket.y += rocket.vy;
			var i:int = Math.round(Math.random()*2);
			while (i--) particles.unshift(createParticle(rocket.x, rocket.y, 0.5-Math.random(), 16, 0x33FFFF00));
			if (particles.length > maxParticles) particles.length = maxParticles;
			if (rocket.y <= rocket.my) explodeRocket(rocket);
		}
		
		private function createParticle(sx:int,sy:int,power:Number,angle:Number,pcolor:uint):Object
		{
			var particle = new Object();
			particle.x = sx;
			particle.y = sy;
			particle.color = pcolor;
			power = power/2 + power*Math.random();
			particle.vx = Math.cos(angle)*power;
			particle.vy = -Math.sin(angle)*power;
			return particle;
		}
		
		private function createRocket(sx:int,sy:int, my:int, power:Number, rcolor:uint):Object
		{
			count++;
			var rocket = new Object();
			rocket.x = sx;
			rocket.y = sy;
			rocket.vy = power;
			rocket.my = my;
			rocket.color = rcolor*Math.random();
			return rocket;
			
		}
		
		private function launchRocket(evt:Event)
		{
			timer.delay = baseTime+Math.round(Math.random()*baseTime/2);
			var sx:int = 15+Math.round(Math.random()*(visualizer.width-30));
			var sy:int = visualizer.height;
			var my:int = 20+Math.round(Math.random()*(visualizer.height/8));
			var power:Number = -8 + Math.random()*-2;
			var rcolor:uint = color;
			rockets.unshift(createRocket(sx, sy, my, power, color));
			if (rockets.length > maxRockets) rockets.length = maxRockets;
		}
		private function explodeRocket(rocket:Object):void
		{
			var i:int = particlesPerRocket;
			while (i--) particles.unshift(createParticle(rocket.x, rocket.y, Math.random()*Math.PI*2, Math.random()*16, rocket.color));
			if (particles.length > maxParticles) particles.length = maxParticles;
			rockets.pop();
		}
	}
}