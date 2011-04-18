package yourminis.components
{
	import yourminis.effects.Pulse;
	import flash.events.MouseEvent;
	
	public class PulseButton extends Pulse
	{
		private var data:*;
		private var callback:Function;
		private var _selected:Boolean=false;
		private var selectable:Boolean;
	
		public function PulseButton(sprite:Object,_data:*,_callback:Function,_pulseColor:uint=0x00CCFF,_selectable:Boolean=false)
		{
			data = _data;
			selectable = _selectable;
			callback = _callback;
			super(sprite,_pulseColor);
			sprite.addEventListener(MouseEvent.CLICK,onMouseClick);
			sprite.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
			sprite.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
			sprite.buttonMode = true;
		}
		private function onRollOut(evt:MouseEvent){if (!selected) stopPulse();}
		private function onRollOver(evt:MouseEvent){if (!selected) startPulse();}
		private function onMouseClick(evt:MouseEvent){if (data!=null) callback(data); else callback();}
		public function get selected():Boolean{return _selected;}
		public function set selected(isSelected:Boolean)
		{
			_selected = isSelected;
			if (_selected) {filterStrength = maxPulseStrength; doPulse(); timer.reset();}
			else stopPulse();
		}
	}
}