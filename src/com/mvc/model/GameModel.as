package com.mvc.model {
	import com.mvc.model.words.*;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import kris.RectangleCollision;
	import kris.Util;
	
	/**
	 * Contains the bulk of the logic
	 * @author Kristian Welsh
	 */
	public class GameModel extends EventDispatcher {
		public static const NUMBER_OF_WORD_SLOTS_TO_CREATE:int = 3
		
		private var _wordSlotHandler:IWordSlotHandlerModel;
		private var _player:PlayerModel;
		private var _obstacle:ObstacleModel;
		private var _timer:Timer;
		private var _wordSlots:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
		private var _wordSlotLatcher:IWordSlotLatcher;
		
		public function get wordSlotLatcher():IWordSlotLatcher {
			return _wordSlotLatcher;
		}
		public function get obstacle():ObstacleModel {
			return _obstacle;
		}
		public function get player():PlayerModel {
			return _player;
		}
		
		public function getWordSlotAt(i:int):IWordSlotModel {
			return _wordSlots[i];
		}
		
		public function GameModel():void {
			createWordSystem();
			_player = new PlayerModel(400, 400, 53, 53, _wordSlotHandler);
			
			_obstacle = new ObstacleModel(_player.x + 80, _player.y + 13, 43, 41);
			
			_timer = new Timer(10);
			_timer.addEventListener(TimerEvent.TIMER, tock);
		}
		
		/** Creates _wordSlotHandler, _wordSlotLatcher, and their dependancies. */
		private function createWordSystem():void {
			var wordsToSpell:Vector.<String> = scrambleWords(["qq", "ww", "ee", "rr", "tt", "yy", "uu"]);
			populateWordSlots();
			
			_wordSlotHandler = new WordSlotHandlerModel(wordsToSpell, _wordSlots);
			_wordSlotLatcher = new WordSlotLatcher(_wordSlotHandler);
		}
		
		private function scrambleWords(array:Array):Vector.<String> {
			return Util.scrambleStringVector(Vector.<String>(array));
		}
		
		private function populateWordSlots():void {
			for (var i:int = 0; i < NUMBER_OF_WORD_SLOTS_TO_CREATE; i++)
				_wordSlots.push(new WordSlotModel());
		}
		
		private function tock(e:TimerEvent):void {
			advanceObstacles();
			_player.fallIfFalling();
			processPossibleCollissionBetween(_player, _obstacle);
		}
		
		private function advanceObstacles():void {
			_obstacle.moveBy(-1, 0);
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
		
		public function startGame():void {
			_wordSlotHandler.initWordSlots();
			_timer.start();
		}
	}
}