package com.mvc.model {
	import com.mvc.model.entities.CollectableModel;
	import com.mvc.model.entities.ObstacleModel;
	import com.mvc.model.entities.PlayerModel;
	import com.mvc.model.words.IWordSlotLatcher;
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.model.words.WordSlotLatcher;
	import com.mvc.model.words.WordSlotListener;
	import com.mvc.model.words.WordSlotModel;
	import flash.events.EventDispatcher;
	import kris.Util;
	
	/** @author Kristian Welsh */
	public class GameModel extends EventDispatcher {
		public static const NUMBER_OF_WORD_SLOTS:int = 3
		
		private var _wordsToSpell:Vector.<String>;
		private var _wordSlots:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
		private var _wordSlotLatcher:IWordSlotLatcher;
		private var _wordSlotListener:WordSlotListener;
		
		private var _player:PlayerModel;
		private var _ground:ObstacleModel;
		private var _obstacles:Vector.<ObstacleModel> = new Vector.<ObstacleModel>();
		private var _collectables:Vector.<CollectableModel> = new Vector.<CollectableModel>();
		
		private var _gameLoop:GameLoop;
		
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
		
		public function get obstacles():Vector.<ObstacleModel> {
			return _obstacles;
		}
		
		public function get collectables():Vector.<CollectableModel> {
			return _collectables;
		}
		
		public function getCollectableAt(index:uint):CollectableModel {
			return _collectables[index];
		}
		
		public function GameModel(spellingData:Vector.<String>, obstacleData:Array, collectableData:Array):void {
			_wordsToSpell = Util.scrambleStringVector(spellingData);
			populateEntityList(_obstacles, obstacleData, ObstacleModel);
			populateEntityList(_collectables, collectableData, CollectableModel);
			
			populateWordSlots();
			
			_wordSlotListener = new WordSlotListener(_wordsToSpell, _wordSlots);
			_wordSlotLatcher = new WordSlotLatcher(_wordSlots, _wordSlotListener, new Vector.<IWordSlotModel>());
			_player = new PlayerModel(400, 400, 53, 53, _wordSlotListener);
			_ground = new ObstacleModel(0, _player.y + 53, 800, 500);
			_gameLoop = new GameLoop(_player, _ground, _obstacles, _collectables);
		}
		
		private function populateEntityList(list:*, data:Array, objectType:Class):void {
			for (var i:int = 0; i < data.length; i++)
				list.push(new objectType(data[i][0], data[i][1], data[i][2], data[i][3]));
		}
		
		private function populateWordSlots():void {
			for (var i:int = 0; i < NUMBER_OF_WORD_SLOTS; i++)
				_wordSlots.push(new WordSlotModel());
		}
		
		/**
		 * Seperate function to start the game.
		 * This exists because the model needs to be created first so that the view and controller
		 * can referance it, but the view and controller need to have been set up before these
		 * functions are called or else the views can't pass the component's properties through the event system.
		 */
		public function startGame():void {
			assignSpellings();
			_wordSlotListener.listen();
			_gameLoop.start();
		}
		
		private function assignSpellings():void {
			for (var i:int = 0; i < _wordSlots.length; ++i)
				_wordSlots[i].wordToSpell = _wordsToSpell[i]
		}
	}
}