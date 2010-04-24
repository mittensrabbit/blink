package 
{
	import events.LevelRequestEvent;
	import flash.accessibility.Accessibility;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import projectiles.ProjectileRequestEvent;
	import projectiles.ProjectileEngine;
	import renderer.GraphicElement;
	import renderer.GraphicLayer;
	import renderer.GraphicLayerScrollingBehaviour;
	
	/**
	 * ...
	 * @author Brad Eccles
	 */
	public class BlinkApplication extends Sprite
	{
		private var titleScreen:Title;
		private var stageSelection:StageSelection;
		private var player:Player;
		private var hud:MovieClip;
		private var level:Level;
		private var projectileEngine:ProjectileEngine;
		
		public function BlinkApplication() 
		{
			this.stage.quality = "MEDIUM";
			this.titleScreen = new Title(new Fla_Title());
			this.titleScreen.container.addEventListener(MouseEvent.CLICK, handleTitleClick);
			this.addChild(titleScreen.container);
			
		}
		
		private function handleTitleClick(event:MouseEvent):void
		{
			removeChild(titleScreen.container);
			this.stageSelection = new StageSelection();
			this.stageSelection.container.addEventListener(LevelRequestEvent.LEVEL_REQUEST, handleLevelRequest);
			
			this.stageSelection.addBossSelection(new StageSelectionElement("Goat",  "Intro stage - learn to fly and blink!" ));
			this.stageSelection.addBossSelection(new StageSelectionElement("Boss name lol", "Beware the missles!" ));
			this.stageSelection.addBossSelection(new StageSelectionElement("ROFLCOPTER", "Trolol!" ));
			this.stageSelection.addBossSelection(new StageSelectionElement("Level 4", "This is my Element" ));

			this.addChild(stageSelection.container);
			this.addChild(stageSelection.buttons);
		}
		
		private function handleLevelRequest(event:LevelRequestEvent):void
		{
			this.stageSelection.container.removeEventListener(LevelRequestEvent.LEVEL_REQUEST, handleLevelRequest);
			removeChild(stageSelection.container);
			removeChild(stageSelection.buttons);
			initLevel();
			stage.focus = stage;
		}
		
		private function initLevel():void
		{
			stage.addEventListener(Event.ENTER_FRAME, mainGameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboardDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyboardUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseClick);
			
			this.player = new Player();		
			this.level = new Level();
			this.projectileEngine = new ProjectileEngine(player);
			this.level.setBoss(new Boss(new Fla_Boss()));
			level.boss.container.addEventListener(ProjectileRequestEvent.PROJECT_REQUEST, handleProjectileRequest);
			
			var background:GraphicLayer = createBackgroundLayer(new Fla_Background(), 0);
			var behaviour:GraphicLayerScrollingBehaviour = new GraphicLayerScrollingBehaviour(4);
			background.setBehaviour(behaviour);
			
			var foreground:GraphicLayer = createBackgroundLayer(new Fla_Foreground(), 0.35);
			behaviour = new GraphicLayerScrollingBehaviour(4);
			foreground.setBehaviour(behaviour);

			level.addGraphicLayer(background);
			//level.addGraphicLayer(foreground);
			
			this.hud = new Fla_HUD();
			addChild(level.layers[0].container);
			addChild(projectileEngine.container);
			addChild(level.boss.container);
			addChild(player.ship);
			addChild(player);
			
			//addChild(level.layers[1].container);
			addChild(hud);		
		}
		
		private function createBackgroundLayer(mc:MovieClip, alpha:Number):GraphicLayer
		{
			var layer:GraphicLayer = new GraphicLayer(new Point(500,600), alpha);
			layer.container.x = 150	
			
			var graphicElement:GraphicElement = new GraphicElement(mc, new Point(0, -0), alpha);
			layer.addElement(graphicElement);
			
			mc.gotoAndStop(2);
			graphicElement = new GraphicElement(mc, new Point(0, -mc.height) , alpha);
			layer.addElement(graphicElement);
			
			return layer;
		}
		
		private function handleMouseClick(event:MouseEvent):void
		{
			player.handleMouseClick(event);
		}
		
		private function handleKeyboardDown(event:KeyboardEvent):void
		{
			player.handleKeyboardDown(event);
		}
		
		private function handleKeyboardUp(event:KeyboardEvent):void
		{
			player.handleKeyboardUp(event);
		}		
		
		private function mainGameLoop(event:Event):void
		{
			updateHUD();
			player.handleEnterFrame(event);
			level.render(event);
			level.boss.handleEnterFrame(event);
			projectileEngine.handleEnterFrame(event);
		}
		
		private function updateHUD():void
		{
			hud.weakness.field.text = Math.round(player.playerData.damageMultiplier) + "%";
		}
		
		private function handleProjectileRequest(event:ProjectileRequestEvent):void
		{
			projectileEngine.addProjectile(event);
		}
	}
	
}