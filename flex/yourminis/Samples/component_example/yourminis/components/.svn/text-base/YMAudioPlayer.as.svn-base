package yourminis.components
{
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundMixer;
    import flash.media.SoundTransform;
	import flash.media.SoundLoaderContext;
    import flash.net.URLRequest;
    import flash.events.IOErrorEvent;
    import flash.errors.IOError;
	import flash.utils.ByteArray;
	import flash.display.Sprite;

    public class YMAudioPlayer extends Sprite
    {
        public var currentTrack:Sound;
        public var soundChannel:SoundChannel;
		private var isPlaying:Boolean=false;
		private var currentTime:int=0;
		private var	currentIndex:int=-1;
		public var trackArray:Array;
		private var volumeTransform:SoundTransform;
		public var randomize:Boolean;
       	private var widget;
		
		public function YMAudioPlayer(_widget=null)
		{
			widget = _widget;
			soundChannel = new SoundChannel();
		}
        private function ioErrorHandler(event: IOErrorEvent): void{}
        
		public function setVolume(percent:Number):void
		{
			volumeTransform.volume = percent;
            soundChannel.soundTransform = volumeTransform;	
		}
		public function seek(percent:Number):void
		{
			soundChannel.stop();
			soundChannel = currentTrack.play(Math.round(percent*currentTrack.length), 25);
		}
		public function stop(): void
        {
            currentTime = 0;
            soundChannel.stop();
            isPlaying = false;
        }
		
        public function playAudio(): void
        {
            if (!isPlaying)
            {
                soundChannel = currentTrack.play(currentTime, 25);
                isPlaying = true;
            }
        }

        public function pauseAudio(): void
        {
            currentTime = soundChannel.position;
            soundChannel.stop();
            isPlaying = false;
        }
		/*
        public function getInfo(event: Event): void
        {
            id3Array = new Array();
            id3Array[0] = "Track:  " + currentTrack.id3.trackName + " ";
            id3Array[1] = "Artist:  " + currentTrack.id3.artist + " ";
            id3Array[2] = "Album:  " + currentTrack.id3.album + " ";
        }
		*/
				
		public function loadAudio(url:String):void
        {
			soundChannel.stop();
			currentTrack = new Sound();
			currentTrack.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			currentTrack.load(new URLRequest(url), new SoundLoaderContext(500,true));
			soundChannel = currentTrack.play(0, 25);
        }

        public function getSpectrum():Array
        {
            var byteArray:ByteArray = new ByteArray();
			var spectrumArray:Array = new Array();
			try{SoundMixer.computeSpectrum(byteArray, true, 0);}
			catch(e){}
			for (var i:int=0; i<60; i++)
			{
				if (byteArray.length) spectrumArray[i] = byteArray.readFloat();
				else spectrumArray[i] = Math.random()/(i+60)*60;
			}
			return spectrumArray;
        }
    }
}