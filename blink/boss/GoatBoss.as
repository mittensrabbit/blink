﻿package boss 
{
	import boss.Boss;
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Yuri Doubov
	 */
	public class GoatBoss extends Boss
	{
		public function GoatBoss(pBlinkApp:BlinkApplication, container:MovieClip) 
		{

			super(pBlinkApp, container);
			this._boss_mc = new Fla_BossGoat();
			this.container.addChild(this._boss_mc);
			this._boss_mc.x = 400 - (this._boss_mc.width / 2);
			
			this._ymovement = 0;
			initializeEmitters();
		}
		
		protected override function moveBoss():void {
			this._boss_mc.x += this._xmovement;
			if (this._boss_mc.x > 450 || this._boss_mc.x < 250)
				this._xmovement = -this._xmovement;
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