package blink.projectiles 
{
	import projectiles.Emitter;
	import projectiles.EmitterData;
	import projectiles.IEmitterMovement;
	
	/**
	 * ...
	 * @author Tomasz Szymala
	 */
	public class EmitterIntervalShootMovement implements IEmitterMovement
	{
		private var emitter:Emitter;
		private var cooldown:int;
		private var maxCoolDown:int;
		public function EmitterIntervalShootMovement(emitterData:EmitterData, interval:int ) 
		{
			this.emitter = emitter;
			this.cooldown = 0;
			this.maxCoolDown = interval;
			
		}
		
		public function update():void
		{
			cooldown += 1;
			if (cooldown >= maxCoolDown)
			{
				cooldown = 0;
				// apply emitter behaviour + dispatch
				//emitterData.rotation += 0.0;
				emitter.dispatchEvent(new ProjectileRequestEvent(ProjectileRequestEvent.PROJECT_REQUEST, emitterData));	
				
			}
		}
		
	}

}