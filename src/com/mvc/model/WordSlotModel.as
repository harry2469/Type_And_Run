package com.mvc.model
{
	// Flash Imports
	import flash.events.EventDispatcher;
	import flash.display.Stage;
	
	// My Imports
	import com.events.WordSlotEvent;
	
	/**
	 * Manage the display and word progression of a word form the list.
	 * @author Kristian Welsh
	 */
	public class WordSlotModel extends EventDispatcher implements IWordSlotModel
	{
		/** The word that currently needs to be spelt for this word slot */
		private var _wordToSpell:String = "";
		
		/** The index of your current progress position on the the word to spell */
		private var _pos:uint = 0;
		
		// PUBLIC FUNCTIONS
		
		/**
		 * Returns the current word to spell.
		 * @return current word to spell
		 */
		public function get wordToSpell():String
		{
			return _wordToSpell;
		}
		
		/**
		 * Changes the value of word to spell, and dispatch an event to tell listeners that the value has been updated.
		 * @param	input:String
		 */
		public function set wordToSpell(input:String):void
		{
			_wordToSpell = input;
			resetWord();
		}
		
		/**
		 * Returns whether the input character code and the next character code in the word to spell are the same.
		 * @param	inputChar
		 * @return	whether they are the same.
		 */
		public function isNextCharacterCode(inputChar:uint):Boolean
		{
			return inputChar == _wordToSpell.charCodeAt(_pos);
		}
		
		/**
		 * If the input is valid, dispatch an ADVANCE WordSlotEvent.
		 * @param	inputChar:uint
		 */
		public function advanceWord(inputChar:uint):void
		{
			if (!isValidInput(inputChar)) return;
			dispatchEvent(new WordSlotEvent(WordSlotEvent.ADVANCE));
			_pos++
		}
		
		/**
		 * Removes all progress in the spelling, and dispatch an event to signal this occurance.
		 */
		public function resetWord():void
		{
			dispatchEvent(new WordSlotEvent(WordSlotEvent.CHANGE));
			_pos = 0;
		}
		
		override public function toString():String
		{
			return "[WordSlotModel wordToSpell=" + wordToSpell + "]";
		}
		
		// PRIVATE FUNCTIONS
		
		/**
		 * Changes the word to spell to a new word.
		 * @param	newWord
		 */
		private function changeWord(newWord:String):void
		{
			_wordToSpell = newWord;
			resetWord();
		}
		
		/**
		 * Determines whether an Input Character Code should be allowed to incriment the word.
		 * @param	inputChar:uint
		 * @return	false if input is invalid, otherwise return true.
		 */
		private function isValidInput(inputChar:uint):Boolean
		{
			if (isFinished()) return false;
			if (!isNextCharacterCode(inputChar)) return false;
			return true
		}
		
		/**
		 * Returns whether the word has been fully spelled.
		 * @return	true if word has been fully typed, otherwise false.
		 */
		private function isFinished():Boolean
		{
			if (_pos >= _wordToSpell.length - 1) {
				dispatchEvent(new WordSlotEvent(WordSlotEvent.FINISH));
				return true;
			}
			return false
		}
	}
}