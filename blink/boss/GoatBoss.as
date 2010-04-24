package boss 
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
		
		public function GoatBoss(container:MovieClip) 
		{
			super(container);
			this._boss_mc = new Fla_BossGoat();
			this.container.addChild(this._boss_mc);
			this._boss_mc.x = 350;
			
			initializeEmitters();
		}
		
		protected override function moveBoss():void {
			this._boss_mc.x += this._movement;
			if (this._boss_mc.x > 450 || this._boss_mc.x < 250)
				this._movement = -this._movement;
		}
		//protected override function rotateBoss():void {
			//this._boss_mc.rotation += this._rotation;
			//if (this._boss_mc.rotation > 10 || this._boss_mc.rotation < -10)
				//this._rotation = -this._rotation;
		//}
	}

}