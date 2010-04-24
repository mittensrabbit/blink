package
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class BossResultScreen
	{
		public var container:MovieClip;
		
		public function BossResultScreen() 
		{
			this.container = new Fla_Results();
			this.container.stars.play();
		}
		
		public function refresh(levelResultData:LevelResultData):void
		{
			var frame:int = levelResultData.ranking + 1;
			container.stars.gotoAndStop(levelResultData.ranking + 1);
		}
		
	}
	
}