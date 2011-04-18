package yourminis.utils
{
	import flash.text.TextField
	import flash.display.Stage
	public class Logger
	{
		private var logField:TextField;
		
		public function Logger( s:Stage )
		{
			logField = new TextField();
			logField.width = 800;
			logField.height = 500;
			logField.y = 150;
			logField.border = true;
			s.addChild(logField);
		}
		
		public function log( type:String, logKey:String, logValue:String ):void 
		{
			logField.appendText(type + " - " + logKey + ": " + logValue + "\n");
		}
	}
}