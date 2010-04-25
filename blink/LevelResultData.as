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
			var nMillisElapsed:Number = new Date().time - nStart;	
			var strTime:String = 
			(Math.floor(nMillisElapsed / (1000 * 60)) % 60) + "::" + 
			(Math.floor(nMillisElapsed / (1000)) % 60) + "::" + 
			(Math.floor(nMillisElapsed) / (1000));

			timeAsString = strTime;
		}
		
		public function setRanking(ranking:int):void
		{
			this.ranking = ranking;
		}
	}
	
}