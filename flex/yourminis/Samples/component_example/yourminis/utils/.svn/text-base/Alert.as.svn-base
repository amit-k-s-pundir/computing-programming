package yourminis.utils
{
	import yourminis.components.YMButton;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	public class Alert extends Sprite
	{
		private var modal:Sprite;
		private var bg:Sprite;
		private var alert_txt:TextField;
		private var ok_btn:YMButton;
		private var cancel_btn:YMButton;
		private var callback:Function;
		private var cancelcallback:Function;
		private var bgwidth:Number=0;
		public function Alert()
		{
			visible = false;
			modal = new Sprite();
			bg = new Sprite();
			alert_txt = new TextField();
			alert_txt.defaultTextFormat = new TextFormat("Verdana",11,0x444444,null,null,null,null,null,"center");
			alert_txt.wordWrap = true;
			alert_txt.autoSize = "left";
			ok_btn = new YMButton("Ok", okAlert,0,0);
			cancel_btn = new YMButton("Cancel", cancelAlert,0,0);
			
			alert_txt.x = alert_txt.y = 5;
			alert_txt.height = 110;
			ok_btn.y = cancel_btn.y = 75;
			
			
			bg.addChild(ok_btn);
			bg.addChild(cancel_btn);
			bg.addChild(alert_txt);
			addChild(modal);
			addChild(bg);
		}
		public function setSize(w:Number,h:Number,cornerRadius:Number=20):void
		{
			bgwidth = Math.min((3*w/4),300);
			bg.graphics.clear();
			bg.graphics.lineStyle(2,0xCCCCCC);
			bg.graphics.beginFill(0xFFFFFF);
			bg.graphics.drawRoundRect(0,0,Math.round(bgwidth),100,cornerRadius);
			bg.graphics.endFill();
			bg.x = Math.round((w-bgwidth)/2);
			bg.y = Math.round((h-100)/2);
			
			modal.graphics.clear();
			modal.graphics.beginFill(0,0.85);
			modal.graphics.drawRoundRect(0,0,w,h,cornerRadius);
			modal.graphics.endFill();
			
			alert_txt.width = bgwidth - 10;
		}
		public function alert(_message:String, _callback:Function=null, _cancelcallback:Function=null)
		{
			if (_cancelcallback==null) 
			{
				ok_btn.x = Math.round((bgwidth-ok_btn.width)/2);
				cancel_btn.visible = false;
			}
			else
			{
				ok_btn.x = Math.round((bgwidth-ok_btn.width)/3);
				cancel_btn.x = Math.round(2*(bgwidth-ok_btn.width)/3)-10;
				cancel_btn.visible = true;
			}
			visible = true;
			
			callback = _callback;
			cancelcallback = _cancelcallback;
			alert_txt.text = _message;
			alert_txt.y = Math.round((80-alert_txt.height)/2);
			addEventListener(KeyboardEvent.KEY_DOWN,okAlert);
		}
		private function okAlert(evt:Event=null):void
		{
			removeEventListener(KeyboardEvent.KEY_DOWN,okAlert);
			visible = false;
			if (callback!=null) callback();
			cancelcallback=callback=null;
		}
		private function cancelAlert(evt:Event=null):void
		{
			removeEventListener(KeyboardEvent.KEY_DOWN,okAlert);
			visible = false;
			cancelcallback();
			cancelcallback=callback=null;
		}
		
	}
}