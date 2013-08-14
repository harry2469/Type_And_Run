package com.mvc.model.words {
	import com.events.WordCompleteEvent;
	
	/** @author Kristian Welsh */
	public class WordSlotLatcher implements IWordSlotLatcher {
		private var _latchedWordSlots:Vector.<IWordSlotModel>;
		private var _wordSlots:Vector.<IWordSlotModel>;
		
		public function WordSlotLatcher(wordSlots:Vector.<IWordSlotModel>, wordSlotListener:IWordSlotListener, latchedWordSlots:Vector.<IWordSlotModel> = null) {
			_wordSlots = wordSlots;
			_latchedWordSlots = latchedWordSlots || new Vector.<IWordSlotModel>();
			wordSlotListener.addEventListener(WordCompleteEvent.JUMP, unlatchAll);
		}
		
		private function unlatchAll(e:WordCompleteEvent):void {
			_latchedWordSlots = new Vector.<IWordSlotModel>();
		}
		
		public function acceptInput(characterCode:int):void {
			latchValidWords(characterCode);
			unlatchInvalidWords(characterCode);
			advanceLatchedWords(characterCode);
		}
		
		private function latchValidWords(inputCharacter:int):void {
			if (_latchedWordSlots.length == 0)
				for (var i:int = 0; i < _wordSlots.length; i++)
					latchWordIfValid(_wordSlots[i], inputCharacter);
		}
		
		private function latchWordIfValid(word:IWordSlotModel, inputCharacter:int):void {
			if (word.isNextCharacterCode(inputCharacter))
				_latchedWordSlots.push(word);
		}
		
		private function unlatchInvalidWords(inputCharacter:int):void {
			for (var i:int = _latchedWordSlots.length - 1; i >= 0; --i)
				unlatchWordIfInvalid(i, inputCharacter);
		}
		
		private function unlatchWordIfInvalid(i:int, inputCharacter:int):void {
			if (!isCorrectInput(i, inputCharacter))
				unlatchIndex(i);
		}
		
		private function advanceLatchedWords(inputCharacter:int):void {
			for (var i:int = _latchedWordSlots.length - 1; i >= 0; --i)
				advanceLatchedWordIfValid(i, inputCharacter)
		}
		
		private function advanceLatchedWordIfValid(index:int, inputCharacter:int):void {
			if (isCorrectInput(index, inputCharacter))
				advanceWord(index, inputCharacter);
		}
		
		private function isCorrectInput(index:int, inputCharacter:int):Boolean {
			return _latchedWordSlots[index].isNextCharacterCode(inputCharacter);
		}
		
		private function advanceWord(index:int, inputCharacter:int):void {
			_latchedWordSlots[index].advanceWord(inputCharacter);
		}
		
		private function unlatchIndex(index:int):void {
			_latchedWordSlots[index].resetWord();
			_latchedWordSlots.splice(index, 1);
		}
	}
}