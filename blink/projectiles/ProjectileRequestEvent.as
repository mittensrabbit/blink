package projectiles
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class ProjectileRequestEvent extends Event
	{
		public static const PROJECT_REQUEST:String = "projectile_request";
		public var emitterData:EmitterData;
		
		public function ProjectileRequestEvent(request:String, emitterData:EmitterData) 
		{
			super(request, true);
			this.emitterData = emitterData;
		}
		
	}
	
}