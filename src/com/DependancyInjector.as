package com
{
	import com.mvc.controller.InputOpperator;
	import com.mvc.model.IWordSlotModel;
	import com.mvc.model.WordSlotHandlerModel;
	import com.mvc.model.WordSlotModel;
	import com.mvc.view.GameView;
	import com.mvc.view.word.IWordSlotView;
	import com.mvc.view.word.LettersSpelt;
	import com.mvc.view.word.LettersToSpell;
	import com.mvc.view.word.WordSlotView;
	import com.mvc.view.WordSlotHandlerView;
	import flash.display.Stage;
	import org.flashdevelop.utils.FlashConnect;
	
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
		
		public function DependancyInjector(stage:Stage)
		{
			createWordSlotModelSystem();
			
			_wordObjects = createWordSlotViewVector();
			_wordSlotHandlerView = new WordSlotHandlerView(stage, _handlerModel, _wordObjects);
			
			_gameView = new GameView(_wordSlotHandlerView);
			
			_inputOperator = new InputOpperator(stage, _handlerModel);
		}
		
		private function createWordSlotModelSystem():void
		{
			var wordsToSpell:Vector.<String> = Vector.<String>(["foo", "cat", "dog", "watch", "wallet", "phone", "mane", "main"]);
			var usedIndexes:Vector.<uint> = new Vector.<uint>();
			var latchedWordSlots:Array = new Array();
			var wordSlots:Vector.<IWordSlotModel> = createWordSlotModelVector();
			_handlerModel = new WordSlotHandlerModel(wordsToSpell, usedIndexes, wordSlots, latchedWordSlots, new WordSlotModel());
		}
		
		private function createWordSlotModelVector():Vector.<IWordSlotModel>
		{
			var wordObjects:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
			for (var i:int = 0; i < 3; i++)
			{
				wordObjects.push(createWordSlotModel());
			}
			return wordObjects;
		}
		
		private function createWordSlotModel():IWordSlotModel
		{
			return new WordSlotModel();
		}
		
		private function createWordSlotViewVector():Vector.<IWordSlotView>
		{
			var wordObjects:Vector.<IWordSlotView> = new Vector.<IWordSlotView>();
			for (var i:int = 0; i < 3; i++)
			{
				wordObjects.push(createWordSlotView());
			}
			return wordObjects;
		}
		
		private function createWordSlotView():IWordSlotView
		{
			return new WordSlotView(new LettersToSpell(), new LettersSpelt());
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