package yourminis.components
{
	import yourminis.components.PulseButton;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class YMPlayPauseButton extends Sprite
	{
		public var playButton:Sprite;
		public var pauseButton:Sprite;
		private var bg:Sprite;
		public var color:uint=0xFFFFFF;
		public var bgcolor:uint=0;
		private var _state:int;
		private var _d:Number=16;
		public var _callback:Function;
		private var play_mc:MovieClip;
		private var pause_mc:MovieClip;
		
		public function YMPlayPauseButton(callback:Function,initState=0,_pulseColor:uint=0x00CCFF, _play_mc:MovieClip=null, _pause_mc:MovieClip=null)
		{
			play_mc = _play_mc;
			pause_mc = _pause_mc;
			bg = new Sprite();
			playButton = new Sprite();
			pauseButton = new Sprite();
			if (play_mc) playButton.addChild(play_mc);
			if (pause_mc) pauseButton.addChild(pause_mc);
			_callback = callback;
			addChild(bg);
			addChild(pauseButton);
			addChild(playButton);
			_state = initState;
			if (_state == 0) pauseButton.visible = false;
			else playButton.visible = false;
			var pb1:PulseButton = new PulseButton(playButton,null,playHandler,_pulseColor);
			var pb2:PulseButton = new PulseButton(pauseButton,null,pauseHandler,_pulseColor);
			
			setSize(_d);
		}
		public function switchState():void
		{
			if (_state==1) pauseHandler();
			else playHandler();
		}
		public function playHandler():void
		{
			playButton.visible = false;
			pauseButton.visible = true;
			_state = 1;
			_callback(_state)
		}
		public function pauseHandler():void
		{
			playButton.visible = true;
			pauseButton.visible = false;
			_state = 0;
			_callback(_state)
		}
		public function setSize(d:Number):void
		{
			if (!play_mc)
			{
				_d = d;
				var du:Number = (d/8);
				bg.graphics.clear();
				if (bgcolor>=0)
				{
					bg.graphics.beginFill(bgcolor,0.9);
					bg.graphics.drawRoundRect(0,0,d,d,8);
					bg.graphics.endFill();
				}
				
				playButton.graphics.clear();
				playButton.graphics.beginFill(0,0);
				playButton.graphics.drawRoundRect(0,0,d,d,8);
				playButton.graphics.endFill()
				playButton.graphics.beginFill(color);
				playButton.graphics.moveTo(du*3,du);
				playButton.graphics.lineTo(du*3,du*7);
				playButton.graphics.lineTo(du*6,du*4);
				playButton.graphics.lineTo(du*3,du);
				playButton.graphics.endFill();
				
				pauseButton.graphics.clear();
				pauseButton.graphics.beginFill(0,0);
				pauseButton.graphics.drawRoundRect(0,0,d,d,8);
				pauseButton.graphics.endFill()
				pauseButton.graphics.beginFill(color);
				pauseButton.graphics.drawRect(du*2,du*1.5,du*1.5,du*5)
				pauseButton.graphics.drawRect(du*4.5,du*1.5,du*1.5,du*5)
				pauseButton.graphics.endFill();
			}
		}
		public function get state():int{return _state;}
	}
}