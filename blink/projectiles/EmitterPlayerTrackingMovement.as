package projectiles 
{
	import flash.display.MovieClip;
	import projectiles.Emitter;
	import projectiles.EmitterData;
	import projectiles.IEmitterMovement;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Tomasz Szymala
	 */
	public class EmitterPlayerTrackingMovement implements IEmitterMovement
	{
		private var emitterData:EmitterData;
		private var emitter:MovieClip;
		private var playerData:PlayerData;
		private var cooldown:int;
		private var maxCoolDown:int;
		private var duration:int;
		private var turnRate:int;
		private var delay:int;
		private var delayCounter:int;
		private var durrationCounter:int;
		
		
		public function EmitterPlayerTrackingMovement(rate:int, duration:int , playerData:PlayerData, turnRate:int, delay:int ) 
		{
			this.cooldown = 0;
			this.maxCoolDown = rate;
			this.duration = duration;
			this.playerData = playerData;
			this.turnRate = turnRate;
			this.delay = delay;
			this.delayCounter = 0;
			this.durrationCounter = 0;
			
		
		
		}
		
		public function bind(emitter:MovieClip, emitterData:EmitterData):void {
			
			this.emitterData = emitterData;
			this.emitter = emitter;
		}
		
		public function copyBase():IEmitterMovement
		{
			return new EmitterPlayerTrackingMovement(this.maxCoolDown, this.duration , this.playerData, this.turnRate, this.delay ) 
		}
		
		public function update():void
		{
			

			var rotation:int = this.emitterData.rotation -90 ;
			var followerPoint:Point = new Point(emitterData.coords.x, emitterData.coords.y);
			var targetPoint:Point = new Point(playerData.coords.x, playerData.coords.y);
			
			
			var dx = targetPoint.x - followerPoint.x ;
			var dy = targetPoint.y - followerPoint.y;
	
			var targetRotation = Math.atan2(dy, dx) * 180 / Math.PI;
			
			var diff = rotation - targetRotation ;
			
			if (diff > 180)
				targetRotation += 360;
			else if (diff < -180)
				targetRotation -= 360;
				
			this.emitterData.rotation += ((targetRotation - rotation) / turnRate)
			
			
			
			
			if (delayCounter <= 0)
			{
				if (durrationCounter < duration)
				{
					cooldown += 1;
					if (cooldown >= maxCoolDown)
					{
						cooldown = 0;
						durrationCounter ++;
						// apply emitter behaviour + dispatch
						//emitterData.rotation += 0.0;
						emitter.dispatchEvent(new ProjectileRequestEvent(ProjectileRequestEvent.PROJECT_REQUEST, emitterData));	
						
					}
				}
				else
				{
					delayCounter = delay;
					durrationCounter = 0;
				}
			}
			else
			{
				delayCounter--;
				
			}
		}		
	}
}