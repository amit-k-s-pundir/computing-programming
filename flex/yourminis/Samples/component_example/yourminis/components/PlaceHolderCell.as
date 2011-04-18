package yourminis.components
{
	
	import flash.display.Shape;
	public class PlaceHolderCell extends ListCell
	{
		public function PlaceHolderCell( w:Number, h:Number, _themeColor:uint=0 )
		{
			super( "", w, h );
			//draw & add background 
			drawBackground(_themeColor);
		}
		
		private function drawBackground (_themeColor:uint)
		{
			this.graphics.clear();
			this.graphics.lineStyle(2,_themeColor);
			dashTo({x:2,y:2},{x:cellWidth-2,y:2},2,10);
			dashTo({x:cellWidth-2,y:2},{x:cellWidth-2,y:cellHeight-2},2,10);
			dashTo({x:cellWidth-2,y:cellHeight-2},{x:2,y:cellHeight-2},2,10);
			dashTo({x:2,y:cellHeight-2},{x:2,y:2},2,10);
		}
		private function dashTo(startPoint, destPoint, dashLength, spaceLength):void
		{
			var x = destPoint.x - startPoint.x;
			var y = destPoint.y - startPoint.y;
			var hyp = Math.sqrt((x)*(x) + (y)*(y));
			var units = hyp/(dashLength+spaceLength);
			var dashSpaceRatio = dashLength/(dashLength+spaceLength);
			var dashX = (x/units)*dashSpaceRatio;
			var spaceX = (x/units)-dashX;
			var dashY = (y/units)*dashSpaceRatio;
			var spaceY = (y/units)-dashY;
			this.graphics.moveTo(startPoint.x, startPoint.y);
			while (hyp > 0) {
					startPoint.x += dashX;
					startPoint.y += dashY;
					hyp -= dashLength;
					if (hyp < 0) {
							startPoint.x = destPoint.x;
							startPoint.y = destPoint.y;
					}
					this.graphics.lineTo(startPoint.x, startPoint.y);
					startPoint.x += spaceX;
					startPoint.y += spaceY;
					this.graphics.moveTo(startPoint.x, startPoint.y);
					hyp -= spaceLength;
			}
			this.graphics.moveTo(destPoint.x, destPoint.y);
		}
	}
}