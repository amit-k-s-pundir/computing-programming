package yourminis.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import yourminis.events.YMListCellEvent;
	public class YMDropDown extends YMList
	{
		private var dropDownButton:Sprite;
		private var levels:Array;
		private var followButton:Boolean;
		public var itemWidth:int = 100;
		
		public function YMDropDown( button:Sprite, fb:Boolean ) 
		{
			this.visible = false;
			dropDownButton = button;
			followButton = fb;
			if(followButton) setPosition();
			dropDownButton.addEventListener(MouseEvent.CLICK, toggleDropDown);
			dropDownButton.addEventListener(MouseEvent.ROLL_OVER, buttonOver);
			dropDownButton.addEventListener(MouseEvent.ROLL_OUT, buttonOut);
			
		}
		private function setPosition()
		{
			this.x = dropDownButton.x + dropDownButton.width - itemWidth;
			this.y = dropDownButton.y + dropDownButton.height+2;
		}
		public function toggleDropDown( evt:MouseEvent=null ):void 
		{
			
			if(followButton) setPosition(); 
			if (!this.visible) 
			{
				this.removeAll();
				dispatchEvent(new Event("dropdown-loaded"));
			}
			this.visible = !this.visible; 
			if (this.visible) stage.addEventListener(MouseEvent.MOUSE_UP, mouseClickHandler,false,0,true);
			
		}
		private function buttonOver( evt:MouseEvent ):void { hasMouseFocus = true; }
		private function buttonOut( evt:MouseEvent ):void { hasMouseFocus = false; }
		private function mouseClickHandler( evt:MouseEvent ):void 
		{ 
			if(!hasMouseFocus) this.visible = false;
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseClickHandler);
		}
		override protected function clickHandler( evt:YMListCellEvent ):void { dispatchEvent(evt); this.visible = false;}
	}
}