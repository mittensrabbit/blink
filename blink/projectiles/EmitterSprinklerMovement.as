package projectiles 
{
	import flash.display.MovieClip;
	import projectiles.Emitter;
	import projectiles.IEmitterMovement;
	
	/**
	 * ...
	 * @author Tomasz Szymala
	 */
	public class EmitterSprinklerMovement implements IEmitterMovement
	{
		private var emitterData:EmitterData;
		private var emitter:MovieClip;
		private var rotation:int;
		private var minRotation:int;
		private var maxRotation:int;
		private var curRotation:int;
		private var interval:int;
		private var direction:int;
		private var cooldown:int;
		private var maxCoolDown:int;
		public function EmitterSprinklerMovement(rotation:int, interval:int,rate:int ) 
		{

			this.cooldown = 0;
			this.maxCoolDown = rate;
			this.rotation = rotation;
			this.curRotation = 0;
			this.interval = interval;
			if (this.rotation < 0)
				this.direction = -1;
			else
				this.direction = 1;
			this.minRotation = 0;
			this.maxRotation = 0;
			
			

		}
	
		public function bind(emitter:MovieClip, emitterData:EmitterData):void {
			
			this.emitterData = emitterData;
			this.emitter = emitter;
			this.minRotation = this.emitterData.rotation - (Math.abs(rotation) / 2);
			this.maxRotation = this.emitterData.rotation + (Math.abs(rotation) / 2);
		}
		
		public function update():void
		{
			cooldown += 1;
			
			if (cooldown >= maxCoolDown)
			{	
				
				cooldown = 0;
				trace(this.curRotation);
				if (this.curRotation >= Math.abs(this.rotation) )
				{
					this.curRotation = 0;
					this.direction *= -1;
				}
				if (this.rotation < 0)
				{
					if (this.direction == 1)
					{
						this.curRotation += this.interval;
						this.emitterData.rotation = this.minRotation + this.curRotation;
						
					}
					if (this.direction == -1)
					{
						this.curRotation += 1;
						this.emitterData.rotation = this.maxRotation - this.curRotation;
						
					}
				}
				else 
				{
					if (this.direction == 1)
					{
						this.curRotation += 1;
						this.emitterData.rotation = this.minRotation + this.curRotation;
						
					}
					if (this.direction == -1)
					{
						this.curRotation += this.interval;
						this.emitterData.rotation = this.maxRotation - this.curRotation;
						
					}
				}
				this.emitter.dispatchEvent(new ProjectileRequestEvent(ProjectileRequestEvent.PROJECT_REQUEST, this.emitterData));	
				
			}

		}
		
	}

}