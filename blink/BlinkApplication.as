﻿package 
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
	import boss.Boss;
	import boss.GoatBoss;
	
	/**
	 * ...
	 * @author Brad Eccles
	 */
	public class BlinkApplication extends Sprite
	{
		private var titleScreen:Title;
		private var bossResultScreen:BossResultScreen;
		private var stageSelection:StageSelection;
		private var player:Player;
		private var hud:HeadsUpDisplay;
		private var level:Level;
		private var projectileEngine:ProjectileEngine;
		private var rulesPage:MovieClip;
		
		private var _zapperLightning:Zapper;
		
		public function BlinkApplication() 
		{
			this.stage.quality = "MEDIUM";
			this.titleScreen = new Title(new Fla_Title());
			this.titleScreen.container.addEventListener(MouseEvent.CLICK, handleTitleClick);
			this.bossResultScreen = new BossResultScreen();
			this.bossResultScreen.container.addEventListener(MouseEvent.CLICK, showSelectorScreenFromResults);
			
			this.rulesPage = new Fla_Rules(); 
			this.rulesPage.addEventListener(MouseEvent.CLICK, startLevel);
			this.addChild(titleScreen.container);
			
		}
		
		private function showSelectorScreenFromResults(event:MouseEvent):void
		{
			this.removeChild(bossResultScreen.container);
			this.addChild(stageSelection.container);
			this.addChild(stageSelection.handles);
			this.stageSelection.container.addEventListener(LevelRequestEvent.LEVEL_REQUEST, handleLevelRequest);
		}
		
		private function handleTitleClick(event:MouseEvent):void
		{
			removeChild(titleScreen.container);
			this.stageSelection = new StageSelection();
			this.stageSelection.container.addEventListener(LevelRequestEvent.LEVEL_REQUEST, handleLevelRequest);
			
			this.stageSelection.addBossSelection(new StageSelectionElement(BossName.GOAT,  "Intro stage - learn to fly and blink!" ));
			this.stageSelection.addBossSelection(new StageSelectionElement(BossName.AIR_SENTRY, "Beware the missles!" ));
			this.stageSelection.addBossSelection(new StageSelectionElement(BossName.TROLL_FACE, "Trolol!" ));
			this.stageSelection.addBossSelection(new StageSelectionElement("Level 4", "This is my Element" ));

			var date:Date = new Date();
			var testData:LevelResultData = new LevelResultData(BossName.GOAT, date);
			testData.ranking = 4;
			stageSelection.refreshMenu(testData);
			this.addChild(stageSelection.container);
			this.addChild(stageSelection.handles);
		}
		
		
		private function handleLevelRequest(event:LevelRequestEvent):void
		{
			this.stageSelection.container.removeEventListener(LevelRequestEvent.LEVEL_REQUEST, handleLevelRequest);
			removeChild(stageSelection.container);
			removeChild(stageSelection.handles);
			initLevel();
			
			
			var levelResult:LevelResultData = new LevelResultData(BossName.GOAT, new Date());
			levelResult.setRanking(2);
			bossResultScreen.refresh(levelResult);
			stage.focus = stage;
		}
		
		private function startLevel(event:MouseEvent):void
		{
			removeChild(rulesPage);
			
			stage.addEventListener(Event.ENTER_FRAME, mainGameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboardDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyboardUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseClick);		
			
			//endLevel();
		}
		
		public function endLevel()
		{
			//show results, update stage selection screen with new rank etc..
			stage.removeEventListener(Event.ENTER_FRAME, mainGameLoop);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyboardDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, handleKeyboardUp);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, handleMouseClick);	
			addChild(bossResultScreen.container);
			
			removeChild(level.layers[0].container);
			removeChild(projectileEngine.container);
			removeChild(level.boss.container);
			removeChild(this._zapperLightning);
			removeChild(player.ship);
			removeChild(player);
			removeChild(hud.container);	
		}
		
		private function initLevel():void
		{
			this.player = new Player();		
			this.level = new Level();
			this.projectileEngine = new ProjectileEngine(player);
			this.level.setBoss(new GoatBoss(this, new Fla_Boss()));
			
			level.boss.container.addEventListener(ProjectileRequestEvent.PROJECT_REQUEST, handleProjectileRequest);
			this.projectileEngine.container.addEventListener(ProjectileRequestEvent.PROJECT_REQUEST, handleProjectileRequest);
			
			var background:GraphicLayer = createBackgroundLayer(new Fla_Background(), 0);
			var behaviour:GraphicLayerScrollingBehaviour = new GraphicLayerScrollingBehaviour(4);
			background.setBehaviour(behaviour);
			
			var foreground:GraphicLayer = createBackgroundLayer(new Fla_Foreground(), 0.35);
			behaviour = new GraphicLayerScrollingBehaviour(4);
			foreground.setBehaviour(behaviour);

			level.addGraphicLayer(background);
			this._zapperLightning = new Zapper(this.player, this.level.boss);
			
			this.hud = new HeadsUpDisplay(player.playerData, this.level.boss.bossData);
			addChild(level.layers[0].container);
			addChild(projectileEngine.container);
			addChild(level.boss.container);
			addChild(this._zapperLightning);
			addChild(player.ship);
			addChild(player);

			
			//addChild(level.layers[1].container);
			addChild(hud.container);	
			addChild(rulesPage);
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
			
			this._zapperLightning.handleEnterFrame();
		}
		
		private function updateHUD():void
		{
			hud.update();
		}
		
		private function handleProjectileRequest(event:ProjectileRequestEvent):void
		{
			projectileEngine.addProjectile(event);
		}
		public function bossDead():void {
			
		}
	}
	
}