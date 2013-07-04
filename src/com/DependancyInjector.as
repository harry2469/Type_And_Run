package com
{
	import com.mvc.controller.InputOpperator;
	import com.mvc.model.IWordSlotModel;
	import com.mvc.model.WordSlotHandlerModel;
	import com.mvc.view.GameView;
	import com.mvc.view.word.IWordSlotView;
	import com.mvc.view.word.WordSlotView;
	import com.mvc.view.WordSlotHandlerView;
	import flash.display.Stage;
	
	/**
	 * Creates all the objects.
	 * @author Kristian Welsh
	 */
	public class DependancyInjector
	{
		/** List of words to spell. */
		private var _wordsToSpell:Vector.<String>;
		
		/** Handles player input */
		private var _inputOperator:InputOpperator;
		
		/** Handles all view responsibilities for the game */
		private var _gameView:GameView;
		
		/** Handles all model responsibilities related to handling the word slots. */
		private var _handlerModel:WordSlotHandlerModel;
		
		private var _wordSlots:Vector.<IWordSlotModel>;
		
		private var _usedIndexes:Vector.<uint>;
		
		private var _latchedWordSlots:Array;
		
		private var _wordSlotHandlerView:WordSlotHandlerView;
		
		private var _wordObjects:Vector.<IWordSlotView>;
		
		private var _wordSlotViewTemplate:WordSlotView;
		
		public function DependancyInjector(stage:Stage)
		{
			_wordsToSpell = Vector.<String>(["foo", "cat", "dog", "watch", "wallet", "phone", "mane", "main"]);
			_usedIndexes = new Vector.<uint>();
			_wordSlots = new Vector.<IWordSlotModel>();
			_latchedWordSlots = new Array();
			_handlerModel = new WordSlotHandlerModel(_wordsToSpell, _usedIndexes, _wordSlots, _latchedWordSlots);
			
			_wordObjects = new Vector.<IWordSlotView>();
			_wordSlotViewTemplate = new WordSlotView();
			_wordSlotHandlerView = new WordSlotHandlerView(stage, _handlerModel, _wordObjects, _wordSlotViewTemplate);
			
			_gameView = new GameView(_wordSlotHandlerView);
			
			_inputOperator = new InputOpperator(stage, _handlerModel);
		}
		
		public function toString():String
		{
			return "[DependancyInjector handlerModel=" + handlerModel + "]";
		}
		
		public function get handlerModel():WordSlotHandlerModel
		{
			return _handlerModel;
		}
	}
}