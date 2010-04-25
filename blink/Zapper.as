package
{
	import boss.Boss;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	/**
	 * PEW PEW PEW
	 * @author Yuri Doubov
	 */
	public class Zapper extends Sprite {
		private var _playerRef:Player;
		private var _bossRef:Boss;
		
		private var _zapper_mc:MovieClip;
		private var _length:Number;
		private var _visible:Boolean;
		private var _zapper_snd:Sound;
		private var _sndChannel:SoundChannel;
		
		public function Zapper(pPlayer:Player, pBoss:Boss) {
			this._bossRef = pBoss;
			this._playerRef = pPlayer;
			
			this._zapper_mc = new Fla_Zapp();
			this._sndChannel = new SoundChannel();
			//addChild(this._sndChannel);
			
			this._zapper_snd = new Fla_sfx_laser();
			//this._sndChannel = _zapper_snd.play();
			addChild(_zapper_mc);
		}
		
		public function get length():Number {
			return this._length;
		}
		public function get isVisible():Boolean {
			return this._visible;
		}
		
		public function handleEnterFrame():void {
			//trace("boss container" + this._bossRef.container.x + " y " + this._bossRef.container.y);
			
			this._zapper_mc.x = this._bossRef._boss_mc.x + this._bossRef._targetCoords_mc.x;//this._bossRef._boss_mc.x + this._bossRef._boss_mc.width / 2;
			this._zapper_mc.y = this._bossRef._boss_mc.y + this._bossRef._targetCoords_mc.y;//this._bossRef._boss_mc.y + this._bossRef._boss_mc.height / 2;
			var tempXside:Number = this._playerRef.playerData.coords.x - this._zapper_mc.x;
			var tempYside:Number = this._playerRef.playerData.coords.y - this._zapper_mc.y;
			var hypotenuse:Number = Math.sqrt(tempXside * tempXside + tempYside * tempYside);
			if (hypotenuse > 250){
				this._zapper_mc.visible = this._visible = false;
				this._sndChannel.stop();
				return;
			}
			if(!this._zapper_mc.visible) {
				this._zapper_mc.visible = this._visible = true;
				this._sndChannel = this._zapper_snd.play();
			}
			this._zapper_mc.alpha = 1 / hypotenuse * 170;
			this._bossRef.bossData.health -= (1/hypotenuse) * 100;
			
			//var ratio:Number;
			//
			//if (Math.abs(tempXside) > Math.abs(tempYside))
				//ratio = Math.abs(hypotenuse / tempXside);
			//else
				//ratio = Math.abs(hypotenuse / tempYside);
			this._length = hypotenuse;
			this._zapper_mc.rotation = 0;
			this._zapper_mc.height = hypotenuse;
			
			this._zapper_mc.width = 30;
			
			var targetRotation = Math.atan2(tempYside, tempXside) * 180 / Math.PI;
			targetRotation -= 90;
			
			this._zapper_mc.rotation = targetRotation;
		}
		public function cleanUp():void {
			this._sndChannel.stop();
		}
	}
}