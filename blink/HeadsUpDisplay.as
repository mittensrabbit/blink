package 
{
	import boss.BossData;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class HeadsUpDisplay 
	{
		public var container:MovieClip;
		private var bossMeter:Meter;
		private var playerMeter:Meter;
		private var playerData:PlayerData;
		private var bossData:BossData;
		
		private var _blinkAppRef:BlinkApplication;
		
		public function HeadsUpDisplay(pBlinkApp:BlinkApplication, playerData:PlayerData, bossData:BossData) {
			this._blinkAppRef = pBlinkApp;
			this.container = new Fla_HUD();
			this.bossMeter = new Meter(new Fla_BossMeter());
			this.playerMeter = new Meter(new Fla_PlayerMeter());
			this.playerData = playerData;
			this.bossData = bossData;
		
			bossMeter.container.x = 125;
			bossMeter.container.y = 14;
			playerMeter.container.x = 166;
			playerMeter.container.y = 591;
			
			this.container.addChild(this.bossMeter.container);
			this.container.addChild(this.playerMeter.container);
		}
		
		public function update():void
		{
			container.weakness.field.text = Math.round(playerData.damageMultiplier) + "%";
			var healthPercent:int = new int((playerData.health / PlayerData.MAX_HEALTH) * 100);
			if (healthPercent <= 0)
				this._blinkAppRef.endLevelPlayerDead();
			this.playerMeter.update(healthPercent);
			
			healthPercent = int((bossData.health / bossData.max_health) * 100);
			if (healthPercent <= 0) {
				_blinkAppRef.level.boss.bossDead();
			}
			this.bossMeter.update(healthPercent);
		}
	}
}