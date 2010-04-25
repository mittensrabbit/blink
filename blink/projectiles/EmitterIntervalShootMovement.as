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
		private var emitterData:EmitterData;
		private var cooldown:int;
		private var maxCoolDown:int;
		public function EmitterIntervalShootMovement(rate:int ) 
		{
			
			this.cooldown = 0;
			this.maxCoolDown = rate;
			
		}
		
		public function bind(emitter:MovieClip, emitterData:EmitterData):void {
			
			this.emitterData = emitterData;
			this.emitter = emitter;
		}
		
		public function baseCopy():EmitterIntervalShootMovement
		{
			return new EmitterIntervalShootMovement(this.maxCoolDown);
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