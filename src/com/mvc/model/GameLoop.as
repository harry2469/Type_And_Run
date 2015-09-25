package com.mvc.model {
	import com.ISoundManager;
	import com.mvc.model.entities.*;
	import com.mvc.view.entities.PlayerView;
	import com.SoundManager;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Timer;
	import kris.RectangleCollision;
	import org.flashdevelop.utils.FlashConnect;

	public class GameLoop {
		static private const LOOP_FREQUENCY:Number = 10;
		static private const NO_OBSTACLES_ERROR:GameLoopError = new GameLoopError("You have not passed any obstacles to GameLoop, this is probably a mistake");

		private var _player:IPlayer;
		private var _ground:IEntityModel;
		private var _obstacles:Vector.<IObstacle>;
		private var _collectables:Vector.<ICollectable>;
		private var _counter:IPointsCounter;
		private var _gameModel:IGameModel;
		private var _soundManager:ISoundManager;
		private var _gameClock:Timer;

		public function GameLoop(gameModel:IGameModel, player:IPlayer, ground:IObstacle, obstacles:Vector.<IObstacle>, collectables:Vector.<ICollectable>, counter:IPointsCounter, soundManager:ISoundManager, gameClock:Timer = null):void {
			_gameModel = gameModel;
			_soundManager = soundManager;
			_player = player;
			_ground = ground;
			_obstacles = obstacles;
			_collectables = collectables;
			_counter = counter;
			_gameClock = gameClock || new Timer(LOOP_FREQUENCY);
			_gameClock.addEventListener(TimerEvent.TIMER, update);
		}

		public function start():void {
			checkInputs();
			_gameClock.start();
		}

		private function checkInputs():void {
			if (_obstacles.length == 0)
				throw NO_OBSTACLES_ERROR;
		}

		private function update(event:TimerEvent):void {
			moveLevel();
			movePlayer();
			processCollisions();
			checkFailure();
			checkSuccess();
		}

		private function moveLevel():void {
			moveEntitysInListByAmount(_obstacles, -ObstacleModel.SPEED, 0);
			moveEntitysInListByAmount(_collectables, -ObstacleModel.SPEED, 0);
		}

		private function moveEntitysInListByAmount(list:*, xAmount:Number, yAmount:Number):void {
			for each (var item:IEntityModel in list)
				item.moveBy(xAmount, yAmount);
		}

		private function movePlayer():void {
			advancePlayerIfBehind();
			_player.fallIfFalling();
		}

		private function advancePlayerIfBehind():void {
			_player.advanceIfLeftOf(400);
		}

		private function processCollisions():void {
			processObstacleCollisionsUnlessFalling();
			processCollectableCollisions();
			applyFunctionIfColliding(_player, _ground, processCollision, [_player, _ground]);
		}

		private function processObstacleCollisionsUnlessFalling():void {
			if (!_player.falling)
				processObstacleCollisions();
		}

		private function processObstacleCollisions():void {
			for each (var obstacle:IObstacle in _obstacles)
				applyFunctionIfColliding(_player, obstacle, processCollision, [_player, obstacle]);
		}

		private function processCollectableCollisions():void {
			for each (var collectable:CollectableModel in _collectables)
				applyFunctionIfColliding(_player, collectable, collectCollectable, [collectable]);
		}

		private function applyFunctionIfColliding(entity1:IEntityModel, entity2:IEntityModel, functionToApply:Function, functionArguments:Array):void {
			RectangleCollision.applyFunctionIfColliding(entity1.rectangle, entity2.rectangle, functionToApply, functionArguments);
		}

		private function processCollision(reactionary:IEntityModel, stationary:IEntityModel):void {
			var collision:Rectangle = RectangleCollision.resolve(reactionary.rectangle, stationary.rectangle);
			stopFallingIfAtop(collision);
			_player.rectangle = collision;
		}

		private function stopFallingIfAtop(collisionRectangle:Rectangle):void {
			if (collisionRectangle.y < _player.y)
				_player.stopFalling();
		}

		private function collectCollectable(collectable:CollectableModel):void {
			_counter.addPoint();
			_soundManager.playCollectSweet();
			collectable.moveBy(900, 900);// TODO: Make it invisible instead of moving it.
		}

		/**
		 * Assumes there is at least one obstacle in _obstacles, so we can know the last obstacle has been passed.
		 */
		private function checkSuccess():void {
			var lastObstacle:IObstacle = _obstacles[_obstacles.length - 1];
			if (lastObstacle.x < 0)
				enterSuccessState();
		}

		private function enterSuccessState():void {
			stopLoop();
			_gameModel.showSuccessScreen();
		}

		private function checkFailure():void {
			var playerHalfOffScreen:Boolean = _player.x < -(PlayerView.WIDTH / 2);
			if (playerHalfOffScreen)
				enterFailureState();
		}

		private function enterFailureState():void {
			stopLoop();
			_gameModel.showFailureScreen();
		}

		private function stopLoop():void {
			_gameClock.stop();
			_gameClock.removeEventListener(TimerEvent.TIMER, update);
		}
	}
}