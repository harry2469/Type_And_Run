package com.mvc.model.words {
	import com.events.WordCompleteEvent;
	
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class WordSlotLatcher implements IWordSlotLatcher {
		private var _latchedWordSlots:Vector.<IWordSlotModel>;
		private var _wordSlots:Vector.<IWordSlotModel>;
		
		public function WordSlotLatcher(wordSlots:Vector.<IWordSlotModel>, wordSlotListener:WordSlotListener, latchedWordSlots:Vector.<IWordSlotModel> = null) {
			_wordSlots = handler.wordSlots;
			_latchedWordSlots = latchedWordSlots || new Vector.<IWordSlotModel>();
			wordSlotListener.addEventListener(WordCompleteEvent.JUMP, unlatchAll);
		}
		
		private function unlatchAll(e:WordCompleteEvent):void {
			_latchedWordSlots = new Vector.<IWordSlotModel>();
		}
		
		public function acceptInput(charCode:int):void {
			latchValidWords(charCode);
			advanceAllLatchedWords(charCode);
		}
		
		private function latchValidWords(inputChar:int):void {
			if (_latchedWordSlots.length == 0)
				for (var i:int = 0; i < _wordSlots.length; i++)
					latchWordIfValid(_wordSlots[i], inputChar);
		}
		
		private function latchWordIfValid(word:IWordSlotModel, inputChar:int):void {
			if (word.isNextCharacterCode(inputChar))
				_latchedWordSlots.push(word);
		}
		
		private function advanceAllLatchedWords(inputChar:int):void {
			for (var i:int = _latchedWordSlots.length - 1; i >= 0; --i)
				advanceLatchedWord(i, inputChar)
		}
		
		private function advanceLatchedWord(index:int, inputChar:int):void {
			if (isCorrectInput(index, inputChar))
				advanceWord(index, inputChar);
			else
				unlatchIndex(index);
		}
		
		private function isCorrectInput(index:int, inputChar:int):Boolean {
			return _latchedWordSlots[index].isNextCharacterCode(inputChar);
		}
		
		private function advanceWord(index:int, inputChar:int):void {
			_latchedWordSlots[index].advanceWord(inputChar);
		}
		
		private function unlatchIndex(index:int):void {
			_latchedWordSlots.splice(index, 1);
		}
	}
}