package com
{
	import com.mvc.controller.InputOpperator;
	import com.mvc.model.IWordSlotHandlerModel;
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
	import flash.geom.Point;
	import flash.text.TextFormat;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * Creates all the objects.
	 * @author Kristian Welsh
	 */
	public class DependancyInjector
	{
		private const NUMBER_OF_WORD_SLOTS_TO_CREATE:uint = 3
		
		/** List of words to spell. */
		private var _wordsToSpell:Vector.<String>;
		
		/** Handles player input */
		private var _inputOperator:InputOpperator;
		
		/** Handles all view responsibilities for the game */
		private var _gameView:GameView;
		
		/** Handles all model responsibilities related to handling the word slots. */
		private var _handlerModel:IWordSlotHandlerModel;
		
		private var _wordSlots:Vector.<IWordSlotModel>;
		
		private var _latchedWordSlots:Vector.<IWordSlotModel>;
		
		private var _wordSlotHandlerView:WordSlotHandlerView;
		
		private var _wordObjects:Vector.<IWordSlotView>;
		
		public function DependancyInjector(stage:Stage)
		{
			createWordSlotModelSystem();
			
			_wordObjects = createWordSlotViewVector(stage);
			_wordSlotHandlerView = new WordSlotHandlerView(stage, _handlerModel, _wordObjects);
			
			_gameView = new GameView(_wordSlotHandlerView);
			
			_inputOperator = new InputOpperator(stage, _handlerModel);
		}
		
		private function createWordSlotModelSystem():void
		{
			_wordsToSpell = Vector.<String>(["foo", "cat", "dog", "watch", "wallet", "phone", "mane", "main"]);
			scramble(_wordsToSpell);
			_latchedWordSlots = new Vector.<IWordSlotModel>();
			_wordSlots = createWordSlotModelVector();
			_handlerModel = new WordSlotHandlerModel(_wordsToSpell, _wordSlots, _latchedWordSlots);
		}
		
		public static function scramble(wordList:Vector.<String>):void
		{
			var tempHolder:String;
			var randomNum:uint;
			for (var i:uint = 0; i < wordList.length-1; ++i) {
				randomNum = randomIntBetweenBounds(i + 1, wordList.length-1);
				tempHolder = wordList[randomNum];
				wordList[randomNum] = wordList[i];
				wordList[i] = tempHolder;
			}
		}
		
		/**
		 * Return a random integer between bounds.
		 * @param	lowerBound
		 * @param	upperBound
		 * @return	random int between the lower and upper bounds.
		 */
		private static function randomIntBetweenBounds(lowerBound:int, upperBound:int):int {
			return Math.floor(Math.random() * (upperBound - lowerBound + 1) + lowerBound);
		}
		
		private function createWordSlotModelVector():Vector.<IWordSlotModel>
		{
			var wordObjects:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
			for (var i:int = 0; i < NUMBER_OF_WORD_SLOTS_TO_CREATE; i++)
			{
				wordObjects.push(createWordSlotModel());
			}
			return wordObjects;
		}
		
		private function createWordSlotModel():IWordSlotModel
		{
			return new WordSlotModel();
		}
		
		private function createWordSlotViewVector(stage:Stage):Vector.<IWordSlotView>
		{
			var wordObjects:Vector.<IWordSlotView> = new Vector.<IWordSlotView>();
			FlashConnect.trace(_wordSlots);
			for (var i:uint = 0; i < _wordSlots.length; i++)
			{
				wordObjects.push(createWordSlotView(stage, i));
			}
			return wordObjects;
		}
		
		private function createWordSlotView(stage:Stage, i:uint):IWordSlotView
		{
			return new WordSlotView(new LettersToSpell(), new LettersSpelt(), new Point(100, (i * 30) + 100), new TextFormat(), new TextFormat());
		}
		
		public function toString():String
		{
			return "[DependancyInjector handlerModel=" + handlerModel + "]";
		}
		
		public function get handlerModel():IWordSlotHandlerModel
		{
			return _handlerModel;
		}
	}
}