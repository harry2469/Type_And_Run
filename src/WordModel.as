package  
{
	import events.WordEvent;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	/**
	 * Manage the display and word progression of a word form the list.
	 * @author 
	 */
	public class WordModel extends EventDispatcher
	{
		private var _wordToSpell:String = "";
		private var _pos:uint = 0;
		
		public function get wordToSpell():String 
		{
			return _wordToSpell;
		}
		
		public function set wordToSpell(input:String):void
		{
			_wordToSpell = input;
			dispatchEvent(new WordEvent(WordEvent.CHANGE));
		}
		
		/** Exchange letters between text boxes in correct curcumstances then adjust the current position. */
		public function advanceWord(inputChar:uint):void
		{
			if (!isValidInput(inputChar)) return;
			dispatchEvent(new WordEvent(WordEvent.ADVANCE, inputChar));
			_pos++
		}
		
		/** Determines whether the input text should be allowed to incriment the word. */
		public function isValidInput(inputChar:uint):Boolean
		{
			if (isFinished()) return false;
			if (!isNextCharacterCode(inputChar)) return false;
			return true
		}
		
		/** Returns whether the word hase been fully spelled. */
		private function isFinished():Boolean
		{
			if (_pos >= _wordToSpell.length-1) {
				dispatchEvent(new WordEvent(WordEvent.FINISH, NaN, this));
				return true;
			}
			return false
		}
		
		/** Returns whether the input character is valid for the current state. */
		public function isNextCharacterCode(inputChar:uint):Boolean
		{
			return inputChar == _wordToSpell.charCodeAt(_pos);
		}
		
		/** Changes the word to a new word. */
		public function changeWord(newWord:String):void
		{
			_wordToSpell = newWord;
			resetWord();
		}
		
		/** removes all progress in the spelling. */
		public function resetWord():void 
		{
			_pos = 0;
		}
		
		/** Returns the number of letters left to input. */
		public function get length():Number
		{
			return _wordToSpell.length;
		}
	}
}