package 
{
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class LevelResultData 
	{
		public var levelName:String;
		private var startTime:Date
		public var finalTime:Date;
		public var ranking:int;
		
		public function LevelResultData(levelName:String, startTime:Date) 
		{
			this.levelName = levelName;
			this.finalTime = new Date();
			this.startTime = startTime;
			this.ranking = ranking = 0;
			saveFinalTime();
		}
		
		public function saveFinalTime():void
		{
			var now:Date = new Date();
			finalTime.seconds = Math.abs(startTime.getSeconds() - now.getSeconds());
			finalTime.minutes = Math.abs(startTime.getMinutes() - now.getMinutes());
			finalTime.hours = Math.abs(startTime.getHours() - now.getHours());
		}
		
		public function setRanking(ranking:int):void
		{
			this.ranking = ranking;
		}
	}
	
}