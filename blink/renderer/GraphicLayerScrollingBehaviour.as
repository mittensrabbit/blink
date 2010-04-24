package renderer
{
	import renderer.GraphicLayerBehaviour;
	import renderer.GraphicElement;
	import renderer.GraphicLayer;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class GraphicLayerScrollingBehaviour extends GraphicLayerBehaviour
	{
		private var speed:int;
		
		public function GraphicLayerScrollingBehaviour(speed:int) 
		{
			this.speed = speed;
		}
		
		public override function update(graphicLayer:GraphicLayer):void
		{
			for (var i:int = 0; i < graphicLayer.elements.length; i++)
			{
				var element:GraphicElement = graphicLayer.elements[i];
				element.point.y = new int(element.point.y + speed);
				if (element.point.y > element.size.y)
					element.point.y -= new int(element.size.y*2);
			}
		}
	}
	
}