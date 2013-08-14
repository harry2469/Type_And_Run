package com.mvc.model.words {
	import com.events.WordSlotEvent;
	import flash.events.EventDispatcher;
	
	/**
	 * Manage the progression of the user's spelling of a word.
	 * @author Kristian Welsh
	 */
	public class WordSlotModel extends EventDispatcher implements IWordSlotModel {
		private var _wordToSpell:String = "";
		private var _characterPosition:int = 0;
		
		public function get wordToSpell():String {
			return _wordToSpell;
		}
		
		public function set wordToSpell(input:String):void {
			_wordToSpell = input;
			_characterPosition = 0;
			dispatchEvent(new WordSlotEvent(WordSlotEvent.CHANGE, _wordToSpell));
		}
		
		public function resetWord():void {
			wordToSpell = wordToSpell;
		}
		
		public function advanceWord(inputChar:int):void {
			if (!isNextCharacterCode(inputChar))
				return;
			if (isFinished()) {
				dispatchEvent(new WordSlotEvent(WordSlotEvent.FINISH));
				return;
			}
			_characterPosition++;
			dispatchEvent(new WordSlotEvent(WordSlotEvent.ADVANCE));
		}
		
		public function isNextCharacterCode(inputChar:int):Boolean {
			return inputChar == _wordToSpell.charCodeAt(_characterPosition);
		}
		
		private function isFinished(foo:int = 0):Boolean {
			return _characterPosition >= _wordToSpell.length - 1;
		}
	}
}