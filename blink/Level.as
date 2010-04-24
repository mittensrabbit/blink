package
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Transform;
	import renderer.GraphicElement;
	import renderer.GraphicLayer;
	import boss.Boss;
	
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Level extends EventDispatcher
	{
		public var layers:Array;
		public var boss:Boss;
		private var background:GraphicLayer;
		private var foreground:GraphicLayer;
		public function Level() 
		{
			this.layers = new Array();
		}
		
		public function setBoss(boss:Boss):void
		{
			this.boss = boss;
		}
		
		public function addGraphicLayer(graphicLayer:GraphicLayer):void
		{
			layers.push(graphicLayer);
		}
						
		public function render(event:Event):void
		{
			
			for (var layer_index:int = 0; layer_index < layers.length; layer_index++)
			{
				var graphicLayer:GraphicLayer = layers[layer_index];
				graphicLayer.render(event);
				graphicLayer.behaviour.update(graphicLayer);
			}
		}
		
	}
	
}