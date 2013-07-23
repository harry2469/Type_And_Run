package com.mvc.model
{
	import com.events.WordCompleteEvent;
	import com.mvc.model.words.IWordSlotHandlerModel;
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.model.words.WordSlotHandlerModel;
	import com.mvc.model.words.WordSlotModel;
	import flash.events.EventDispatcher;
	import kris.Util;
	
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class GameModel extends EventDispatcher
	{
		public static const NUMBER_OF_WORD_SLOTS_TO_CREATE:int = 3
		
		private var _wordSlotHandler:IWordSlotHandlerModel;
		private var _player:PlayerModel;
		
		// PUBLIC
		
		public function GameModel():void
		{
			_wordSlotHandler = createWordSlotModelSystem();
			_player = new PlayerModel(50, 100, _wordSlotHandler);
		}
		
		public function startAplication():void
		{
			_wordSlotHandler.initWordSlots();
		}
		
		public function get wordSlotHandler():IWordSlotHandlerModel
		{
			return _wordSlotHandler;
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
			var wordsToSpell:Vector.<String> = Vector.<String>(["foo", "cat", "dog", "watch", "wallet", "phone", "mane", "main"]);
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