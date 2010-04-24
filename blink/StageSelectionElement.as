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
			
			this.container.bossName.text = name;
			this.container.description.text = description;
			
			this.container.addEventListener(MouseEvent.CLICK, handleMouseClick);
		}

		private function handleMouseClick(event:MouseEvent):void
		{
			container.dispatchEvent(new LevelRequestEvent());
		}
		
	}
	
}