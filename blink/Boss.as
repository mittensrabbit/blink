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
		
		public var _boss_mc:MovieClip;
		private var _movement:Number = 1;
		
		public function Boss(container:MovieClip) 
		{
			this.emitters = new Array();
			this.container = container;
			this._boss_mc = new Fla_BossGoat();
			this.container.addChild(this._boss_mc);
			this._boss_mc.x = 350;
			initializeEmitters();
		}
		
		private function initializeEmitters():void
		{
			for (var i:int; i < this._boss_mc.numChildren; i++)
			{
				//var mc:MovieClip = container.getChildAt(i) as MovieClip;
				var mc:MovieClip = this._boss_mc.getChildAt(i) as MovieClip;
				if (mc is Fla_Emitter)
				{
					//mc.visible = false;
					var emitter:Emitter = new Emitter(mc, EmitterTypes.LASER, this._boss_mc.x, this._boss_mc.y);
					trace("this.bossx" + this._boss_mc.x +  " bossy" + this._boss_mc.y);
					emitters.push(emitter);
				}
			}
		}	
		
		public function handleEnterFrame(event:Event):void
		{
			this.moveBoss();
			for (var i:int = 0; i < emitters.length; i++)
			{
				var emitter:Emitter = emitters[i];
				emitter.handleEnterFrame(event);
				emitter.moveEmitter(this._movement, 0);
			}
			
		}
		
		private function moveBoss():void {
			this._boss_mc.x += this._movement;
			if (this._boss_mc.x > 450 || this._boss_mc.x < 250)
				this._movement = -this._movement;
		}
	}
	
}