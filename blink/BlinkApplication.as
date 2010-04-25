package 
{
	import boss.GunWallBoss;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import renderer.ParticleRequestHandler;
	import boss.AirSentryBoss;
	import boss.AngryAirSentryBoss;
	import boss.GunShipBoss;
	import boss.HappySunBoss;
	import boss.TestBoss;
	import boss.TrollFaceBoss;
	import boss.VeryHappySunBoss;
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
	import flash.ui.Mouse;
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
		private var deathScreen:MovieClip;
		private var stageSelection:StageSelection;
		private var player:Player;
		private var hud:HeadsUpDisplay;
		public var level:Level;
		private var projectileEngine:ProjectileEngine;
		private var rulesPage:MovieClip;
		
		private var backgroundMusic:SoundChannel;
		
		private var currentLevelResult:LevelResultData;
		
		private var _zapperLightning:Zapper;
		
		public var blinkCooldown:Number = 0;
		
		public var particleRequestHandler:ParticleRequestHandler;
		
		public function BlinkApplication() 
		{
			this.particleRequestHandler = new ParticleRequestHandler(this);
			this.titleScreen = new Title(new Fla_Title());
			this.titleScreen.container.addEventListener(MouseEvent.CLICK, handleTitleClick);
			this.bossResultScreen = new BossResultScreen();
			this.bossResultScreen.container.addEventListener(MouseEvent.CLICK, showSelectorScreenFromResults);
			this.backgroundMusic = new SoundChannel();
			
			this.deathScreen = new Fla_Death();
			this.deathScreen.addEventListener(MouseEvent.CLICK, showSelectorScreenFromDeath);
			
			this.rulesPage = new Fla_Rules(); 
			this.rulesPage.addEventListener(MouseEvent.CLICK, startLevel);
			this.addChild(titleScreen.container);
			
		}
		
		private function showSelectorScreenFromDeath(event:MouseEvent):void
		{
			this.removeChild(deathScreen);
			setupSelectionFromResult();
		}
		
		private function showSelectorScreenFromResults(event:MouseEvent):void
		{
			this.removeChild(bossResultScreen.container);
			setupSelectionFromResult();
		}
		
		private function setupSelectionFromResult():void
		{
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
			this.stageSelection.addBossSelection(new StageSelectionElement(BossName.AIR_SENTRY, "Yellow missles explode into bullets - blink away!" ));
			this.stageSelection.addBossSelection(new StageSelectionElement(BossName.ANGRY_AIR_SENTRY, "You beat him once.. now he is pissed!" ));
			this.stageSelection.addBossSelection(new StageSelectionElement(BossName.GUN_WALL, "Start flying up immediately!" ));
			this.stageSelection.addBossSelection(new StageSelectionElement(BossName.HAPPY_SUN, "Lasers!" ));
			this.stageSelection.addBossSelection(new StageSelectionElement(BossName.VERY_HAPPY_SUN, "MOAR Lasers!" ));
			this.stageSelection.addBossSelection(new StageSelectionElement(BossName.GUN_SHIP, "Nuff said" ));
			this.stageSelection.addBossSelection(new StageSelectionElement(BossName.TROLL_FACE, "Trolol!" ));

			this.addChild(stageSelection.container);
			this.addChild(stageSelection.handles);
		}
		
		
		private function handleLevelRequest(event:LevelRequestEvent):void
		{
			this.stageSelection.container.removeEventListener(LevelRequestEvent.LEVEL_REQUEST, handleLevelRequest);
			removeChild(stageSelection.container);
			removeChild(stageSelection.handles);
			initLevel(event._eventName);
			
			trace("event " + event._eventName);

			stage.focus = stage;
		}
		
		private function startLevel(event:MouseEvent):void
		{
			removeChild(rulesPage);
			backgroundMusic = new Fla_sfx_bgMusic().play();
			backgroundMusic = new Fla_sfx_flight().play();
			
					
			stage.addEventListener(Event.ENTER_FRAME, mainGameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboardDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyboardUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseClick);		
			currentLevelResult.startLevelTime();
			//endLevel();
		}
		
		public function endLevel()
		{
			SoundMixer.stopAll();
			trace("ENDING LEVEL");
			currentLevelResult.saveFinalTime();
			bossResultScreen.refresh(currentLevelResult);
			stageSelection.refreshMenu(currentLevelResult);
			
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
		public function endLevelPlayerDead():void 
		{
			SoundMixer.stopAll();
			//show results, update stage selection screen with new rank etc..
			stage.removeEventListener(Event.ENTER_FRAME, mainGameLoop);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyboardDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, handleKeyboardUp);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, handleMouseClick);	
			addChild(deathScreen);
			
			removeChild(level.layers[0].container);
			removeChild(projectileEngine.container);
			removeChild(level.boss.container);
			removeChild(this._zapperLightning);
			removeChild(player.ship);
			removeChild(player);
			removeChild(hud.container);
		}
		
		private function initLevel(pBossType:String):void
		{
			this.player = new Player(this);		
			this.level = new Level();
			currentLevelResult = new LevelResultData(pBossType)
			this.projectileEngine = new ProjectileEngine(player, this);
			
			if(pBossType == BossName.GOAT)
				this.level.setBoss(new GoatBoss(this, new Fla_Boss(),this.player));
			else if (pBossType == BossName.AIR_SENTRY)
				this.level.setBoss(new AirSentryBoss(this, new Fla_Boss(),this.player));
			else if (pBossType == BossName.TROLL_FACE)
				this.level.setBoss(new TrollFaceBoss(this, new Fla_Boss(),this.player));
			else if (pBossType == BossName.TEST_BOSS)
				this.level.setBoss(new TestBoss(this, new Fla_Boss(),this.player));
			else if (pBossType == BossName.ANGRY_AIR_SENTRY)
				this.level.setBoss(new AngryAirSentryBoss(this, new Fla_Boss(),this.player));		
			else if (pBossType == BossName.HAPPY_SUN)
				this.level.setBoss(new HappySunBoss(this, new Fla_Boss(),this.player));	
			else if (pBossType == BossName.VERY_HAPPY_SUN)
				this.level.setBoss(new VeryHappySunBoss(this, new Fla_Boss(),this.player));	
			else if (pBossType == BossName.GUN_SHIP)
				this.level.setBoss(new GunShipBoss(this, new Fla_Boss(),this.player));	
			else if (pBossType == BossName.GUN_WALL)
				this.level.setBoss(new GunWallBoss(this, new Fla_Boss(), this.player));	
				
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
			
			this.hud = new HeadsUpDisplay(this, player.playerData, this.level.boss.bossData);
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
			this.blinkCooldown = (this.blinkCooldown < 1? 0:this.blinkCooldown - 1);
			if (this.level.boss.testPlayerCollision(this.player)) {
				player.blinkToRandom();
			}
			
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