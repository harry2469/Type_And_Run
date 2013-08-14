package com.mvc.model.words {
	import com.events.WordCompleteEvent;
	import com.events.WordSlotEvent;
	import flash.events.EventDispatcher;
	
	/** @author Kristian Welsh */
	public class WordSlotListener extends EventDispatcher implements IWordSlotListener {
		private var _wordSpellings:Vector.<String>;
		private var _wordSpellingProgress:int = -1;
		private var _slots:Vector.<IWordSlotModel>;
		
		public function WordSlotListener(scrambledSpellings:Vector.<String>, wordSlotModels:Vector.<IWordSlotModel>) {
			_wordSpellings = scrambledSpellings;
			_slots = wordSlotModels;
		}
		
		public function listen():void {
			for (var i:int = 0; i < _slots.length; i++)
				_slots[i].addEventListener(WordSlotEvent.FINISH, onWordFinish);
		}
		
		public function destroy():void {
			for (var i:int = 0; i < _slots.length; ++i)
				_slots[i].removeEventListener(WordSlotEvent.FINISH, onWordFinish);
		}
		
		private function onWordFinish(e:WordSlotEvent):void {
			giveWordNewSpelling(e.target as IWordSlotModel);
			dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
		}
		
		private function giveWordNewSpelling(wordSlot:IWordSlotModel):void {
			advanceSpellings();
			wordSlot.wordToSpell = currentSpelling;
		}
		
		private function advanceSpellings():void {
			do {
				if (++_wordSpellingProgress >= _wordSpellings.length)
					_wordSpellingProgress = 0;
			} while (isWordInUse(currentSpelling));
		}
		
		private function get currentSpelling():String {
			return _wordSpellings[_wordSpellingProgress];
		}
		
		private function isWordInUse(wordToFind:String):Boolean {
			for (var i:int = 0; i < _slots.length; ++i)
				if (_slots[i].wordToSpell == wordToFind)
					return true;
			return false;
		}
	}
}