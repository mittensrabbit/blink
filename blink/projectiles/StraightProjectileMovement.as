package projectiles 
{
	import flash.geom.Point;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class StraightProjectileMovement extends EventDispatcher implements IProjectileMovement
	{
		public var expired:Boolean;
		
		private var velocity:int;
		private var projectile:Projectile;

		public function StraightProjectileMovement(projectile:Projectile, velocity:int) 
		{
			this.velocity = velocity;
			this.projectile = projectile;
			this.expired = false;
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