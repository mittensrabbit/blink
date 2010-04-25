package renderer 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Yuri Doubov
	 */
	public class Particle extends EventDispatcher
	{
		public var movieClip:MovieClip;
		public var timer:Timer;
		private var _eventDispatcher:EventDispatcher;
		public function Particle(pMC:MovieClip, duration:Number) 
		{
			this.movieClip = pMC;
			
			this._eventDispatcher = new EventDispatcher(this);
			this.timer = new Timer(duration, 1);
			this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.particleDead);
		}
		
		private function particleDead():void {
			this.timer.stop();
			this.dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE));
		}
	}

}