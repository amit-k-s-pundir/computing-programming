package yourminis.components
{
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	
	public class YMLogo extends Sprite
	{
		public function YMLogo(_width:Number,_height:Number)
		{
			var boxDim = _width/3;
			var margin = _width/14;
			var matr:Matrix = new Matrix()
			matr.createGradientBox(2*boxDim,2*boxDim,-Math.PI/4);
			this.graphics.beginGradientFill(GradientType.LINEAR, [0xC27C03,0xE6A63D], [1, 1], [0x00, 0xFF], matr, SpreadMethod.PAD);
			this.graphics.drawRect(boxDim, 0, 2*boxDim, 2*boxDim);
			this.graphics.endFill();
			this.graphics.beginGradientFill(GradientType.LINEAR, [0x3E3E3E,0xA4A4A4], [1, 1], [0x00, 0xFF], matr, SpreadMethod.PAD);
			this.graphics.moveTo(0,boxDim);
			this.graphics.lineTo(boxDim-margin,boxDim);
			this.graphics.lineTo(boxDim-margin,2*boxDim+margin);
			this.graphics.lineTo(2*boxDim,2*boxDim+margin);
			this.graphics.lineTo(2*boxDim,3*boxDim);
			this.graphics.lineTo(0,3*boxDim);
			this.graphics.lineTo(0,boxDim);
			this.graphics.endFill();
		}
	}
}