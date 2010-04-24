package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import projectiles.Emitter;

	import projectiles.EmitterTypes;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Boss 
	{
		public var container:MovieClip;
		private var emitters:Array;
		
		public function Boss(container:MovieClip) 
		{
			this.emitters = new Array();
			this.container = container;
			initializeEmitters();
		}
		
		private function initializeEmitters():void
		{
			for (var i:int; i < container.numChildren; i++)
			{
				var mc:MovieClip = container.getChildAt(i) as MovieClip;
				if (mc is Fla_Emitter)
				{
					mc.visible = false;
					var emitter:Emitter = new Emitter(mc,EmitterTypes.MISSILE_RED);
					emitters.push(emitter);
				}
			}
		}	
		
		public function handleEnterFrame(event:Event):void
		{
			for (var i:int = 0; i < emitters.length; i++)
			{
				var emitter:Emitter = emitters[i];
				emitter.handleEnterFrame(event);
			}
		}
	}
	
}