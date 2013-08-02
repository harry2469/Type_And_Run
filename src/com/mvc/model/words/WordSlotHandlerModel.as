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
		
		private var _latchedWordSlots:WordSlotLatcher;
		
		/**
		 * The current index you are at in the _wordStrings array.
		 * This starts at -1 so that when you want a new word
		 * you can increase it then use it immediately.
		 */
		private var _spellingListProgress:int = -1;
		
		// Getters and setters
		
		private function get nextSpelling():String
		{//#
			return _wordStrings[_spellingListProgress];
		}
		
		// PUBLIC
		
		/**
		 * Set the initial values of all dependencies.
		 * @param List of word spellings to assign.
		 * @param List of word slots to handle.
		 * @param List of word slots that are currently being correctly spelled by the user.
		 */
		public function WordSlotHandlerModel(wordList:Vector.<String>, wordSlots:Vector.<IWordSlotModel>, latchedWordSlots:WordSlotLatcher):void
		{
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
		{
			for (var i:int = 0; i < _wordSlots.length; ++i)
			{
				_wordSlots[i].removeEventListener(WordSlotEvent.FINISH, onWordFinish);
			}
		}
		
		/** Set up all the word slots and give each a word to spell. */
		public function initWordSlots():void
		{
			for (var i:int = 0; i < _wordSlots.length; i++) {
				initWordSlotAtIndex(i);
			}
		}
		
		public function acceptInput(charCode:int):void
		{
			_latchedWordSlots.acceptInput(charCode);
		}
		
		// PRIVATE
		
		private function initWordSlotAtIndex(index:int):void
		{
			giveWordNewSpelling(_wordSlots[index]);
			_wordSlots[index].addEventListener(WordSlotEvent.FINISH, onWordFinish);
			dispatchEvent(new WordSlotHandlerEvent(WordSlotHandlerEvent.CREATE, _wordSlots[index]));
		}
		
		private function onWordFinish(e:WordSlotEvent):void
		{
			giveWordNewSpelling(e.target as IWordSlotModel);
			_latchedWordSlots.unlatchAll();
			dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
		}
		
		private function giveWordNewSpelling(wordSlot:IWordSlotModel):void
		{
			wordSlot.wordToSpell = consumeSpelling();
		}
		
		/**
		 * Advances to the next spelling, returning that new spelling.
		 * @return first available spelling from the list
		 */
		private function consumeSpelling():String
		{
			do {
				_spellingListProgress++;
				if (_spellingListProgress >= _wordStrings.length) _spellingListProgress = 0;
			} while (isWordInUse(nextSpelling));
			return nextSpelling;
		}
		
		private function isWordInUse(word:String):Boolean
		{
			for (var i:int = 0; i < _wordSlots.length; ++i)
			{
				if (_wordSlots[i].wordToSpell == word) return true;
			}
			return false;
		}
	}
}