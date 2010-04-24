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
		private var handles:MovieClip
		private var selections:Array;
		private var upHandle:MovieClip;
		private var downHandle:MovieClip;
		
		private var scrollingDown:Boolean;
		private var scrollingUp:Boolean;
		
		public function StageSelection() 
		{
			this.container = new MovieClip();
			this.container.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			this.selections = new Array();
			
			this.upHandle = new Fla_SelectionUp();
			upHandle.addEventListener(MouseEvent.MOUSE_OVER, handleMouseOver);
			upHandle.addEventListener(MouseEvent.MOUSE_OUT, handleMouseOut);
			
			this.scrollingDown = false;
			this.scrollingUp = false;
			
			this.downHandle = new Fla_SelectionDown();
			downHandle.addEventListener(MouseEvent.MOUSE_OVER, handleMouseOver);
			downHandle.addEventListener(MouseEvent.MOUSE_OUT, handleMouseOut);
			downHandle.y = 500;
			this.container.addChild(upHandle);
			this.container.addChild(downHandle);
		}
				
		public function addBossSelection(selection:StageSelectionElement):void
		{
			selections.push(selection);
			selection.container.y = OFFSET + StageSelectionElement.HEIGHT * selections.length;
			this.container.addChild(selection.container);
		}
	
		private function handleMouseOver(event:MouseEvent):void
		{
			if (event.target == this.downHandle)
			{
				scrollingDown = true;
			}
			if (event.target == this.upHandle)
			{
				scrollingUp = true;
			}
		}
		private function handleMouseOut(event:MouseEvent):void
		{
			if (event.target == this.downHandle)
			{
				scrollingDown = false
			}
			if (event.target == this.upHandle)
			{
				scrollingUp = false;
			}
		}
		
		private function handleEnterFrame(event:Event):void
		{
			if (scrollingUp)
				this.container.y += 5;
			if (scrollingDown)
				this.container.y -= 5;
		}
	}
	
}