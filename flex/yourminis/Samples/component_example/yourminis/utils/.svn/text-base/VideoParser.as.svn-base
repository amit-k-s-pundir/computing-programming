package yourminis.utils
{
	import flash.system.*
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	public class VideoParser extends EventDispatcher
	{
		private var loader:URLLoader;
		public var url:String;
		public function VideoParser(_loader:URLLoader) 
		{
			loader = _loader;
		}
		function onYoutubeLoaded(evt:Event):void
		{
			
			var data = evt.target.data;
			var sidx = data.indexOf("video_id:'")+10;
			var eidx = data.indexOf("'",sidx)
			var id = data.substr(sidx,eidx-sidx);
			
			sidx = data.indexOf("t:'")+3;
			eidx = data.indexOf("'",sidx)
			var token = data.substr(sidx,eidx-sidx);
			System.setClipboard(token);
			url = "http://www.youtube.com/get_video?video_id="+id+"&t="+token;
			dispatchEvent(new Event("parsed"));
		}
		
		function onGoogleLoaded(evt:Event):void
		{
			var data = evt.target.data;
			var sidx = data.indexOf("videoUrl")+3;
			url = "";
			if (sidx>0)
			{
				sidx+=11;
				var eidx = data.indexOf("\\\"",sidx+1);
				if (eidx>=0) url = data.substr(sidx,eidx-sidx);
			}
			url=unescape(url);
			dispatchEvent(new Event("parsed"));
		}
		
		function onDailyMotionLoaded(evt:Event):void
		{
			var data = evt.target.data;
			var sidx = data.indexOf("\"url\", \"");
			url = "";
			if (sidx>0)
			{
				sidx+=8;
				var eidx = data.indexOf("\"",sidx+1);
				if (eidx>=0) url = data.substr(sidx,eidx-sidx);
			}
			url=unescape(url);
			dispatchEvent(new Event("parsed"));
		}
		
		
		function onIFilmLoaded(evt:Event):void
		{
			var data = evt.target.data;
			var data2 = data.substr(data.indexOf("*url* : *http://ifilm")+9);
			url = data2.substring(0,data2.indexOf("*")-1);
		    dispatchEvent(new Event("parsed"));
		}
		
		
		function onVeohLoaded(evt:Event):void
		{
			//var data = evt.target.data;
			//playUrl(link);
		}
		
		function onBreakLoaded(evt:Event):void
		{
			var data = evt.target.data;
			var sidx = data.indexOf("videothumbnail");
			data = data.substr(sidx);
			sidx = data.indexOf("href=")
			url = "";
			
			if (sidx>0)
			{
				sidx+=6;
				var eidx = data.indexOf(".jp",sidx+1);
				if (eidx>=0) url = data.substr(sidx,eidx-sidx) + ".flv";
			}
		}
		
		function onMetacafeLoaded(evt:Event):void
		{
			var data = evt.target.data;
			var sidx = data.indexOf("mediaURL=")+9;
			var eidx = data.indexOf("&",sidx);
			url = unescape(data.substring(sidx,eidx));
 			dispatchEvent(new Event("parsed"));
		}
		
		public function parse(vurl:String):Boolean
		{
			if (vurl.indexOf("youtube.com") > -1) 
			{
				if (vurl.indexOf("'") > -1) vurl = vurl.substring(vurl.indexOf("'")+1,vurl.lastIndexOf("'"));
				loader.addEventListener(Event.COMPLETE,onYoutubeLoaded);
			}
			else if (vurl.indexOf("ifilm.com") > -1) loader.addEventListener(Event.COMPLETE,onIFilmLoaded);
			else if (vurl.indexOf("google.com") > -1) loader.addEventListener(Event.COMPLETE,onGoogleLoaded);
			else if (vurl.indexOf("dailymotion.com") > -1) loader.addEventListener(Event.COMPLETE,onDailyMotionLoaded);
			else if (vurl.indexOf("myspace.com") > -1)
			{
				var id = vurl.substr(vurl.length-10);
				url = "http://content.movies.myspace.com/0015637/22/63/"+id+".flv";
				dispatchEvent(new Event("parsed"));
			}
			else if (vurl.indexOf("veoh.com") > -1) loader.addEventListener(Event.COMPLETE,onVeohLoaded);
			//else if (vurl.indexOf("break.com") > -1) {loadBreak(vurl); return "Break.com";};
			else if (vurl.indexOf("metacafe.com") > -1) loader.addEventListener(Event.COMPLETE,onMetacafeLoaded);
			else return false;
			loader.load(new URLRequest(vurl));
			return true;
		}
	}
}