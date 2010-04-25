package boss
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import projectiles.Emitter;
	import projectiles.IEmitterMovement;

	import projectiles.EmitterTypes;
	
	/**
	 * ...
	 * @author Bread
	 */
	public class Boss 
	{
		public var container:MovieClip;
		public var bossData:BossData;
		protected var emitters:Array;
		
		protected var emitterLaser_0:IEmitterMovement;
		protected var emitterLaser_1:IEmitterMovement;
		protected var emitterYellowMissile:IEmitterMovement;
		protected var emitterBlueMissile:IEmitterMovement;
		protected var emitterRedMissile:IEmitterMovement;
		
		
		public var _boss_mc:MovieClip;
		protected var _xmovement:Number = 0;
		protected var _ymovement:Number = 0;
		protected var _rotation:Number = 0;
		protected var _blinkApplicationRef:BlinkApplication;
		protected var hitPointsArray:Array;
		
		public var _targetCoords_mc:MovieClip;
		
		public function Boss(pBlinkApp:BlinkApplication, container:MovieClip) 
		{
			this._blinkApplicationRef = pBlinkApp;
			this.emitters = new Array();
			
			this.emitterLaser_0 = null;
			this.emitterLaser_1 = null;
			this.emitterBlueMissile = null;
			this.emitterRedMissile = null;
			this.emitterYellowMissile = null;
			
			this.hitPointsArray = new Array();
			this.container = container;
			this.bossData = new BossData(this);
			//initializeEmitters();
		}
		
		protected function initializeEmitters():void
		{
			for (var i:int; i < this._boss_mc.numChildren; i++)
			{
				var mc:MovieClip = this._boss_mc.getChildAt(i) as MovieClip;
				if (mc is Fla_HitTest) {
					mc.visible = false;
					this.hitPointsArray.push(mc);
				}
				if (mc is Fla_Target) {
					mc.visible = false;
					this._targetCoords_mc = mc;
				}
				if (mc is Fla_Emitter)
				{
					//mc.visible = false;

					var emitter:Emitter = new Emitter(mc, EmitterTypes.LASER, this._boss_mc.x, this._boss_mc.y);
					if(this.emitterLaser_0 != null) emitter.setEmitterType(this.emitterLaser_0);
					emitters.push(emitter);
				}
				if (mc is Fla_Emitter1)
				{
					//mc.visible = false;

					emitter = new Emitter(mc, EmitterTypes.LASER, this._boss_mc.x, this._boss_mc.y);
					if(this.emitterLaser_1 != null) emitter.setEmitterType(this.emitterLaser_1);
					emitters.push(emitter);
				}
				if (mc is Fla_Emitter2)
				{
					//mc.visible = false;

					emitter = new Emitter(mc, EmitterTypes.MISSILE_YELLOW, this._boss_mc.x, this._boss_mc.y);
					if(this.emitterYellowMissile != null) emitter.setEmitterType(this.emitterYellowMissile);
					emitters.push(emitter);
				}
				if (mc is Fla_Emitter3)
				{
					//mc.visible = false;

					emitter = new Emitter(mc, EmitterTypes.MISSILE_BLUE, this._boss_mc.x, this._boss_mc.y);
					if (this.emitterBlueMissile != null)
					{ 
						emitter.setEmitterType(this.emitterBlueMissile.copyBase());
					}
					emitters.push(emitter);
				}
				if (mc is Fla_Emitter4)
				{
					//mc.visible = false;

					emitter = new Emitter(mc, EmitterTypes.MISSILE_RED, this._boss_mc.x, this._boss_mc.y);
					if(this.emitterRedMissile != null) emitter.setEmitterType(this.emitterRedMissile.copyBase());
					emitters.push(emitter);
				}
			}
		}	
		
		public function handleEnterFrame(event:Event):void
		{
			moveBoss();
			rotateBoss();
			for (var i:int = 0; i < emitters.length; i++)
			{
				var emitter:Emitter = emitters[i];
				emitter.handleEnterFrame(event);
				emitter.moveEmitter(this._xmovement, this._ymovement);
				emitter.rotateEmitter(this._rotation);
			}
		}
		
		public function testPlayerCollision(pPlayer:Player):Boolean {
			for (var i in this.hitPointsArray) {
				if (pPlayer.ship.hitTestObject(this.hitPointsArray[i]))
					return true;
			}
			return false;
		}
		
		public function bossDead():void 
		{
			//container.removeChild(this.
		}
		
		//OVERRIDE THOSE IN CHILD CLASSES
		protected function moveBoss():void 
		{
			
		}
		protected function rotateBoss():void 
		{
			
		}
	}
	
}