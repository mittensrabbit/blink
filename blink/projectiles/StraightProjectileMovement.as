package projectiles 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class StraightProjectileMovement implements IProjectileMovement
	{
		private var velocity:int;
		private var projectile:Projectile;
		public function StraightProjectileMovement(projectile:Projectile) 
		{
			this.velocity = 8;
			this.projectile = projectile;
		}
		
		public function update():void
		{
			var rotation:int = projectile.container.rotation;
			var point:Point = new Point(projectile.container.x, projectile.container.y);
			var radian:Number = Math.PI/(180/rotation);
			var x:Number = Math.sin(radian) * velocity;
			var y:Number = Math.cos(radian) * velocity;
			
			projectile.container.x = point.x + x;
			projectile.container.y = point.y - y;
		}

	}
	
}