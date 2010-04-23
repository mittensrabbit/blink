package renderer 
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class GraphicElement 
	{
		public var bitmapData:BitmapData;
		public var point:Point;
		public var size:Point;

		public function GraphicElement(movieClip:MovieClip, point:Point, alpha:Number) 
		{
			var alphaEnabled:Boolean = false;
			if (alpha > 0)
			{
				alphaEnabled = true;
			}
			this.bitmapData = createBitmapDataFromMovieClip(movieClip,alphaEnabled);
			this.point = point;
			this.size = new Point (movieClip.width, movieClip.height);
		}
		
		public function setBitmapData(bitmapData):void
		{
			this.bitmapData = bitmapData;
		}

		public function getSourceRect():Rectangle
		{
			return new Rectangle(0, 0, size.x, size.y);
		}
		
		private function createBitmapDataFromMovieClip(movieClip:MovieClip, alphaEnabled:Boolean = false):BitmapData
		{
			var bitmapData:BitmapData = new BitmapData(movieClip.width, movieClip.height,alphaEnabled,0x000000)
			bitmapData.draw(movieClip);	
			return bitmapData;
		}
		
		
	}
	
}