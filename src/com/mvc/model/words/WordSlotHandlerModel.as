package com.mvc.model.words
{
	import com.events.WordCompleteEvent;
	import com.events.WordSlotEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	/**
	 * Prepares a list of word slots and listens to them for changes. (possible double responsibility?)
	 * @author Kristian Welsh
	 */
	public class WordSlotHandlerModel extends EventDispatcher implements IWordSlotHandlerModel
	{
		private var _wordSpellings:Vector.<String>;
		private var _wordSlotModels:Vector.<IWordSlotModel>;
		
		/**
		 * The current index you are at in the _wordSpellings Vector.
		 * This starts at -1 so that when you want a new word you can increase it then use it immediately.
		 */
		private var _wordSpellingProgress:int = -1;
		
		/**
		 * Set the initial values of all dependencies.
		 * @param Scrambled list of word spellings to assign.
		 * @param List of word slots to handle.
		 * @param List of word slots that are currently being correctly spelled by the user.
		 */
		public function WordSlotHandlerModel(wordSpellings:Vector.<String>, wordSlots:Vector.<IWordSlotModel>):void {
			if (!(wordSpellings.length > wordSlots.length))
				throw new Error("The passed in wordSpellings Vector needs to be longer than the wordSlots Vector.", 3);
			
			_wordSpellings = wordSpellings;
			_wordSlotModels = wordSlots;
		}
		
		/** Set up all the word slots and give each a word to spell. */
		public function initWordSlots():void {
			for (var i:int = 0; i < _wordSlotModels.length; i++) {
				initWordSlotAtIndex(i);
			}
		}
		
		private function initWordSlotAtIndex(index:int):void {
			giveWordNewSpelling(_wordSlotModels[index]);
			_wordSlotModels[index].addEventListener(WordSlotEvent.FINISH, onWordFinish);
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
				if (++_wordSpellingProgress >= _wordSpellings.length) _wordSpellingProgress = 0;
			} while (isWordInUse(currentSpelling));
		}
		
		private function get currentSpelling():String {
			return _wordSpellings[_wordSpellingProgress];
		}
		
		private function isWordInUse(wordToFind:String):Boolean {
			for (var i:int = 0; i < _wordSlotModels.length; ++i) {
				if (_wordSlotModels[i].wordToSpell == wordToFind) return true;
			}
			return false;
		}
		
		public function destroy():void {
			for (var i:int = 0; i < _wordSlotModels.length; ++i) {
				_wordSlotModels[i].removeEventListener(WordSlotEvent.FINISH, onWordFinish);
			}
		}
		
		//public function getWordSlotAt(index:uint):IWordSlotModel {
			//return _wordSlotModels[index];
		//}
		
		public function getWordSlots():Vector.<IWordSlotModel> {
			return _wordSlotModels;
		}
		
		//public function get length():uint {
			//return _wordSlotModels.length;
		//}
		
		//public function isNextCharacterCode(index:uint, characterCode:int):Boolean {
			//return _wordSlotModels[index].isNextCharacterCode(characterCode);
		//}
	}
}