package renderer 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class GraphicLayer
	{
		public var container:MovieClip;
		public var elements:Array;
		public var canvas:Bitmap;
		private var bitmapData:BitmapData;
		private var alpha:Number;
		public var behaviour:GraphicLayerBehaviour;
		
		public function GraphicLayer(canvasSize:Point, alpha:Number = 0) 
		{
			this.alpha = alpha;
			
			if (alpha > 0)
				bitmapData = new BitmapData(canvasSize.x, canvasSize.y, true, 0x000000)
			else
				bitmapData = new BitmapData(canvasSize.x, canvasSize.y, false, 0x000000)
				
			canvas = new Bitmap(bitmapData);

			this.elements = new Array();				
			container = new MovieClip();
			container.addChild(canvas);
		}
	
		public function setBehaviour(behaviour:GraphicLayerBehaviour):void
		{
			this.behaviour = behaviour;
		}
		
		public function addElement(element:GraphicElement):void
		{
			this.elements.push(element);
		}
		
		public function render(event:Event):void
		{
			for (var i:int = 0; i < elements.length; i++)
			{
				var element:GraphicElement = elements[i];
				var sourceRect:Rectangle = new Rectangle(0, -element.size.y  + (element.point.y), element.size.x, element.size.y - (element.point.y))
				
				if (sourceRect.height < 0)
					sourceRect.height = 0;
					
				if (sourceRect.y < 0)
					sourceRect.y = 0;
					
				if (sourceRect.y > element.size.y )
					sourceRect.y = element.size.y ;
					
				if (sourceRect.height > element.size.y )
					sourceRect.height = element.size.y ;					

				bitmapData.copyPixels(element.bitmapData, sourceRect, element.point);
			}
			if (alpha > 0)
			{
				bitmapData.colorTransform(bitmapData.rect, new ColorTransform(1, 1, 1, alpha));
			}
		}
	}
	
}