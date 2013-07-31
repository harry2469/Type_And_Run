package com.mvc.model.words
{
	import com.events.WordSlotEvent;
	import flash.events.EventDispatcher;
	import flash.display.Stage;
	
	/**
	 * Manage the display and word progression of a word form the list.
	 * @author Kristian Welsh
	 */
	public class WordSlotModel extends EventDispatcher implements IWordSlotModel
	{
		/** The word that currently needs to be spelt for this word slot */
		private var _wordToSpell:String = "";
		
		/** The index of your current progress position on the the word to spell */
		private var _pos:int = 0;
		
		// PUBLIC
		
		public function get wordToSpell():String { return _wordToSpell; }
		
		/**
		 * Changes the value of word to spell, dispatch an event to tell listeners
		 * that the value has been updated, and adjust state as appropiate.
		 * @param	input
		 */
		public function set wordToSpell(input:String):void
		{
			_wordToSpell = input;
			resetWord();
		}
		
		/**
		 * Returns true if the input character code is the character code of the next character of the word to spell, otherwise returns false.
		 * @param	inputChar
		 * @return	whether they are the same.
		 */
		public function isNextCharacterCode(inputChar:int):Boolean
		{
			return inputChar == _wordToSpell.charCodeAt(_pos);
		}
		
		/** Removes all progress in the spelling, and dispatch an event to signal this occurance. */
		public function resetWord():void
		{
			dispatchEvent(new WordSlotEvent(WordSlotEvent.CHANGE, _wordToSpell));
			_pos = 0;
		}
		
		/**
		 * If the input is valid, dispatch an ADVANCE WordSlotEvent.
		 * @param	inputChar:int
		 */
		public function advanceWord(inputChar:int):void
		{
			if (!isNextCharacterCode(inputChar)) return;
			if (isFinished()) {
				dispatchEvent(new WordSlotEvent(WordSlotEvent.FINISH));
				return;
			}
			_pos++;
			dispatchEvent(new WordSlotEvent(WordSlotEvent.ADVANCE));
		}
		
		// PRIVATE
		
		/**
		 * Returns whether the word has been fully spelled.
		 * @return	true if word has been fully typed, otherwise false.
		 */
		private function isFinished():Boolean
		{
			return _pos >= _wordToSpell.length - 1;
		}
	}
}