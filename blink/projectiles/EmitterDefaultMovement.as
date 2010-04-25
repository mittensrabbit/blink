package projectiles 
{
	import flash.display.MovieClip;
	import projectiles.Emitter;
	import projectiles.IEmitterMovement;
	
	/**
	 * ...
	 * @author Tomasz Szymala
	 */
	public class EmitterDefaultMovement implements IEmitterMovement
	{
		private var emitterData:EmitterData;
		private var emitter:MovieClip;
		private var cooldown:int;
		private var maxCoolDown:int;
		
		public function EmitterDefaultMovement() 
		{
			
			this.cooldown = 0;
			this.maxCoolDown = 45;
			
		}
		
		public function bind(emitter:MovieClip, emitterData:EmitterData):void {
			
			this.emitterData = emitterData;
			this.emitter = emitter;
		}
		
		public function copyBase():IEmitterMovement
		{
			return new EmitterDefaultMovement();
		}
		
		public function update():void
		{
			cooldown += 1;
			if (cooldown >= maxCoolDown)
			{
				cooldown = 0;
				
				this.emitter.dispatchEvent(new ProjectileRequestEvent(ProjectileRequestEvent.PROJECT_REQUEST, emitterData));	
				
			}

		}
		
	}

}