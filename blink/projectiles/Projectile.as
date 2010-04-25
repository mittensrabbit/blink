package projectiles
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import projectiles.IProjectileMovement;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Projectile 
	{
		public var container:MovieClip;
		public var projectileMovement:IProjectileMovement;
		public var behaviours:Array;
		public var endBehaviour:IProjectileMovement;
		public var damage:int;
		
		
		private var endCondition:Boolean;
		private var maxDuration:int;
		private var currDuration:int;
	
		public function Projectile(container:MovieClip,maxDuration:int, damage:int) 
		{
			this.container = container;
			this.container.mouseChildren = false;
			this.container.mouseEnabled = false;
			this.projectileMovement = projectileMovement;
			this.behaviours = new Array();
			this.endBehaviour = null;
			this.maxDuration = maxDuration ;
			this.currDuration = 0;
			this.endCondition = false;
			this.damage = damage;
		}
		
		public function addBehaviour(movement:IProjectileMovement):void
		{
			this.behaviours.push(movement);
			
		}
		
		public function addEndBehaviour(behaviour:IProjectileMovement):void
		{
			this.endBehaviour = behaviour;
			
		}
		
		public function checkEndCondition():Boolean
		{
			var point:Point = new Point(container.x, container.y);
			if (point.x > 650 || point.x < 150 || point.y > 600 || point.y < 0 ||currDuration>=maxDuration || this.endCondition == true)
			{
				if(this.endBehaviour == null)
					return true;
				else
				{
					this.behaviours = new Array;
					this.behaviours.push(this.endBehaviour);
					this.endBehaviour = null;
					//this.maxDuration = 999;
					return false;
				}
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
			currDuration++;
			
		}
	}
	
}