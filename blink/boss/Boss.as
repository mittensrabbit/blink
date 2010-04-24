package boss
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
		public var bossData:BossData;
		protected var emitters:Array;
		
		public var _boss_mc:MovieClip;
		protected var _movement:Number = 1;
		
		public function Boss(container:MovieClip) 
		{
			this.emitters = new Array();
			this.container = container;
			this.bossData = new BossData();
			//initializeEmitters();
		}
		
		protected function initializeEmitters():void
		{
			for (var i:int; i < this._boss_mc.numChildren; i++)
			{
				var mc:MovieClip = this._boss_mc.getChildAt(i) as MovieClip;
				if (mc is Fla_Emitter)
				{
					//mc.visible = false;

					var emitter:Emitter = new Emitter(mc, EmitterTypes.LASER, this._boss_mc.x, this._boss_mc.y);

					emitters.push(emitter);
				}
				if (mc is Fla_Emitter1)
				{
					//mc.visible = false;

					emitter = new Emitter(mc, EmitterTypes.LASER, this._boss_mc.x, this._boss_mc.y);

					emitters.push(emitter);
				}
				if (mc is Fla_Emitter2)
				{
					//mc.visible = false;

					emitter = new Emitter(mc, EmitterTypes.MISSILE_YELLOW, this._boss_mc.x, this._boss_mc.y);

					emitters.push(emitter);
				}
				if (mc is Fla_Emitter3)
				{
					//mc.visible = false;

					emitter = new Emitter(mc, EmitterTypes.MISSILE_BLUE, this._boss_mc.x, this._boss_mc.y);

					emitters.push(emitter);
				}
				if (mc is Fla_Emitter4)
				{
					//mc.visible = false;

					emitter = new Emitter(mc, EmitterTypes.MISSILE_RED, this._boss_mc.x, this._boss_mc.y);

					emitters.push(emitter);
				}
			}
		}	
		
		public function handleEnterFrame(event:Event):void
		{
			moveBoss();
			for (var i:int = 0; i < emitters.length; i++)
			{
				var emitter:Emitter = emitters[i];
				emitter.handleEnterFrame(event);
				emitter.moveEmitter(this._movement, 0);
			}
			
		}
		protected function moveBoss():void 
		{
			
		}
	}
	
}