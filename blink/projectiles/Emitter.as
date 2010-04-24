package projectiles
{
	import projectiles.EmitterTypes;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Bread
	 */
	public class Emitter extends EventDispatcher
	{
		private var emitter:MovieClip;
		private var emitterData:EmitterData;
		private var cooldown:int;
		private var maxCoolDown:int;

		public function Emitter(emitter:MovieClip,type:String, shiftX:Number, shiftY:Number) 
		{
			this.emitter = emitter;
			this.emitterData = new EmitterData();
			this.emitterData.coords = new Point(emitter.x+ shiftX, emitter.y + shiftY);
			this.emitterData.rotation = emitter.rotation;
			this.emitterData.type = type;
			this.cooldown = 89;
			this.maxCoolDown = 90;
		}
		
		public function handleEnterFrame(event:Event):void {
			cooldown += 1;
			if (cooldown >= maxCoolDown)
			{
				cooldown = 0;
				// apply emitter behaviour + dispatch
				emitterData.rotation += 0.0;
				emitter.dispatchEvent(new ProjectileRequestEvent(ProjectileRequestEvent.PROJECT_REQUEST, emitterData));	
				
			}
		}
		
		public function moveEmitter(pxShift:Number, pyShift:Number):void {
			this.emitterData.coords.x += pxShift;
			this.emitterData.coords.y += pyShift;
		}
		
		public function rotateEmitter(pRotation:Number):void {
			this.emitterData.rotation += pRotation;
		}
	}
	
}