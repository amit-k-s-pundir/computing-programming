package yourminis.utils
{
	public class ColorExtended
	{
		public function ColorExtended()
		{
			
		}
		public function gradient(hex:uint, percent:Number):uint
		{
			var rgb:Object = HEXToRGB(hex);
			var hls:Object = RGBToHLS(rgb.r, rgb.g, rgb.b);
			hls.l = hls.l*(percent);
			hls.l = Math.max(Math.min(hls.l,240),0);
			rgb = HLSToRGB(hls.h, hls.l, hls.s);
			return RGBToHEX(rgb.r, rgb.g, rgb.b);
		}
		public function fade(c1:uint,c2:uint,p:Number):uint
		{
			var rgb1:Object = HEXToRGB(c1);
			var rgb2:Object = HEXToRGB(c2);
			var r:int = Math.round(rgb1.r*(1-p)+rgb2.r*p);
			var g:int = Math.round(rgb1.g*(1-p)+rgb2.g*p);
			var b:int = Math.round(rgb1.b*(1-p)+rgb2.b*p);
			return RGBToHEX(r,g,b);
		}
		public function RGBToHLS(r:int,g:int,b:int) 
		{
			var h:Number;
			var l:Number;
			var s:Number;
			var max = (Math.max(Math.max(r, g), b))/255;
			var min = (Math.min(Math.min(r, g), b))/255;
			var delta = max-min;
			l = (max+min)/2;
			s = (max == min) ? 0 : ((l <= 0.5) ? delta/l/2 : delta/(2-l*2));
			if(r/255 == max) h = (g-b)/delta/255;
			else if(g/255 == max) h = 2+(b-r)/delta/255;
			else if(b/255 == max) h = 4+(r-g)/delta/255;
			h *= 40;
			if(h < 0) h += 240;
			h = Math.round(h);
			return {h:((isNaN(h)) ? 0 : h), l:Math.round(l*240), s:Math.round(s*240)};
		}
		public function HLSToRGB(h,l,s):Object 
		{
			var r:int,g:int,b:int;
			if(s == 0) {
				r = g = b = Math.round(l/240*255);
			} else {
				h /= 240; l /= 240; s /= 240;
				var temp4,temp3;
				var temp2 = (l < 0.5) ? l*(s+1) : l+s-l*s;
				var temp1 = l*2 - temp2;
				for(var i=0; i<3; i++) {
					switch(i) {
						case 0: temp3 = h+1/3; break;
						case 1: temp3 = h; break;
						case 2: temp3 = h-1/3; break;
					}
					if(temp3 < 0) temp3++;
					else if(temp3 > 1) temp3--;
					if(temp3*6 < 1) temp4 = temp1+(temp2-temp1)*6*temp3;
					else if(temp3*2 < 1) temp4 = temp2;
					else if(temp3*3 < 2) temp4 = temp1+(temp2-temp1)*((2/3)-temp3)*6;
					else temp4 = temp1;
					switch(i) {
						case 0: r = Math.round(temp4*255); break;
						case 1: g = Math.round(temp4*255); break;
						case 2: b = Math.round(temp4*255); break;
					}
				}
			}
			return {r:r,g:g,b:b};
		}	
		public function RGBToHEX(r:int,g:int,b:int):uint
		{
			var hex:uint = r << 16 ^ g << 8 ^ b;
			return hex;
		}
		public function HEXToRGB ( hex:Number ):Object
		{
		   var returnObj:Object = new Object();  
		   returnObj.r = hex >> 16;
		   var temp:uint = hex ^ returnObj.r << 16;
		   returnObj.g = temp >> 8;
		   returnObj.b = temp ^ returnObj.g << 8;
		   return returnObj;
		}
	}
}