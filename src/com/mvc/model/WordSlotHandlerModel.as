package com.mvc.model
{
	// Flash Imports
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import org.flashdevelop.utils.FlashConnect;
	
	// My Imports
	import com.events.WordSlotEvent;
	import com.events.WordSlotHandlerEvent;
	
	/**
	 * Handles all Model responsibilitys of working with the WordSlots.
	 * @author Kristian Welsh
	 */
	public class WordSlotHandlerModel extends EventDispatcher implements IWordSlotHandlerModel
	{
		// TODO: encapsulate the requirements and assumptions for _wordStrings into its own class.
		// TODO: encapsulate the requirements and assumptions for _wordSlots into its own class.
		// TODO: randomise inputted strings before they go in to avoid need for non-determinstic random number generation.
		// TODO: investigate
		
		/** Number of word slots to handle. */
		public static const NUM_SLOTS:uint = 3;
		
		/** Assigned at constructor to be a list of spellable words. */
		private var _wordStrings:Vector.<String>;
		
		/** Holds a referance to each of the WordSlots as they're created. */
		private var _wordSlots:Vector.<IWordSlotModel>;
		
		/** Holds all words that are currently being actively spelt by the player. */
		private var _latchedWordSlots:Array;
		
		/** The current index you are at in the _wordStrings array. */
		private var _listProgress:uint = 0;
		
		// PUBLIC FUNCTIONS
		
		/**
		 * Set the initial values of all variables.
		 * @param	wordList
		 * @param	usedIndexes
		 * @param	wordSlots
		 * @param	latchedWordSlots
		 */
		public function WordSlotHandlerModel(wordList:Vector.<String>, wordSlots:Vector.<IWordSlotModel>, latchedWordSlots:Array):void
		{
			if (wordList.length < NUM_SLOTS) throw new Error("The passed in wordList Vector needs to contain at least " + NUM_SLOTS + " strings.", 3);
			if (wordSlots.length < NUM_SLOTS) throw new Error("The passed in wordSlots Vector needs to contain at least " + NUM_SLOTS + " WordSlotModels.", 4);
			
			_wordStrings = wordList;
			_wordSlots = wordSlots;
			_latchedWordSlots = latchedWordSlots;
		}
		
		/**
		 * Destroys the object in a clean and memory concious fashion.
		 */
		public function destroy():void
		{
			for (var i:int = 0; i < _wordSlots.length; ++i)
			{
				if (_wordSlots[i].hasEventListener(WordSlotEvent.FINISH)){
					_wordSlots[i].removeEventListener(WordSlotEvent.FINISH, changeWord);
				}
			}
			_wordStrings = null;
			_wordSlots = null;
			_latchedWordSlots = null;
		}
		
		/**
		 * Set up all the word slots and give each a word to spell.
		 * @param	wordSlotModelTemplate
		 */
		public function initWordSlots():void
		{
			for (var i:uint = 0; i < NUM_SLOTS; i++) {
				initializeWordSlotAtIndex(i);
			}
		}
		
		/**
		 * Deal with an input character.
		 * @param	charCode:uint
		 */
		public function acceptInput(charCode:uint):void
		{
			latchValidWords(charCode);
			advanceLatchedWords(charCode);
		}
		
		override public function toString():String
		{
			return "[WordSlotHandlerModel]";
		}
		
		// PRIVATE FUNCITONS
		
		/**
		 * Deal with all the event tasks that need to occur as a Word Slot is created on _wordObjects.
		 * @param	index:int
		 */
		private function initializeWordSlotAtIndex(index:int):void
		{
			assignSpelling(_wordSlots[index]);
			_wordSlots[index].addEventListener(WordSlotEvent.FINISH, changeWord);
			dispatchEvent(new WordSlotHandlerEvent(WordSlotHandlerEvent.CREATE, _wordSlots[index]));
		}
		
		/**
		 * Give an IWordSlotModel the next word to spell.
		 * @param	IWordSlotModel
		 */
		private function assignSpelling(wordSlot:IWordSlotModel):void
		{
			wordSlot.wordToSpell = returnNextWord()
		}
		
		/**
		 * Get the next string to use.
		 * @return	Next word in the _wordStrings Vector
		 */
		private function returnNextWord():String
		{
			if (_listProgress < _wordStrings.length) {
				_listProgress++;
			} else {
				_listProgress = 0;
			}
			return _wordStrings[_listProgress];
		}
		
		/**
		 * Pick a new string for a finished word.
		 * @param	e:WordSlotEvent
		 */
		private function changeWord(e:WordSlotEvent):void
		{
			assignSpelling(e.target as IWordSlotModel);
			_latchedWordSlots = [];
		}
		
		/**
		 * Decide which word(s) to latch onto based on the validity of the input character for each of the active words.
		 * @param	inputChar:uint
		 */
		private function latchValidWords(inputChar:uint):void
		{
			if (_latchedWordSlots.length != 0) return;
			for (var i:int = 0; i < NUM_SLOTS; i++)
			{
				if (_wordSlots[i].isNextCharacterCode(inputChar)) {
					_latchedWordSlots.push(_wordSlots[i]);
				}
			}
		}
		
		/**
		 * Advance progress on all latched words.
		 * @param	inputChar:uint
		 */
		private function advanceLatchedWords(inputChar:uint):void
		{
			for (var i:int = _latchedWordSlots.length-1; i >= 0; --i)
			{
				if (!_latchedWordSlots[i].isNextCharacterCode(inputChar)) {
					unlatchIndex(i);
				} else {
					_latchedWordSlots[i].advanceWord(inputChar)
				}
			}
		}
		
		/**
		 * Cleanly reset and remove element at index on _latchedWordSlots.
		 * @param	index
		 */
		private function unlatchIndex(index:int):void
		{
			_latchedWordSlots[index].resetWord();
			_latchedWordSlots.splice(index, 1);
		}
	}
}