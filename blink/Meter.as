package
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Meter 
	{
		public var container:MovieClip;
		private var percent:int;
		
		public function Meter(meter:MovieClip) 
		{
			this.container = meter;
			this.percent = -1;
		}
		
		public function update(percent:int):void
		{
			if (this.percent != percent)
			{
				this.container.gotoAndStop(percent);
				this.percent = percent
			}
		}
		
	}
	
}