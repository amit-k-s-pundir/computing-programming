package yourminis.utils
{
	import flash.display.Sprite;
	public class IndexSelector extends Sprite
	{

		protected var callback:Function;
		protected var _total:int = 0;
		protected var _index:int = 0;
		public function IndexSelector(_callback:Function)
		{
			callback = _callback;
		}
		public function increment(...args):void
		{
			_index++;
			if (_index>_total-1) _index = 0;
			update();
			if (args[0] != true) callback(_index)
		}
		public function decrement(...args):void
		{
			_index--;
			if (_index<0) _index = _total-1;
			update();
			if (args[0] != true) callback(_index);
		}
		public function set total(newTotal:int):void{_total=newTotal; update();}
		public function get total():int{return _total;}
		public function set index(newIndex:int):void{_index=newIndex; update(); callback(_index);}
		public function get index():int{return _index;}
		public function update():void{}
	}
}