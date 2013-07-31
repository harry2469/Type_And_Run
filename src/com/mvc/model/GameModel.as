package com.mvc.model
{
	import com.mvc.model.words.IWordSlotHandlerModel;
	import com.mvc.model.words.IWordSlotModel;
	import flash.events.EventDispatcher;
	import com.mvc.model.words.WordSlotHandlerModel;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import kris.Util;
	import com.mvc.model.words.WordSlotModel;
	import com.events.WordCompleteEvent;
	
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class GameModel extends EventDispatcher
	{
		public static const NUMBER_OF_WORD_SLOTS_TO_CREATE:int = 3
		
		private var _wordSlotHandler:IWordSlotHandlerModel;
		private var _player:PlayerModel;
		
		private var _obstacle:ObstacleModel;
		private var _timer:Timer;
		
		// PUBLIC
		
		public function GameModel():void
		{
			_wordSlotHandler = createWordSlotModelSystem();
			_player = new PlayerModel(800/2-20, 600/2-75, 40, 75, _wordSlotHandler);
			
			_obstacle = new ObstacleModel(600, 600/2-30, 30, 30);
			
			_timer = new Timer(100);
			_timer.addEventListener(TimerEvent.TIMER, tock);
		}
		
		private function tock(e:TimerEvent):void
		{
			_obstacle.moveBy( -5, 0);
		}
		
		public function startAplication():void
		{
			_wordSlotHandler.initWordSlots();
		}
		
		public function get wordSlotHandler():IWordSlotHandlerModel
		{
			return _wordSlotHandler;
		}
		
		public function get obstacle():ObstacleModel
		{
			return _obstacle;
		}
		
		public function get player():PlayerModel
		{
			return _player;
		}
		
		// PRIVATE
		
		/**
		 * Builds WordSlotHandlerModel and injects its dependancies.
		 * @return WordSlotHandlerModel
		 */
		private function createWordSlotModelSystem():WordSlotHandlerModel
		{
			var wordsToSpell:Vector.<String> = Vector.<String>(["aaaa", "bbbb", "cccc", "dddd", "eeee", "ffff", "gggg", "hhhh"]);
			wordsToSpell = Util.scrambleStringVector(wordsToSpell);
			var wordSlots:Vector.<IWordSlotModel> = createWordSlotModelVector();
			var latchedWordSlots:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
			return new WordSlotHandlerModel(wordsToSpell, wordSlots, latchedWordSlots);
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