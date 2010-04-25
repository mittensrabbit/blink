﻿package boss
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class BossData 
	{
		public var max_health = 700;
		public var health:int;
		public var coords:Point;
		//public var damageMultiplier:Number;
		
		private var _bossRef:Boss;
		
		public function BossData(pBoss:Boss) {
			this.health = 700;
			this.coords = new Point(400, 500);
			//this.damageMultiplier = 100;
			
			this._bossRef = pBoss;
			
		}
		
		public function setCoordinates(coords:Point):void {
			this.coords.x = coords.x;
			this.coords.y = coords.y;
		}
	}
	
}