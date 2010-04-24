package projectiles
{
	import projectiles.FireworkProjectileMovement;
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
			
			var projectile:Projectile;
			// Determine bullet, assign behaviour
			var bullet:MovieClip = null;
			
			if (event.emitterData.type == EmitterTypes.LASER)
			{
				bullet = new Fla_LaserProjectile();
				projectile = new Projectile(bullet, 120, 5);
				projectile.addBehaviour(new StraightProjectileMovement(projectile, 12));
				
				//projectile.addBehaviour(new RotateProjectileMovement(projectile, player.playerData));
				//
			}
			else if (event.emitterData.type == EmitterTypes.MISSILE_RED)
			{
				bullet = new Fla_RedMissle();
				projectile = new Projectile(bullet, 90,12);
				projectile.addBehaviour(new StraightProjectileMovement(projectile, 10));
				projectile.addBehaviour(new RotateProjectileMovement(projectile, player.playerData));
				projectile.addEndBehaviour(new FireworkProjectileMovement(projectile,20,EmitterTypes.EXPLOSION_HOMING));
			}
			else if (event.emitterData.type == EmitterTypes.MISSILE_BLUE)
			{
				bullet = new Fla_LaserProjectile();
				projectile = new Projectile(bullet, 90,10);
				projectile.addBehaviour(new StraightProjectileMovement(projectile, 10));
				projectile.addBehaviour(new RotateProjectileMovement(projectile, player.playerData));
				
			}
			else if (event.emitterData.type == EmitterTypes.MISSILE_YELLOW)
			{
				bullet = new Fla_LaserProjectile();
				projectile = new Projectile(bullet, 90,10);
				projectile.addBehaviour(new StraightProjectileMovement(projectile, 10));
				projectile.addBehaviour(new RotateProjectileMovement(projectile, player.playerData));
				projectile.addEndBehaviour(new FireworkProjectileMovement(projectile,20,EmitterTypes.EXPLOSION_CLOUD));
			}
			else if (event.emitterData.type == EmitterTypes.EXPLOSION_CLOUD)
			{
				bullet = new Fla_LaserProjectile();
				projectile = new Projectile(bullet, 30,3);
				projectile.addBehaviour(new StraightProjectileMovement(projectile, 1));
				
			}
			else if (event.emitterData.type == EmitterTypes.EXPLOSION_BULLET)
			{
				bullet = new Fla_LaserProjectile();
				projectile = new Projectile(bullet, 30,5);
				projectile.addBehaviour(new StraightProjectileMovement(projectile, 8));
				
			}
			else if (event.emitterData.type == EmitterTypes.EXPLOSION_HOMING)
			{
				bullet = new Fla_LaserProjectile();
				projectile = new Projectile(bullet, 30,5);
				projectile.addBehaviour(new StraightProjectileMovement(projectile, 12));
				projectile.addBehaviour(new RotateProjectileMovement(projectile, player.playerData));
			}
			
			
			bullet.rotation = event.emitterData.rotation;
			bullet.x = event.emitterData.coords.x;
			bullet.y = event.emitterData.coords.y;
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
					//player.playerData.damageMultiplier += 10;
					player.playerData.health -= projectile.damage * (player.playerData.damageMultiplier / 100);
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