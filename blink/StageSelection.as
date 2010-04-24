package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class StageSelection 
	{
		public const OFFSET:int = 50;
		
		public var container:MovieClip;
		private var display:MovieClip;
		
		public var handles:MovieClip
		private var selections:Array;
		
		private var scrollingSpeed:int = 0;
		
		public function StageSelection() 
		{
			this.container = new MovieClip;
			var background:MovieClip;
			background = new Fla_SelectionBackground();
			background.cacheAsBitmap = true;
			this.container.addChild(background);
			this.display = new MovieClip();
			this.container.addChild(display);
			this.display.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			this.display.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			this.selections = new Array();
			
		
			this.handles = new Fla_SelectionHandlers();
			this.handles.mouseEnabled = false;
			this.handles.mouseChildren = false;
		}
				
		public function addBossSelection(selection:StageSelectionElement):void
		{
			selections.push(selection);
			selection.container.y = OFFSET + StageSelectionElement.HEIGHT * selections.length;
			this.display.addChild(selection.container);
		}

		
		private function handleMouseMove(event:MouseEvent):void
		{
			scrollingSpeed = 300 - event.stageY;
		}
		
		private function handleEnterFrame(event:Event):void
		{
			
			if (Math.abs(scrollingSpeed) > 25 )
			{
				this.display.y += (scrollingSpeed)/25;
			}
			
			if (this.display.y > 0)
				this.display.y = 0;
			
			if (this.display.y < -StageSelectionElement.HEIGHT *  (selections.length -3))
				this.display.y = -StageSelectionElement.HEIGHT *  (selections.length -3);

		}
	}
	
}