<<<<<<< .merge_file_nySr9e
﻿package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * PEW PEW PEW
	 * @author Yuri Doubov
	 */
	public class Zapper extends Sprite {
		private var _bossX:Number;
		private var _bossY:Number;
		
		private var _playerRef:Player;
		
		private var _zapper_mc:MovieClip;
		
		public function Zapper(pPlayer:Player, pBossX:Number, pBossY:Number) {
			this._bossX = pBossX;
			this._bossY = pBossY;
			
			this._playerRef = pPlayer;
			
			this._zapper_mc = new Fla_Zapp();
			addChild(_zapper_mc);
		}
		
		public function handleEnterFrame():void {
			this._zapper_mc.x = this._bossX;
			this._zapper_mc.y = this._bossY;
			
			var tempXside:Number = this._playerRef.playerData.coords.x - this._bossX;
			var tempYside:Number = this._playerRef.playerData.coords.y - this._bossY;
			var hypotenuse:Number = Math.sqrt(tempXside * tempXside + tempYside * tempYside);
			//var ratio:Number;
			//
			//if (Math.abs(tempXside) > Math.abs(tempYside))
				//ratio = Math.abs(hypotenuse / tempXside);
			//else
				//ratio = Math.abs(hypotenuse / tempYside);
			
			this._zapper_mc.rotation = 0;
			this._zapper_mc.height = hypotenuse;
			
			this._zapper_mc.width = 30;
			
			var targetRotation = Math.atan2(tempYside, tempXside) * 180 / Math.PI;
			targetRotation -= 90;
			
			this._zapper_mc.rotation = targetRotation;
		}
	}
=======
﻿package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * PEW PEW PEW
	 * @author Yuri Doubov
	 */
	public class Zapper extends Sprite {
		private var _bossX:Number;
		private var _bossY:Number;
		
		private var _playerRef:Player;
		
		private var _zapper_mc:MovieClip;
		
		public function Zapper(pPlayer:Player, pBossX:Number, pBossY:Number) {
			this._bossX = pBossX;
			this._bossY = pBossY;
			
			this._playerRef = pPlayer;
			
			this._zapper_mc = new Fla_Zapp();
			addChild(_zapper_mc);
		}
		
		public function handleEnterFrame():void {
			this._zapper_mc.x = this._bossX;
			this._zapper_mc.y = this._bossY;
			
			var tempXside:Number = this._playerRef.playerData.coords.x - this._bossX;
			var tempYside:Number = this._playerRef.playerData.coords.y - this._bossY;
			var hypotenuse:Number = Math.sqrt(tempXside * tempXside + tempYside * tempYside);
			var ratio:Number;
			
			if (Math.abs(tempXside) > Math.abs(tempYside))
				ratio = Math.abs(hypotenuse / tempXside);
			else
				ratio = Math.abs(hypotenuse / tempYside);
			
			this._zapper_mc.rotation = 0;
			this._zapper_mc.height = hypotenuse;
			
			this._zapper_mc.width = 15;
			
			var targetRotation = Math.atan2(tempYside, tempXside) * 180 / Math.PI;
			targetRotation -= 90;
			
			this._zapper_mc.rotation = targetRotation;
		}
	}
>>>>>>> .merge_file_omID1L
}