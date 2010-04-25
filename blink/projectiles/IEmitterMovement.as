package projectiles 
{
	import flash.display.MovieClip;
	import projectiles.Emitter;
	/**
	 * ...
	 * @author Tomasz Szymala
	 */
	public interface IEmitterMovement 
	{
		function update():void;
		function bind(emitter:MovieClip, emitterData:EmitterData):void;
		function copyBase():IEmitterMovement;
		
	}
	
	
}