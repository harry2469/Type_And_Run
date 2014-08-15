package com.mvc.model.words {
	import com.events.WordCompleteEvent;
	import com.SoundManager;

	/** @author Kristian Welsh */
	public class WordSlotLatcher implements IWordSlotLatcher {
		private var _latchedWordSlots:Vector.<IWordSlotModel>;
		private var _wordSlots:Vector.<IWordSlotModel>;
		private var _soundManager:SoundManager;

		public function WordSlotLatcher(wordSlots:Vector.<IWordSlotModel>, wordSlotListener:IWordSlotListener, soundManager:SoundManager, latchedWordSlots:Vector.<IWordSlotModel> = null) {
			_soundManager = soundManager;
			_wordSlots = wordSlots;
			_latchedWordSlots = latchedWordSlots || new Vector.<IWordSlotModel>();
			wordSlotListener.addEventListener(WordCompleteEvent.JUMP, unlatchAll);
			wordSlotListener.addEventListener(WordCompleteEvent.DUCK, unlatchAll);
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
			if (noWordsStarted())
				_soundManager.playIncorrectLetter();
		}

		private function unlatchWordIfInvalid(i:int, inputCharacter:int):void {
			if (!isCorrectInput(i, inputCharacter))
				unlatchIndex(i);
		}

		private function unlatchIndex(index:int):void {
			_latchedWordSlots[index].resetWord();
			_latchedWordSlots.splice(index, 1);
			_soundManager.playIncorrectLetter();
		}

		private function noWordsStarted():Boolean {
			return _latchedWordSlots.length == 0;
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
			_soundManager.playCorrectLetter();
			_latchedWordSlots[index].advanceWord(inputCharacter);
		}
	}
}