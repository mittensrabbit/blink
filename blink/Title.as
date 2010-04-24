package 
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Title extends EventDispatcher
	{
		public var container:MovieClip;
		
		public function Title(container:MovieClip):void
		{
			this.container = container;
		}
		
	}
	
}