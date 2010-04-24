﻿package
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class BossData 
	{
		public static var MAX_HEALTH = 10000;
		public var health:int;
		public var coords:Point;
		public var damageMultiplier:Number;
		
		public function BossData() 
		{
			this.health = 10000;
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