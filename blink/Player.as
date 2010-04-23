package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Player extends Sprite
	{
		public var playerData:PlayerData;
		public var ship:MovieClip;
		
		private static const BOOSTER_SPEED:Number = 7.0;
		private var boosting_up:Boolean;
		private var boosting_down:Boolean;
		private var boosting_left:Boolean;
		private var boosting_right:Boolean;
		
		private var magnitude_up:Number;
		private var magnitude_down:Number;
		private var magnitude_left:Number;
		private var magnitude_right:Number;
		
		public function Player() 
		{
			this.ship = new Fla_Ship();
			this.playerData = new PlayerData();
			magnitude_up = 0;
			magnitude_down = 0;
			magnitude_left = 0;
			magnitude_right = 0;
		}
		
		public function handleKeyboardDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.UP || event.keyCode == 87)
			{
				boosting_up = true;
				boosting_down = false;
			}
			if (event.keyCode == Keyboard.DOWN || event.keyCode == 83)
			{
				boosting_down = true;
				boosting_up = false;
			}
			if (event.keyCode == Keyboard.LEFT || event.keyCode == 65)
			{
				boosting_left = true;
				boosting_right = false;
			}
			if (event.keyCode == Keyboard.RIGHT || event.keyCode == 68)
			{
				boosting_right = true;
				boosting_left = false;	
			}
		}
		public function handleKeyboardUp(event:KeyboardEvent):void
		{	
			if (event.keyCode == Keyboard.UP || event.keyCode == 87)
				boosting_up = false;
			if (event.keyCode == Keyboard.DOWN || event.keyCode == 83)
				boosting_down = false;
			if (event.keyCode == Keyboard.LEFT || event.keyCode == 65)
				boosting_left = false;
			if (event.keyCode == Keyboard.RIGHT || event.keyCode == 68)
				boosting_right= false;		
		}
		
		public function handleMouseClick(event:MouseEvent):void
		{
			blink(event);
		}
		
		private function blink(event:MouseEvent):void
		{
			ship.alpha = 0.1;
			playerData.damageMultiplier += 25;
			
			var mcIn:MovieClip = new Fla_TeleportIn();
			mcIn.alpha = 0.2;
			mcIn.x = playerData.coords.x;
			mcIn.y = playerData.coords.y;
			mcIn.mouseChildren = false;
			mcIn.mouseEnabled = false;
			addChild(mcIn);

			var coordsAfterBlink:Point = new Point(event.stageX, event.stageY);
			playerData.setCoordinates(coordsAfterBlink);
			syncShipCoords();

			var mc:MovieClip = new Fla_TeleportIn();
			mc.x = event.stageX;
			mc.y = event.stageY;
			mc.mouseChildren = false;
			mc.mouseEnabled = false;
			mc.alpha = 0.8
			
			addChild(mc);		
		}
		
		public function handleEnterFrame(event:Event):void
		{
			updateBoosters();
			applyBoosterToPlayerCoords();
			syncShipCoords();
			updateShipAlphaValue();	
			reduceDamageMultiplier();
		}
		
		private function syncShipCoords():void
		{
			ship.x = playerData.coords.x;
			ship.y = playerData.coords.y;
		}
		
		private function applyBoosterToPlayerCoords():void
		{
			playerData.coords.y -= (magnitude_up - magnitude_down);
			playerData.coords.x -= (magnitude_left - magnitude_right);	
		}
		
		private function reduceDamageMultiplier():void
		{
			if (playerData.damageMultiplier > 100)
				playerData.damageMultiplier -= 0.5;	
		}
		
		private function updateShipAlphaValue():void
		{
			if (ship.alpha < 1)
				ship.alpha += 0.05;
			if (ship.alpha > 1)
				ship.alpha = 1;		
		}

		private function updateBoosters():void
		{
			magnitude_up	= getBoosterMagnitude(boosting_up, magnitude_up);
			magnitude_down 	= getBoosterMagnitude(boosting_down, magnitude_down);
			magnitude_left  = getBoosterMagnitude(boosting_left, magnitude_left);
			magnitude_right = getBoosterMagnitude(boosting_right, magnitude_right);
		}
		
		private function getBoosterMagnitude(boosterDirectionOn:Boolean, magnitude:Number):Number
		{
			if (!boosterDirectionOn)
				magnitude = 0;
			else if (boosterDirectionOn && magnitude < BOOSTER_SPEED)
				magnitude += 1.5;
				
			if (magnitude > BOOSTER_SPEED)
				magnitude = BOOSTER_SPEED;
				
			return magnitude;
		}
	}
	
}