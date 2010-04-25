package
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class PlayerData 
	{
		public static var MAX_HEALTH = 20;
		public var health:int;
		public var coords:Point;
		public var damageMultiplier:Number;
		
		public function PlayerData() 
		{
			this.health = 20;
			this.coords = new Point(400, 500);
			this.damageMultiplier = 100;
		}
		
		public function setCoordinates(coords:Point):void
		{
			this.coords.x = coords.x;
			this.coords.y = coords.y;
		}
	}
	
}