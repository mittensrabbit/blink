package 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Yuri Doubov
	 */
	public class BlinkLoader extends Sprite
	{
		private var _loader:Loader;
		public function BlinkLoader() {
			this.stage.quality = "MEDIUM";
			this._loader = new Loader();
			this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onLoadProgress);
			this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadComplete);
			this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadFailed);
			var url:URLRequest = new URLRequest("BlinkApplication.swf");
			this._loader.load(url);
			this.addChild(this._loader);
			
		}
		private function onLoadFailed():void {
			trace("FAILED");
		}
		private function onLoadProgress(e:ProgressEvent):void {
			trace(e.bytesLoaded / e.bytesTotal);
		}
		private function onLoadComplete(e:Event):void {
			trace("COMPLETE");
			//this.addChild(this._loader.content);
		}
		
	}

}