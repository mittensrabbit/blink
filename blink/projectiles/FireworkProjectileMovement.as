package projectiles 
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import projectiles.EmitterData;
	import projectiles.EmitterTypes;
	import projectiles.IProjectileMovement;
	import projectiles.Projectile;
	
	/**
	 * ...
	 * @author Tomasz Szymala
	 */
	public class FireworkProjectileMovement extends EventDispatcher implements IProjectileMovement 
	{
		private var numProjectiles:int;
		private var projectile:Projectile;
		private var emit:EmitterData;
		
		
		public function FireworkProjectileMovement(projectile:Projectile ,numProjectiles:int, type:String) 
		{
			this.projectile = projectile;
			this.numProjectiles = numProjectiles;
	
			this.emit = new EmitterData();
			this.emit.coords = new Point();
			this.emit.type = type;
		}
		
		public function update():void
		{
			
			
			emit.coords.x = projectile.container.x;
			emit.coords.y = projectile.container.y;
			
			var inc:int = 360 / this.numProjectiles;
			for ( var i:int = 0 ; i < numProjectiles; i++ )
			{
				emit.rotation = projectile.container.rotation + inc*i;
				
				
				this.projectile.container.dispatchEvent(new ProjectileRequestEvent(ProjectileRequestEvent.PROJECT_REQUEST, emit));
			}
			
			
			
		}
		
	}

}