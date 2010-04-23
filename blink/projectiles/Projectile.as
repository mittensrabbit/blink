package projectiles
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import projectiles.ProjectileMovement;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Projectile 
	{
		public var container:MovieClip;
		public var projectileMovement:ProjectileMovement;
		public var behaviours:Array;
		
		public function Projectile(container:MovieClip) 
		{
			this.container = container;
			this.container.mouseChildren = false;
			this.container.mouseEnabled = false;
			this.projectileMovement = projectileMovement;
			this.behaviours = new Array();
		}
		
		public function addBehaviour(movement:ProjectileMovement):void
		{
			this.behaviours.push(movement);
		}
		
		public function checkEndCondition():Boolean
		{
			var point:Point = new Point(container.x, container.y);
			if (point.x > 650 || point.x < 150 || point.y > 600 || point.y < 0)
			{
				return true;
			}
			return false;
		}
		
		public function collisionDetectionAgainstObject(object:MovieClip):Boolean
		{
			if (object.hitTestObject(container.hitTest))
				return true;
			return false;
		}
		
		public function update():void
		{
			for (var i:int = 0; i < behaviours.length; i++)
			{
				this.behaviours[i].update();
			}
		}
	}
	
}