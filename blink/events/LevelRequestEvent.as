package events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class LevelRequestEvent extends Event
	{
		public static const LEVEL_REQUEST:String = "level_request";
		
		public var _eventName:String;
		public function LevelRequestEvent(pEventName:String) 
		{
			super(LEVEL_REQUEST, true);
			this._eventName = pEventName;
		}
		
	}
	
}