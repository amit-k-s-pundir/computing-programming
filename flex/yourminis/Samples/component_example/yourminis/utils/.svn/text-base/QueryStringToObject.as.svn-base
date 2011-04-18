package yourminis.utils
{
	public class QueryStringToObject extends Object
	{
		private var settings:Object;
		public function QueryStringToObject(queryString:String="",object:Object=null)
		{
			if (object) settings = object;
			else settings = new Object();
			if (queryString)
			{
				var args:Array = queryString.split('&');
				for (var i = 0; i < args.length; i++)
				{
					var value:*;
					var pair:Array = args[i].split('=');
					var name:String = unescape(pair[0]);
		
					if (pair.length == 2) value = unescape(pair[1]);
					else
					{
						var idx:Number = args[i].indexOf('=');
						if (idx>0)
							value = args[i].substr(idx+1);
					}
					setSetting(name,value);
				}
			}
		}
		public function getSetting(settingName:String,defaultValue:*=""):*
		{
			var val:* = settings[settingName];
			if (val == undefined || val == null) return defaultValue;
			else return val;
		}
		public function setSetting(settingName:String,settingValue:*):void
		{
			settings[settingName] = settingValue;
		}
		public function get object():Object{return settings;}
	}
}