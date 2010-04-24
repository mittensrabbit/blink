package
{
	import events.LevelRequestEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class StageSelectionElement extends EventDispatcher
	{
		public static const HEIGHT:int = 100;
		public static const WIDTH:int = 800;
		
		public var name:String;
		public var description:String;
		public var container:MovieClip;
		
		public function StageSelectionElement(name:String, description:String) 
		{
			this.container = new Fla_StageSelectionElement();
			this.name = name;
			this.description = name;
			this.container.stars.gotoAndStop(1);
			this.container.stars.mouseChildren = false;
			this.container.stars.mouseEnabled = false;
			this.container.bossName.text = name;
			this.container.description.text = description;
			
			this.container.addEventListener(MouseEvent.CLICK, handleMouseClick);
		}

		public function refresh(levelResultData:LevelResultData):void
		{
			this.container.stars.gotoAndStop(levelResultData.ranking + 1);
			this.container.bestTime.text = levelResultData.timeAsString;
		}
		
		private function handleMouseClick(event:MouseEvent):void
		{
			container.dispatchEvent(new LevelRequestEvent(this.name));
		}
		
	}
	
}