package com.mvc.model {
	import asunit.framework.TestCase;
	import com.FakeSoundManager;
	import com.ISoundManager;
	import com.mvc.model.entities.*;
	import com.SoundManager;

	public class GameLoopTest extends TestCase {
		private var gameLoop:GameLoop;
		private var player:FakePlayer;
		private var ground:FakeObstacle;
		private var obstacles:Vector.<IObstacle>;
		private var collectables:Vector.<ICollectable>;
		private var counter:IPointsCounter;
		private var soundManager:ISoundManager;

		public function GameLoopTest(testMethod:String = null):void {
			super(testMethod);
		}

		protected override function setUp():void {
			player = new FakePlayer();
			ground = new FakeObstacle();
			obstacles = new Vector.<IObstacle>();
			collectables = new Vector.<ICollectable>();
			counter = new FakePointsCounter();
			soundManager = new FakeSoundManager();

			gameLoop = new GameLoop(player, ground, obstacles, collectables, counter, soundManager);
		}

		public function test_things():void {

		}
	}
}