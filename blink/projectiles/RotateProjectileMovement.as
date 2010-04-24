package projectiles 
{
	import flash.geom.Point;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class RotateProjectileMovement extends EventDispatcher implements IProjectileMovement
	{
		private var projectile:Projectile;
		private var playerData:PlayerData;
		private var turnRate:Number;
		
		public function RotateProjectileMovement(projectile:Projectile,playerData:PlayerData) 
		{
			
			this.projectile = projectile;
			this.playerData = playerData;
			/*if (turnrate > 1 )
			{
				this.turnRate = 1;
			}
			if (turnrate < 0)
			{
				this.turnRate = 0;
			}
			else
				this.turnRate = turnRate;*/
				
				this.turnRate = .7;
		}
		
		public  function update():void
		{
			
			var rotation:int = projectile.container.rotation -90 ;
			var projectilePoint:Point = new Point(projectile.container.x, projectile.container.y);
			var playerPoint:Point = new Point(playerData.coords.x, playerData.coords.y);
			
			
			var dx = playerPoint.x - projectilePoint.x ;
			var dy = playerPoint.y - projectilePoint.y;
	
			var targetRotation = Math.atan2(dy, dx) * 180 / Math.PI;
			
			var diff = rotation - targetRotation ;
			
			if (diff > 180)
				targetRotation += 360;
			else if (diff < -180)
				targetRotation -= 360;
				
			projectile.container.rotation += ((targetRotation - rotation) * turnRate)
			
		}

	}
	
}