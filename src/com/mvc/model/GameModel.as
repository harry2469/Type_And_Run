package com.mvc.model {
	import com.events.LevelEvent;
	import com.mvc.model.entities.*;
	import com.mvc.model.words.*;
	import com.SoundManager;
	import flash.events.Event;
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
		private var _obstacles:Vector.<IObstacle> = new Vector.<IObstacle>();
		private var _collectables:Vector.<ICollectable> = new Vector.<ICollectable>();

		private var _counter:PointsCounterModel;
		private var _gameLoop:GameLoop;
		private var _soundManager:SoundManager;

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

		public function get obstacles():Vector.<IObstacle> {
			return _obstacles;
		}

		public function get collectables():Vector.<ICollectable> {
			return _collectables;
		}

		public function getCollectableAt(index:uint):ICollectable {
			return _collectables[index];
		}

		public function get counter():PointsCounterModel {
			return _counter;
		}

		public function GameModel(spellingData:Vector.<String>, obstacleData:Array, collectableData:Array, soundManager:SoundManager):void {
			_soundManager = soundManager;
			_wordsToSpell = Util.scrambleStringVector(spellingData);
			populateEntityList(_obstacles, obstacleData, ObstacleModel);
			populateEntityList(_collectables, collectableData, CollectableModel);

			populateWordSlots();
			_wordSlots[1] = new DuckWordSlot();
			_wordSlotListener = new WordSlotListener(_wordsToSpell, _wordSlots);
			_wordSlotLatcher = new WordSlotLatcher(_wordSlots, _wordSlotListener, _soundManager, new Vector.<IWordSlotModel>());
			_player = new PlayerModel(400, 400, 54, 76, _wordSlotListener, _soundManager);
			_ground = new ObstacleModel(0, _player.y + 53, 800, 500);

			_counter = new PointsCounterModel();

			_gameLoop = new GameLoop(_player, _ground, _obstacles, _collectables, _counter, _soundManager);
			_soundManager.playMenuTheme();
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
		 * This is a seperate process because the model needs to be created first so that the view and controller
		 * can referance it, but the view and controller need to have been set up before these
		 * functions are called or else the views can't respond the model's events firing.
		 */
		public function startGame():void {
			assignSpellings();
			_wordSlotListener.listen();
			_gameLoop.start(this);

			_soundManager.playLevelMusic();
		}

		public function showFailureScreen():void {
			_soundManager.playDeathSound()
			dispatchEvent(new LevelEvent(LevelEvent.LEVEL_FAILED));
		}

		public function showSuccessScreen():void {
			_soundManager.playWinSound();
			dispatchEvent(new LevelEvent(LevelEvent.LEVEL_SUCCEEDED));
		}

		private function assignSpellings():void {
			for (var i:int = 0; i < _wordSlots.length; ++i)
				_wordSlots[i].wordToSpell = _wordsToSpell[i]
		}
	}
}