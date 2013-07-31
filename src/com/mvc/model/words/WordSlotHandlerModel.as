package com.mvc.model.words
{
	// Flash Imports
	import com.events.WordCompleteEvent;
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
	public class WordSlotHandlerModel extends EventDispatcher implements IWordSlotHandlerModel
	{
		// TODO: merge _wordStrings and _wordSlots somehow?
		
		// Variables
		
		/** Scrambled list of spellable words. */
		private var _wordStrings:Vector.<String>;
		
		/** List of all the word slot models this object is handling. */
		private var _wordSlots:Vector.<IWordSlotModel>;
		
		/** List of words the player is currently spelling correctly. */
		private var _latchedWordSlots:Vector.<IWordSlotModel>;
		
		/**
		 * The current index you are at in the _wordStrings array.
		 * This starts at -1 so that when you want a new word
		 * you can increase it then use it immediately.
		 */
		private var _spellingListProgress:int = -1;
		
		// Getters and setters
		
		private function get nextSpelling():String
		{//#~
			return _wordStrings[_spellingListProgress];
		}
		
		// PUBLIC
		
		/**
		 * Set the initial values of all dependencies.
		 * @param List of word spellings to assign.
		 * @param List of word slots to handle.
		 * @param List of word slots that are currently being correctly spelled by the user.
		 */
		public function WordSlotHandlerModel(wordList:Vector.<String>, wordSlots:Vector.<IWordSlotModel>, latchedWordSlots:Vector.<IWordSlotModel>):void
		{//#~
			if (!(wordList.length > wordSlots.length))
			{
				throw new Error("The passed in wordList Vector needs to be longer than the wordSlots Vector.", 3);
			}
			
			_wordStrings = wordList;
			_wordSlots = wordSlots;
			_latchedWordSlots = latchedWordSlots;
		}
		
		/** Destroys the object in a clean and memory concious fashion. */
		public function destroy():void
		{//#
			removeAllListeners();
		}
		
		/** Set up all the word slots and give each a word to spell. */
		public function initWordSlots():void
		{//##
			for (var i:int = 0; i < _wordSlots.length; i++) {
				initWordSlotAtIndex(i);
			}
		}
		
		/**
		 * Send advance and reset messages to the valid wordslots for the input character.
		 * @param Character code of the key parse
		 */
		public function acceptInput(charCode:int):void
		{//~~
			latchValidWords(charCode);
			advanceAllLatchedWords(charCode);
		}
		
		// PRIVATE
		
		private function initWordSlotAtIndex(index:int):void
		{//#
			giveWordNewSpelling(_wordSlots[index]);
			_wordSlots[index].addEventListener(WordSlotEvent.FINISH, onWordFinish);
			dispatchEvent(new WordSlotHandlerEvent(WordSlotHandlerEvent.CREATE, _wordSlots[index]));
		}
		
		private function giveWordNewSpelling(wordSlot:IWordSlotModel):void
		{//#
			wordSlot.wordToSpell = consumeSpelling();
		}
		
		/**
		 * Advances to the next spelling then returns that new spelling.
		 * Also advances state past the next spelling,
		 * @return first available spelling from the list
		 */
		private function consumeSpelling():String
		{//#
			advanceToNextSpelling();
			return nextSpelling;
		}
		
		private function advanceToNextSpelling():void
		{//#
			do {
				_spellingListProgress++;
				if (_spellingListProgress >= _wordStrings.length) _spellingListProgress = 0;
			} while (isWordInUse(nextSpelling));
		}
		
		private function isWordInUse(word:String):Boolean
		{//#
			for (var i:int = 0; i < _wordSlots.length; ++i)
			{
				if (_wordSlots[i].wordToSpell == word) return true;
			}
			return false;
		}
		
		private function onWordFinish(e:WordSlotEvent):void
		{//#
			giveWordNewSpelling(e.target as IWordSlotModel);
			_latchedWordSlots.length = 0;
			dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
		}
		
		private function removeAllListeners():void
		{//#
			for (var i:int = 0; i < _wordSlots.length; ++i)
			{
				_wordSlots[i].removeEventListener(WordSlotEvent.FINISH, onWordFinish);
			}
		}
		
		private function latchValidWords(inputChar:int):void
		{//~
			if (_latchedWordSlots.length != 0) return;
			for (var i:int = 0; i < _wordSlots.length; i++)
			{
				if (_wordSlots[i].isNextCharacterCode(inputChar)) {
					_latchedWordSlots.push(_wordSlots[i]);
				}
			}
		}
		
		private function advanceAllLatchedWords(inputChar:int):void
		{//~
			for (var i:int = _latchedWordSlots.length-1; i >= 0; --i)
			{
				if (!_latchedWordSlots[i].isNextCharacterCode(inputChar)) {
					unlatchIndex(i);
				} else {
					_latchedWordSlots[i].advanceWord(inputChar);
				}
			}
		}
		
		/**
		 * Cleanly reset and remove element at index on _latchedWordSlots.
		 * @param	index
		 */
		private function unlatchIndex(index:int):void
		{//~
			_latchedWordSlots[index].resetWord();
			_latchedWordSlots.splice(index, 1);
		}
	}
}