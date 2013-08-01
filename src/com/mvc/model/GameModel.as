package com.mvc.model
{
	import com.events.WordCompleteEvent;
	import com.mvc.model.words.IWordSlotHandlerModel;
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.model.words.WordSlotHandlerModel;
	import com.mvc.model.words.WordSlotModel;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import kris.Util;
	
	/**
	 * Contains the bulk of the logic
	 * @author Kristian Welsh
	 */
	public class GameModel extends EventDispatcher
	{
		public static const NUMBER_OF_WORD_SLOTS_TO_CREATE:int = 3
		
		private var _wordSlotHandler:IWordSlotHandlerModel;
		private var _player:PlayerModel;
		
		private var _obstacle:ObstacleModel;
		private var _timer:Timer;
		private var _wordSlots:Vector.<IWordSlotModel>;
		
		// PUBLIC
		
		public function get wordSlotHandler():IWordSlotHandlerModel { return _wordSlotHandler; }
		public function get obstacle():ObstacleModel { return _obstacle; }
		public function get player():PlayerModel { return _player; }
		
		public function getWordSlotAt(i:int):IWordSlotModel
		{
			return _wordSlots[i];
		}
		
		public function GameModel():void
		{
			_wordSlotHandler = createWordSlotModelSystem();
			_player = new PlayerModel(800/2-20, 600/2-75, _wordSlotHandler);
			
			_obstacle = new ObstacleModel(600, 600/2-30);
			
			_timer = new Timer(100);
			_timer.addEventListener(TimerEvent.TIMER, tock);
		}
		
		public function startAplication():void
		{
			_wordSlotHandler.initWordSlots();
		}
		
		// PRIVATE
		
		private function tock(e:TimerEvent):void
		{
			_obstacle.moveBy( -5, 0);
		}
		
		/**
		 * Builds WordSlotHandlerModel and injects its dependancies.
		 * @return WordSlotHandlerModel
		 */
		private function createWordSlotModelSystem():WordSlotHandlerModel
		{
			var wordsToSpell:Vector.<String> = Vector.<String>(["aaaaaaa", "bbbbbb", "ccccc", "dddd", "eee", "ff", "g"]);
			wordsToSpell = Util.scrambleStringVector(wordsToSpell);
			_wordSlots = createWordSlotModelVector();
			var latchedWordSlots:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
			return new WordSlotHandlerModel(wordsToSpell, _wordSlots, latchedWordSlots);
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
				wordObjects.push(new WordSlotModel() as IWordSlotModel);
			}
			return wordObjects;
		}
	}

}