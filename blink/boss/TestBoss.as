package boss 
{
	import boss.Boss;
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Brad Eccles
	 */
	public class TestBoss extends Boss
	{
		public function TestBoss(pBlinkApp:BlinkApplication, container:MovieClip) 
		{

			super(pBlinkApp, container);
			this._boss_mc = new Fla_TestBoss ();
			this.container.addChild(this._boss_mc);
			this._boss_mc.x = 400 - (this._boss_mc.width / 2);
			
			this._ymovement = 0;
			initializeEmitters();
		}
		
		protected override function moveBoss():void {

		}
		
		public override function bossDead():void {
			super.bossDead();
			this.container.removeChild(this._boss_mc);
			this._blinkApplicationRef.endLevel();
			//delete this;
			trace("VERY DEAD");
		}
		
		//protected override function rotateBoss():void {
			//this._boss_mc.rotation += this._rotation;
			//if (this._boss_mc.rotation > 10 || this._boss_mc.rotation < -10)
				//this._rotation = -this._rotation;
		//}
	}

}