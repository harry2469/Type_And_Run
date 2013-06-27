package com.mvc.model
{
	// Flash Imports
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	// My Imports
	import com.events.WordSlotEvent;
	import com.events.WordSlotHandlerEvent;
	
	/**
	 * Handles all Model responsibilitys of working with the WordSlots.
	 * @author Kristian Welsh
	 */
	public class WordSlotHandlerModel extends EventDispatcher
	{
		/** Number of word slots to handle. */
		private static const NUM_SLOTS:uint = 3;
		
		/** Assigned at constructor to be a list of spellable words. */
		private var _wordStrings:Vector.<String> = new Vector.<String>();
		
		/** Holds all of the indices of _wordStrings which have already been used as a spelling. */
		private var _usedIndexes:Vector.<uint> = new Vector.<uint>();
		
		/** Holds a referance to each of the WordSlots as they're created. */
		private var _wordSlots:Vector.<WordSlotModel> = new Vector.<WordSlotModel>(NUM_SLOTS);
		
		/** Holds all words that are currently being actively spelt by the player. */
		private var _latchedWordSlots:Array = [];
		
		/**
		 * Save the input vector of strings as the list of word strings to draw from
		 * @param	wordList
		 */
		public function WordSlotHandlerModel(wordList:Vector.<String>)
		{
			_wordStrings = wordList;
		}
		
		/**
		 * Set up all of the word slots with a word to spell.
		 */
		public function initWordSlots():void 
		{
			for (var i:int = 0; i < NUM_SLOTS; i++) {
				initWord(i);
				wordCreationEventTasks(i);
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
		
		/**
		 * Initialise a word slot at an index on _wordObjects.
		 * @param	index
		 */
		private function initWord(index:int):void 
		{
			createWordSlot(index);
			assignSpelling(_wordSlots[index]);
		}
		
		/**
		 * Create a new WordSlotModel at a specific index of _wordObjects.
		 * @param	index
		 */
		private function createWordSlot(index:int):void 
		{
			_wordSlots[index] = new WordSlotModel();
		}
		
		/**
		 * Assign a WordSlotModel a random word to spell.
		 * @param	WordSlotModel
		 */
		private function assignSpelling(wordSlot:WordSlotModel):void
		{
			wordSlot.wordToSpell = extractRandomWordString();
		}
		
		/**
		 * Return a random unused string from the wordStrings array.
		 * @return	random unused string from the wordStrings array.
		 * @throws	Error if all spellable words have already been used.
		 */
		private function extractRandomWordString():String {
			if (_usedIndexes.length == _wordStrings.length) throw new Error("You have used every spellable word.", 1);
			
			var acceptableInt:int = NaN;
			while(_usedIndexes.indexOf(acceptableInt) != -1) {
				acceptableInt = randomIntBetweenBounds(0, _wordStrings.length - 1)
			} 
			
			_usedIndexes.push(acceptableInt)
			return _wordStrings[acceptableInt];
		}
		
		/**
		 * Deal with all the event tasks that need to occur as a Word Slot is created on _wordObjects.
		 * @param	index:int
		 */
		private function wordCreationEventTasks(index:int):void 
		{
			_wordSlots[index].addEventListener(WordSlotEvent.FINISH, changeWord);
			dispatchEvent(new WordSlotHandlerEvent(WordSlotHandlerEvent.CREATE, _wordSlots[index], new Point(100, index * 30 + 100)));
		}
		
		/**
		 * Pick a new string for a finished word.
		 * @param	e:WordSlotEvent
		 */
		private function changeWord(e:WordSlotEvent):void 
		{
			assignSpelling(e.target as WordSlotModel);
			_latchedWordSlots = []; // reset 
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
		
		/**
		 * Return a random integer between bounds.
		 * @param	lowerBound
		 * @param	upperBound
		 * @return	random int between the lower and upper bounds.
		 */
		private function randomIntBetweenBounds(lowerBound:int, upperBound:int):int {
			return Math.floor(Math.random() * (upperBound - lowerBound + 1) + lowerBound)
		}
		
	}

}