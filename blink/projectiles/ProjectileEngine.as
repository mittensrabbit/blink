package projectiles
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.media.Sound;
	import projectiles.Projectile;
	import projectiles.StraightProjectileMovement;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class ProjectileEngine 
	{
		public var container:MovieClip;
		private var _projectiles:Array;
		private var player:Player;
		
		public function ProjectileEngine(player:Player) 
		{
			this._projectiles = new Array();
			this.container = new MovieClip();
			this.player = player;
		}
		
		public function addProjectile(event:ProjectileRequestEvent):void
		{
			// Determine bullet, assign behaviour
			var bullet:MovieClip = new Fla_LaserProjectile();
			bullet.rotation = event.emitterData.rotation;
			bullet.x = event.emitterData.coords.x;
			bullet.y = event.emitterData.coords.y;
			
			var projectile:Projectile = new Projectile(bullet);
			projectile.addBehaviour(new StraightProjectileMovement(projectile));
			
			_projectiles.push(projectile);
			container.addChild(projectile.container);
		}
		
		public function handleEnterFrame(event:Event):void
		{
			for (var i:int = 0; i < _projectiles.length; i++)
			{
				var projectile:Projectile = _projectiles[i];	
				projectile.update();
				
				if (projectile.collisionDetectionAgainstObject(player.ship.hitTest))
				{
					container.removeChild(projectile.container);
					player.playerData.damageMultiplier += 10;
					_projectiles.splice(i, 1);	
				}
				else if (projectile.checkEndCondition())
				{
					container.removeChild(projectile.container);
					_projectiles.splice(i, 1);
				}
			}
		}
	}
	
}