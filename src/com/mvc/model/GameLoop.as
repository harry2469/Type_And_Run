package com.mvc.model {
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import kris.RectangleCollision;
	
	/** @author Kristian Welsh */
	public class GameLoop {
		private var _collectables:Vector.<CollectableModel>;
		private var _obstacles:Vector.<ObstacleModel>;
		private var _player:PlayerModel;
		private var _ground:EntityModel;
		
		public function GameLoop(player:PlayerModel, ground:EntityModel, obstacles:Vector.<ObstacleModel>, collectables:Vector.<CollectableModel>) {
			_player = player;
			_ground = ground;
			_obstacles = obstacles;
			_collectables = collectables;
			var timer:Timer = new Timer(10);
			timer.addEventListener(TimerEvent.TIMER, tock);
			timer.start();
		}
		
		private function tock(event:TimerEvent):void {
			moveLevel();
			movePlayer();
			processCollissions();
		}
		
		private function moveLevel():void {
			moveEntitysInListByAmount(_obstacles, -ObstacleModel.SPEED, 0);
			moveEntitysInListByAmount(_collectables, -ObstacleModel.SPEED, 0);
		}
		
		private function movePlayer():void {
			advancePlayerIfBehind();
			_player.fallIfFalling();
		}
		
		private function processCollissions():void {
			processObstacleCollisions();
			processCollectableCollisions();
			applyFunctionIfColliding(_player, _ground, processCollision, [_player, _ground]);
		}
		
		private function moveEntitysInListByAmount(list:*, xAmount:Number, yAmount:Number):void {
			for each (var item:EntityModel in list)
				item.moveBy(xAmount, yAmount);
		}
		
		private function advancePlayerIfBehind():void {
			_player.advanceIfLeftOf(400);
		}
		
		private function processObstacleCollisions():void {
			if (!_player.falling)
				for each (var obstacle:ObstacleModel in _obstacles)
					processPlayerCollission(obstacle);
		}
		
		private function processCollectableCollisions():void {
			for each (var collectable:CollectableModel in _collectables)
				applyFunctionIfColliding(_player, collectable, collectCollectable, [collectable]);
		}
		
		private function collectCollectable(collectable:CollectableModel):void {
			// TODO: collect a collectable
			collectable.moveBy(900, 900);
		}
		
		private function processPlayerCollission(stationary:EntityModel):void {
			applyFunctionIfColliding(_player, stationary, processCollision, [_player, stationary]);
		}
		
		private function applyFunctionIfColliding(entity1:EntityModel, entity2:EntityModel, functionToApply:Function, functionArguments:Array):void {
			if (RectangleCollision.detect(entity1.rectangle, entity2.rectangle))
				functionToApply.apply(null, functionArguments);
		}
		
		private function processCollision(reactionary:EntityModel, stationary:EntityModel):void {
			var collision:Rectangle = RectangleCollision.collide(reactionary.rectangle, stationary.rectangle);
			stopFallingIfAtop(collision);
			_player.rectangle = collision;
		}
		
		private function stopFallingIfAtop(collisionRectangle:Rectangle):void {
			if (collisionRectangle.y < _player.y)
				_player.stopFalling();
		}
	}
}