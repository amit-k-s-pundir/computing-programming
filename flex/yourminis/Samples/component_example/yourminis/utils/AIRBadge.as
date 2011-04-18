/* 
Adobe AIR Application Install Badge -- AS3

Required variables (to be passed in FlashVars parameter of Object & Embed tags in HTML):
o appname (name of application displayed in message under install button)
o appurl (url of .air file on server)
o airversion (version of the AIR Runtime)

*/


package yourminis.utils{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.ColorTransform;
	import flash.net.URLRequest;
	import flash.system.*;
	import flash.text.TextField;
	import flash.system.Capabilities;
	import flash.net.navigateToURL;

	public class AIRBadge extends MovieClip {

		public function AIRBadge(airVersion,appURL,appName) {
			_airVersion = airVersion;
			_appURL = appURL;
			_appName = appName;
		}
		
		public function init()
		{
			_loader = new Loader();
			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.applicationDomain = ApplicationDomain.currentDomain;
			_loader.contentLoaderInfo.addEventListener(Event.INIT, onInit);
			try {_loader.load(new URLRequest(BROWSERAPI_URL_BASE + "/air.swf"), loaderContext);} 
			catch (e:Error) {dispatch(e.message);}
		}

		private function onInit(e:Event):void {
			_air = e.target.content;
			switch (_air.getStatus()) {
				case "installed" :
					dispatch("Either you don't have our AIR file installed or it's not running. Please select an option:");
					break;
				case "available" :
					dispatch("Please click install below to setup Adobe® AIR™.");
					break;
				case "unavailable" :
					dispatch("Adobe® AIR™ is not available for your system.");
					break;
			}
		}
		private function isCorrectVersion():Boolean
		{
			var threshold:String = Capabilities.version;
			var version:String = "9,0,115,0";
			
			version = version.substr(version.indexOf(" ")+1);
			return versionToValue(version)>=versionToValue(threshold);
		}
		private function versionToValue(version:String):Number
		{
			var bArr:Array = version.split(".");
			var val:Number = 0;
			
			for (var i=0; i<bArr.length; i++)
			{
				val += Math.pow(1000,(3-i))*Number(bArr[i]);
			}
			return val;
		}
		public function installAIR():void {
			try {
				switch (_air.getStatus()) {
					case "installed" :
						if (isCorrectVersion()) dispatch("download");
						else
						{
							dispatch("Downloading yourminis AIR file...");
							_air.installApplication( _appURL, _airVersion );
						}
						break;
					case "available" :
						//
						//{
							//navigateToURL(new URLRequest("http://labs.adobe.com/downloads/air.html"),"_blank");
							//dispatch("Please install Adobe® AIR™...");
							//return;
						//}
						dispatch("Starting install... click 'Try Again' after application is running");
						_air.installApplication( _appURL, _airVersion );
						break;
					case "unavailable" :
						// do nothing
						break;
				}
			} catch (e:Error) {
				navigateToURL(new URLRequest("http://labs.adobe.com/downloads/air.html"),"_blank");
				dispatch("Please install Adobe® AIR™...");
				//dispatch(e.message);
			}
			/* clearInterval( _global.installIntId ); */
		}
		private function dispatch(str:String):void{_statusMessage=str; dispatchEvent(new Event("on-status"));}
		private const BROWSERAPI_URL_BASE: String = "http://airdownload.adobe.com/air/browserapi";
		
		public var _statusMessage:  String;
		private var _messageColor: String;
		private var _buttonColor: String;
		private var _imageURL: String;
		private var _appURL: String;
		private var _appName: String;
		private var _airVersion: String;

		private var _loader:Loader;
		private var _air:Object;
	}
}
