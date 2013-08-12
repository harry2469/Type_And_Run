package com.mvc.model
{
	import com.mvc.model.words.IWordSlotHandlerModel;
	import com.mvc.model.words.IWordSlotLatcher;
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.model.words.WordSlotHandlerModel;
	import com.mvc.model.words.WordSlotLatcher;
	import com.mvc.model.words.WordSlotModel;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import kris.Util;
	
	/**
	 * Contains the bulk of the logic
	 * @author Kristian Welsh
	 */
	public class GameModel extends EventDispatcher
	{
		public static const NUMBER_OF_WORD_SLOTS_TO_CREATE:int = 3
		private static const STAGE_WIDTH:int = 800;
		private static const STAGE_HEIGHT:int = 600;
		
		private var _wordSlotHandler:IWordSlotHandlerModel;
		private var _player:PlayerModel;
		private var _obstacle:ObstacleModel;
		private var _timer:Timer;
		private var _wordSlots:Vector.<IWordSlotModel>;
		private var _wordSlotLatcher:IWordSlotLatcher;
		
		public function get wordSlotLatcher():IWordSlotLatcher { return _wordSlotLatcher; }
		public function get obstacle():ObstacleModel { return _obstacle; }
		public function get player():PlayerModel { return _player; }
		
		public function getWordSlotAt(i:int):IWordSlotModel
		{
			return _wordSlots[i];
		}
		
		public function GameModel():void
		{
			createWordSlotSystem();
			_player = new PlayerModel(STAGE_WIDTH/2-20, STAGE_HEIGHT/2-75, 53, 53, _wordSlotHandler);
			
			_obstacle = new ObstacleModel(_player.x + 60, _player.y - 10, 43, 41);
			
			_timer = new Timer(10);
			_timer.addEventListener(TimerEvent.TIMER, tock);
		}
		
		public function startAplication():void
		{
			_wordSlotHandler.initWordSlots();
			_timer.start();
		}
		
		private function tock(e:TimerEvent):void
		{
			_obstacle.moveBy(-1, 0);
		}
		
		/**
		 * Builds WordSlotHandlerModel and injects its dependancies.
		 * @return WordSlotHandlerModel
		 */
		private function createWordSlotSystem():void
		{
			var wordsToSpell:Vector.<String> = Vector.<String>(["qq", "ww", "ee", "rr", "tt", "yy", "uu"]);
			//wordsToSpell = Util.scrambleStringVector(wordsToSpell);
			_wordSlots = createWordSlotModelVector();
			_wordSlotHandler = new WordSlotHandlerModel(wordsToSpell, _wordSlots);
			var latchedWordSlots:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
			
			_wordSlotLatcher = new WordSlotLatcher(_wordSlotHandler, latchedWordSlots);
		}
		
		/**
		 * Populates a vector with WordSlotModels
		 * @return the vector
		 */
		private function createWordSlotModelVector():Vector.<IWordSlotModel>
		{
			var wordObjects:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
			for (var i:int = 0; i < NUMBER_OF_WORD_SLOTS_TO_CREATE; i++)
			{
				wordObjects.push(new WordSlotModel());
			}
			return wordObjects;
		}
	}

}