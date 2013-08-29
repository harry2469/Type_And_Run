package com.mvc.model {
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import kris.RectangleCollision;
	
	/** @author Kristian Welsh */
	public class GameLoop {
		static private const LOOP_FREQUENCY:Number = 10;
		
		private var _player:PlayerModel;
		private var _ground:EntityModel;
		private var _obstacles:Vector.<ObstacleModel>;
		private var _collectables:Vector.<CollectableModel>;
		
		public function GameLoop(player:PlayerModel, ground:EntityModel, obstacles:Vector.<ObstacleModel>, collectables:Vector.<CollectableModel>) {
			_player = player;
			_ground = ground;
			_obstacles = obstacles;
			_collectables = collectables;
		}
		
		public function start():void {
			var timer:Timer = new Timer(LOOP_FREQUENCY);
			timer.addEventListener(TimerEvent.TIMER, tock);
			timer.start();
		}
		
		private function tock(event:TimerEvent):void {
			moveLevel();
			movePlayer();
			processCollisions();
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
			for each (var obstacle:ObstacleModel in _obstacles)
				applyFunctionIfColliding(_player, obstacle, processCollision, [_player, obstacle]);
		}
		
		private function processCollectableCollisions():void {
			for each (var collectable:CollectableModel in _collectables)
				applyFunctionIfColliding(_player, collectable, collectCollectable, [collectable]);
		}
		
		private function applyFunctionIfColliding(entity1:EntityModel, entity2:EntityModel, functionToApply:Function, functionArguments:Array):void {
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
			// TODO: collect a collectable
			collectable.moveBy(900, 900);
		}
	}
}