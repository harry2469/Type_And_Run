package com.mvc.model {
	import com.mvc.model.words.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import kris.RectangleCollision;
	import kris.Util;
	
	/** @author Kristian Welsh */
	public class GameModel extends EventDispatcher {
		public static const NUMBER_OF_WORD_SLOTS:int = 3
		
		private var _player:PlayerModel;
		private var _obstacle:ObstacleModel;
		private var _timer:Timer = new Timer(10);
		private var _wordSlots:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
		private var _wordSlotLatcher:IWordSlotLatcher;
		private var _wordSlotListener:WordSlotListener;
		private var _wordsToSpell:Vector.<String>;
		
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
			_player = new PlayerModel(400, 400, 53, 53, _wordSlotListener);
			_obstacle = new ObstacleModel(_player.x + 80, _player.y + 13, 43, 41);
		}
		
		private function createWordSystem():void {
			_wordsToSpell = scrambleWords(["qqq", "www", "eee", "rrr", "ttt", "yyy"]);
			populateWordSlots();
			
			_wordSlotListener = new WordSlotListener(_wordsToSpell, _wordSlots);
			_wordSlotLatcher = new WordSlotLatcher(_wordSlots, _wordSlotListener, new Vector.<IWordSlotModel>());
		}
		
		private function scrambleWords(array:Array):Vector.<String> {
			return Util.scrambleStringVector(Vector.<String>(array));
		}
		
		private function populateWordSlots():void {
			for (var i:int = 0; i < NUMBER_OF_WORD_SLOTS; i++)
				_wordSlots.push(new WordSlotModel());
		}
		
		/**
		 * Seperate function to start the game.
		 * This exists because the model needs to be created first
		 * so that the view and controller can referance it, but
		 * the view and controller need to have been set up before
		 * these functions are called or else the views can't get
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
	}
}