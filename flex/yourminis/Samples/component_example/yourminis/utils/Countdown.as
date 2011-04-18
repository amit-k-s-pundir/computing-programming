package yourminis.utils
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class Countdown extends EventDispatcher
	{
		public var counterString:String;
		public var currentPercent;
		public var timer:Timer;
		public var eventMillisecs:Number;
		public var beginMillisecs:Number;
		public var finishMessage:String;
		public var showDetails:Boolean;
		public var useUTC:Boolean;
		public var utcOffset:Number;
		
		public function Countdown(ed:String, sd:String = "1/1/00/0/0", _finishMessage:String = "0 : 0 : 0 : 0", _useUTC:Boolean = false, _utcOffset:Number = 0)
		{
			useUTC = _useUTC;
			utcOffset = _utcOffset;
			currentPercent = 0;
			eventMillisecs = getCounterTime(ed);// ex: "10/1/07/0/0"
			beginMillisecs = getCounterTime(sd);
			finishMessage = _finishMessage;
			timer = new Timer(1000);
			timer.addEventListener("timer",updateCounter);
		}
		public function start():void
		{
			timer.start();
			updateCounter(new Event(""));
		}
		private function getCounterTime(cdate):Number
		{
			var dArr:Array = cdate.split("/");
			var cmonth:Number = Number(dArr[0])-1;
			var cday:Number = Number(dArr[1]); 
			if (dArr[2].length < 4) dArr[2] = "20"+dArr[2];
			var cyear:Number = Number(dArr[2]);
			var chour:Number = Number(dArr[3]);
			var cmins:Number = Number(dArr[4]);
				
			var eventDate:Date = new Date(cyear, cmonth, cday,chour, cmins);
			return eventDate.getTime();
		}
		private function updateCounter(evt:Event)
		{
			var currentDate:Date;
			var tzo;
			currentDate = new Date();
			if (useUTC) {
				tzo = Math.floor(currentDate.getTimezoneOffset()/60);
				//counterString = String(tzo) + " " + String(utcOffset) + " " + String(currentDate.getHours());
				currentDate.setUTCMilliseconds(currentDate.getUTCMilliseconds() + (tzo-utcOffset)*1000*60*60);
			}
			var currentMillisecs:Number = currentDate.getTime();
			var msecs:Number = eventMillisecs - currentMillisecs;
			if (msecs <= 0){   
				//counter expired
				timer.stop();
				counterString = finishMessage;
				dispatchEvent( new Event(Event.CHANGE))
				dispatchEvent( new Event(Event.COMPLETE))
				return;
			}
			var secs:Number = (Math.floor(msecs/1000)); // 1000 milliseconds make a second
			var mins:Number = (Math.floor(secs/60)); // 60 seconds make a minute
			var hours:Number = (Math.floor(mins/60)); // 60 minutes make a hour
			var days:Number = (Math.floor(hours/24)); // 24 hours make a second
			secs = secs%60;
			mins = mins%60;
			hours = hours%24;
			
			var ssecs:String = String(secs);
			var smins:String = String(mins);
			var shours:String = String(hours);
			var sdays = String(days);
			if (secs < 10) ssecs = "0" + ssecs;
			if (mins < 10) smins = "0" + smins;
			if (hours < 10) shours = "0" + shours;
			while (sdays.length < 2) sdays = "0" + sdays;
			
			counterString = sdays + " : " + shours + " : " + smins + " : " + ssecs;
			currentPercent = (currentMillisecs-beginMillisecs)/(eventMillisecs-beginMillisecs);
			dispatchEvent(new Event(Event.CHANGE));//{cs:counterString,cp:currentPercent}) )
		}
		public function get time():String{return counterString;}
	}
}