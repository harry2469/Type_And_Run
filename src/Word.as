package  
{
	import flash.display.Stage;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * Manage the display and word progression of a word form the list.
	 * @author 
	 */
	public class Word 
	{
		private var _wordToSpell:String = "";
		private var _lettersToType:LettersToType;
		private var _lettersTyped:LettersTyped;
		private var _pos:uint = 0;
		/** Initialise both text boxes */
		public function Word(stage:Stage, wordToType:String, newY:Number) 
		{
			_wordToSpell = wordToType;
			_lettersToType = new LettersToType(stage, wordToType, newY);
			_lettersTyped = new LettersTyped(stage, newY);
		}
		/** Exchange letters between text boxes in correct curcumstances then adjust the current position */
		public function advanceWord(inputChar:uint):void
		{
			if (!isNextCharacterCode(inputChar)) return;
			
			_lettersTyped.advanceWord(_lettersToType);
			_lettersToType.advanceWord();
			_pos++
		}
		/** Returns whether the input character is valid for the current state. */
		public function isNextCharacterCode(inputChar:uint):Boolean
		{
			if (isFinished()) return false;
			if (inputChar != _wordToSpell.charCodeAt(_pos)) return false; //TODO: extract boolean method
			return true;
		}
		/** Returns whether the word hase been fully spelled. */
		private function isFinished():Boolean
		{
			return _pos >= _wordToSpell.length;
		}
		/** Returns the number of letters left to input. */
		public function get length():Number { return _wordToSpell.length; }
	}
}