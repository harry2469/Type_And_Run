package com.mvc.model {
	import com.mvc.model.words.*;
	import flash.events.*;
	import kris.Util;
	
	/** @author Kristian Welsh */
	public class GameModel extends EventDispatcher {
		public static const NUMBER_OF_WORD_SLOTS:int = 3
		
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
			_wordsToSpell = scrambleWords(["qqq", "www", "eee", "rrr", "ttt", "yyy"]); // XML me
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
		 * Single Responsibility Principle violation, seperate the
		 * game loop to a new class
		 */
		public function startGame():void {
			assignSpellings();
			_wordSlotListener.listen();
			var gameLoop:GameLoop = new GameLoop(_player, _ground, _obstacles, _collectables);
		}
		
		private function assignSpellings():void {
			for (var i:int = 0; i < _wordSlots.length; ++i)
				_wordSlots[i].wordToSpell = _wordsToSpell[i]
		}
	}
}