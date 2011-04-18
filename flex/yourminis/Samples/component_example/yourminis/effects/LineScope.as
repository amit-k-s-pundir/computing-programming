package yourminis.effects
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	public class LineScope extends Visualization
	{
		public function LineScope(_visualizer:Visualizer)
		{
			super(_visualizer);
			visualizer.var1=0.99;
			visualizer.color1=0xFFBBCCFF;
			visualizer.removeFilters();
		}
		
		override public function onEnterFrame(evt:Event):void
		{
			if (visualizer.audioManager) dataArray = visualizer.audioManager.getSpectrum();
			var buffer:int=40;
			var xspace:int = Math.round((visualizer.width-2*buffer)/dataArray.length);
			var sy:int = Math.round(visualizer.height/1.5);
			var s:int = 80;
			for (var i:int=1; i<dataArray.length-1; i++)
			{
				visualizer.drawLine(buffer+xspace*i,sy-dataArray[i]*s,buffer+xspace*(i),sy,visualizer.color1);
				//visualizer.bmpData.fillRect(new Rectangle(buffer+xspace*i,sy-dataArray[i]*s,buffer+xspace*i,sy),visualizer.color1)
				//visualizer.bmpData.setPixel32(xspace*(i),sy-dataArray[i]*s,visualizer.color1);
			}
		}
	}
}