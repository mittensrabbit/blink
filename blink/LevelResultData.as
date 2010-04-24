package 
{
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class LevelResultData 
	{
		public var startTime:Date
		public var time:Date;
		public var ranking:int;
		
		public function LevelResultData(startTime:Date) 
		{
			this.startTime = startTime;
			this.ranking = ranking = 0;
		}
		
		public function setRanking(ranking:int):void
		{
			this.ranking = ranking;
		}
	}
	
}