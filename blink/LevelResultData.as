package 
{
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class LevelResultData 
	{
		public var levelName:String;
		private var nStart:Number
		public var finalTime:Date;
		public var ranking:int;
		public var timeAsString:String;
		
		public function LevelResultData(levelName:String) 
		{
			this.levelName = levelName;
			this.finalTime = new Date();
			this.ranking = ranking = 0;
		}
		
		public function startLevelTime():void
		{
			nStart = new Date().time
			timeAsString = "";
		}
		
		public function saveFinalTime():void
		{
			trace(this.levelName);
			var nMillisElapsed:Number = new Date().time - nStart;	
			var strTime:String = 
			(Math.floor(nMillisElapsed / (1000 * 60)) % 60) + "::" + 
			(Math.floor(nMillisElapsed / (1000)) % 60) + "::" + 
			(Math.floor(nMillisElapsed) / (1000));

			timeAsString = strTime;
			this.setRanking(nMillisElapsed);
		}
		
		public function setRanking(nMillisElapsed:Number):void
		{
			var minutes:Number = (Math.floor(nMillisElapsed / (1000 * 60)) % 60);
			var seconds:Number = (Math.floor(nMillisElapsed / (1000)) % 60);
			///GOAT RANKINGS
			if (BossName.GOAT == this.levelName) {
				if (minutes >= 1) 
					this.ranking = 1;
				else if (seconds > 50) 
					this.ranking = 2;
				else if (seconds > 40)
					this.ranking = 3;
				else if (seconds > 35)
					this.ranking = 4;
				else if (seconds <= 35)
					this.ranking = 5;
				
			}
			else if (BossName.AIR_SENTRY == this.levelName) {
				
			}
			else if (BossName.TROLL_FACE == this.levelName) {
				
			}
			trace("this.ranking" + this.ranking);
			//this.ranking = ranking;
		}
	}
	
}