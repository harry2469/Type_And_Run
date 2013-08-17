package com.mvc.model {
	import com.mvc.model.words.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import kris.RectangleCollision;
	import kris.Util;
	import org.flashdevelop.utils.FlashConnect;
	
	/** @author Kristian Welsh */
	public class GameModel extends EventDispatcher {
		public static const NUMBER_OF_WORD_SLOTS:int = 3
		
		private var _timer:Timer = new Timer(10);
		
		private var _player:PlayerModel;
		private var _ground:ObstacleModel;
		
		private var _wordsToSpell:Vector.<String>;
		private var _wordSlotLatcher:IWordSlotLatcher;
		private var _wordSlotListener:WordSlotListener;
		private var _obstacles:Vector.<ObstacleModel> = new Vector.<ObstacleModel>();
		private var _wordSlots:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
		private var _collectables:Vector.<CollectableModel> = new Vector.<CollectableModel>();
		
		public function get wordSlotLatcher():IWordSlotLatcher {
			return _wordSlotLatcher;
		}
		
		public function get player():PlayerModel {
			return _player;
		}
		
		public function get ground():ObstacleModel {
			return _ground;
		}
		
		public function getWordSlotAt(index:uint):IWordSlotModel {
			return _wordSlots[index];
		}
		
		public function getObstacleAt(index:uint):ObstacleModel {
			return _obstacles[index];
		}
		
		public function getCollectableAt(index:uint):CollectableModel {
			return _collectables[index];
		}
		
		public function GameModel():void {
			_wordsToSpell = scrambleWords(["qqq", "www", "eee", "rrr", "ttt", "yyy"]);
			createWordSlots();
			_wordSlotListener = new WordSlotListener(_wordsToSpell, _wordSlots);
			_wordSlotLatcher = new WordSlotLatcher(_wordSlots, _wordSlotListener, new Vector.<IWordSlotModel>());
			_player = new PlayerModel(400, 400, 53, 53, _wordSlotListener);
			_ground = new ObstacleModel(0, _player.y + 53, 800, 500);
			populateObstacles();
			populateCollectables();
		}
		
		private function scrambleWords(array:Array):Vector.<String> {
			return Util.scrambleStringVector(Vector.<String>(array));
		}
		
		private function createWordSlots():void {
			for (var i:int = 0; i < NUMBER_OF_WORD_SLOTS; i++)
				_wordSlots.push(new WordSlotModel());
		}
		
		private function populateObstacles():void {
			_obstacles.push(new ObstacleModel(480, 412, 43, 41)); // XML me
			_obstacles.push(new ObstacleModel(700, 412, 43, 41));
		}
		
		private function populateCollectables():void {
			_collectables.push(new CollectableModel(500, 320, 20, 9)); // XML me
		}
		
		/**
		 * Seperate function to start the game.
		 * This exists because the model needs to be created first
		 * so that the view and controller can referance it, but
		 * the view and controller need to have been set up before
		 * these functions are called or else the views can't pass
		 * the component's properties through the event system.
		 */
		public function startGame():void {
			assignSpellings();
			_wordSlotListener.listen();
			_timer.addEventListener(TimerEvent.TIMER, tock);
			_timer.start();
		}
		
		private function assignSpellings():void {
			for (var i:int = 0; i < _wordSlots.length; ++i)
				_wordSlots[i].wordToSpell = _wordsToSpell[i]
		}
		
		private function tock(e:TimerEvent):void {
			advanceObstacles();
			advanceCollectables();
			advancePlayerIfBehind();
			_player.fallIfFalling();
			processObstacleCollisions();
			processCollectableCollisions();
			processPossibleCollissionBetween(_player, _ground);
		}
		
		private function advanceObstacles():void {
			for each (var obstacle:ObstacleModel in _obstacles)
				obstacle.moveBy(-ObstacleModel.SPEED, 0);
		}
		
		private function advanceCollectables():void {
			for each (var collectable:CollectableModel in _collectables)
				collectable.moveBy(-ObstacleModel.SPEED, 0);
		}
		
		private function advancePlayerIfBehind():void {
			_player.advanceIfLeftOf(400);
		}
		
		private function processObstacleCollisions():void {
			if (!_player.falling)
				for each (var obstacle:ObstacleModel in _obstacles)
					processPossibleCollissionBetween(_player, obstacle);
		}
		
		private function processCollectableCollisions():void {
			for each (var collectable:CollectableModel in _collectables)
				if (RectangleCollision.detect(_player.rectangle, collectable.rectangle))
					collectCollectable(collectable);
		}
		
		private function collectCollectable(collectable:CollectableModel):void {
			// TODO: collect a collectable
			collectable.moveBy(900, 900);
		}
		
		private function processPossibleCollissionBetween(reactionary:EntityModel, stationary:EntityModel):void {
			var collision:Rectangle = RectangleCollision.collide(reactionary.rectangle, stationary.rectangle);
			if (!collision.equals(reactionary.rectangle))
				processCollision(collision);
		}
		
		private function processCollision(collision:Rectangle):void {
			stopFallingIfAtop(collision);
			_player.rectangle = collision;
		}
		
		private function stopFallingIfAtop(collisionRectangle:Rectangle):void {
			if (collisionRectangle.y < _player.y)
				_player.stopFalling();
		}
	}
}