package com.mvc.model {
	import asunit.framework.TestCase;
	import com.FakeSoundManager;
	import com.ISoundManager;
	import com.mvc.model.entities.*;
	import flash.utils.Timer;

	public class GameLoopTest extends TestCase {
		private var gameModel:IGameModel;
		private var gameLoop:GameLoop;
		private var player:FakePlayer;
		private var ground:FakeObstacle;
		private var obstacles:Vector.<IObstacle>;
		private var collectables:Vector.<ICollectable>;
		private var counter:IPointsCounter;
		private var soundManager:ISoundManager;
		private var timer:Timer;

		public function GameLoopTest(testMethod:String = null):void {
			super(testMethod);
		}

		protected override function setUp():void {
			gameModel = new FakeGameModel();
			player = new FakePlayer();
			ground = new FakeObstacle();
			obstacles = new Vector.<IObstacle>();
			collectables = new Vector.<ICollectable>();
			counter = new FakePointsCounter();
			soundManager = new FakeSoundManager();
			timer = new Timer(1000);

			gameLoop = new GameLoop(gameModel, player, ground, obstacles, collectables, counter, soundManager, timer);

			obstacles.push(new FakeObstacle());
		}

		public function test_throws_error_for_no_obstacles():void {
			obstacles.length = 0;
			assertThrows(GameLoopError, function():void {
					gameLoop.start();
				});
		}

		public function test_start_starts_timer():void {
			obstacles.push(new FakeObstacle());
			gameLoop.start();
			assertTrue(timer.running);
		}
	}
}