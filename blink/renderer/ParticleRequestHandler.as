package renderer 
{
	import renderer.Particle;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Yuri Doubov
	 */
	public class ParticleRequestHandler
	{
		private var _blinkAppRef:BlinkApplication;
		private var _timer:Timer;
		private var _patricleArray:Array;
		public function ParticleRequestHandler(pBlinkApp:BlinkApplication) 
		{
			_blinkAppRef = pBlinkApp;
			_patricleArray = new Array();
		}
		
		public function requestParticle(pParticle_mc:MovieClip, pXcoordinate:Number, pYcoordinate:Number, pDuration:Number):void {
			pParticle_mc.x = pXcoordinate;
			pParticle_mc.y = pYcoordinate;
			this._blinkAppRef.addChild(pParticle_mc);
			var tempParticle:Particle = new Particle(pParticle_mc, pDuration);
			tempParticle.addEventListener(TimerEvent.TIMER_COMPLETE, this.cleanUpParticle);
			this._patricleArray.push(tempParticle);
			
		}
		
		private function cleanUpParticle(e:TimerEvent):void {
			//trace(e.target);
			//trace("CLENA UP PARTICLE");
			for (var i in this._patricleArray) {
				if (this._patricleArray[i] == e.target) {
					this._blinkAppRef.removeChild(this._patricleArray[i].movieClip);
					this._patricleArray.splice(i, 1);
					return;
				}
			}
		}
		
	}

}