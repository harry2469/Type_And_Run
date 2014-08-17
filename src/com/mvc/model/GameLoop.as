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

	/** @author Kristian Welsh */
	public class GameLoop {
		static private const LOOP_FREQUENCY:Number = 10;

		private var _player:IPlayer;
		private var _ground:IEntityModel;
		private var _obstacles:Vector.<IObstacle>;
		private var _collectables:Vector.<ICollectable>;
		private var _counter:IPointsCounter;
		private var _timer:Timer;
		private var _gameModel:GameModel;
		private var _soundManager:ISoundManager;

		public function GameLoop(player:IPlayer, ground:IObstacle, obstacles:Vector.<IObstacle>, collectables:Vector.<ICollectable>, counter:IPointsCounter, soundManager:ISoundManager) {
			_soundManager = soundManager;
			_player = player;
			_ground = ground;
			_obstacles = obstacles;
			_collectables = collectables;
			_counter = counter;
		}

		public function start(gameModel:GameModel):void {
			_gameModel = gameModel;
			_timer = new Timer(LOOP_FREQUENCY);
			_timer.addEventListener(TimerEvent.TIMER, tock);
			_timer.start();
		}

		private function tock(event:TimerEvent):void {
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
			for each (var item:EntityModel in list)
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

		private function processCollision(reactionary:EntityModel, stationary:EntityModel):void {
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

		private function checkSuccess():void {
			if (_obstacles[_obstacles.length - 1].x < 0)
				enterSuccessState();
		}

		private function enterSuccessState():void {
			stopLoop();
			_gameModel.showSuccessScreen();
		}

		private function checkFailure():void {
			if (_player.x < -(PlayerView.WIDTH / 2))
				enterFailureState();
		}

		private function enterFailureState():void {
			stopLoop();
			_gameModel.showFailureScreen();
		}

		private function stopLoop():void {
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, tock);
		}
	}
}