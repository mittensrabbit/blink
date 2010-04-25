package projectiles
{
	import projectiles.EmitterSprinklerMovement;
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
		private var behaviour:IEmitterMovement;

		var cooldown = 0 ;
		var maxCoolDown = 1;

		
		public function Emitter(emitter:MovieClip,type:String, shiftX:Number, shiftY:Number) 
		{
			this.emitter = emitter;
			this.emitterData = new EmitterData();
			this.emitterData.coords = new Point(emitter.x+ shiftX, emitter.y + shiftY);
			this.emitterData.rotation = emitter.rotation;
			this.emitterData.type = type;
			//this.behaviour = new EmitterDefaultMovement(this.emitter,this.emitterData);
			this.behaviour = new EmitterSprinklerMovement(this.emitter,this.emitterData,90,10,3)
			
		}
		
		public function handleEnterFrame(event:Event):void {
			
			this.behaviour.update();
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