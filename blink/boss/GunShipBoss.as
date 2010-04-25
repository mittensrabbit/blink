package boss 
{
	import projectiles.EmitterIntervalShootMovement;
	import boss.Boss;
	import flash.display.MovieClip;
	import flash.events.Event;
	import projectiles.EmitterDefaultMovement;
	import projectiles.EmitterPlayerTrackingMovement;
	import projectiles.EmitterSprinklerMovement;
	import projectiles.IEmitterMovement;
	/**
	 * ...
	 * @author Yuri Doubov
	 */
	public class GunShipBoss extends Boss
	{
		public function GunShipBoss(pBlinkApp:BlinkApplication, container:MovieClip) 
		{
			super(pBlinkApp, container);
			this._boss_mc = new Fla_BossGunShip();
			this.container.addChild(this._boss_mc);
			this._boss_mc.x = 400-(this._boss_mc.width/2);
			
			this.emitterYellowMissile  = new EmitterDefaultMovement();
		//	this.emitterYellowMissile2  = new EmitterIntervalShootMovement(50);
			this.emitterBlueMissile  = new EmitterDefaultMovement();
			this.emitterRedMissile = new EmitterDefaultMovement();

			this.emitterLaser_0 = new EmitterSprinklerMovement(30, 1, 2);
			this.emitterLaser_1 = new EmitterSprinklerMovement( -30, 1, 2);
			//this.emitterLaser_2 = new EmitterPlayerTrackingMovement(4, 5, 
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