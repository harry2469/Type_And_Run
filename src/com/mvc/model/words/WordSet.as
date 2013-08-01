package com.mvc.model.words
{
	import com.events.WordCompleteEvent;
	import com.events.WordSlotEvent;
	import com.events.WordSlotHandlerEvent;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class WordSet extends EventDispatcher
	{
		private var _wordStrings:Vector.<String> = new Vector.<String>;
		private var _wordSlots:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>;
		private var _spellingListProgress:int = -1;
		
		public function WordSet(wordStrings_:Vector.<String>, wordSlots_:Vector.<IWordSlotModel>):void
		{
			if (!(wordStrings_.length > wordSlots_.length))
			{
				throw new Error("The passed in wordList Vector needs to be longer than the wordSlots Vector.", 3);
			}
			
			_wordStrings = wordStrings_;
			_wordSlots = wordSlots_;
		}
		
		public function get length():uint
		{
			return _wordSlots.length;
		}
		
		public function get wordSlots():Vector.<IWordSlotModel>
		{
			return _wordSlots;
		}
		
		public function get wordStrings():Vector.<String>
		{
			return _wordStrings;
		}
		
		private function get nextSpelling():String
		{
			return wordStrings[_spellingListProgress];
		}
		
		/** Destroys the object in a clean and memory concious fashion. */
		public function destroy():void
		{
			for (var i:int = 0; i < wordSlots.length; ++i)
			{
				wordSlots[i].removeEventListener(WordSlotEvent.FINISH, onWordFinish);
			}
		}
		
		/** Set up all the word slots and give each a word to spell. */
		public function initWordSlots():void
		{
			for (var i:int = 0; i < _wordSlots.length; i++) {
				initWordSlotAtIndex(i);
			}
		}
		
		public function isNextCharacterCode(index:uint, charCode:int):Boolean
		{
			return _wordSlots[index].isNextCharacterCode(charCode);
		}
		
		public function wordAt(index:uint):IWordSlotModel
		{
			return _wordSlots[index];
		}
		
		// PRIVATE
		
		private function initWordSlotAtIndex(index:int):void
		{
			giveWordNewSpelling(_wordSlots[index]);
			_wordSlots[index].addEventListener(WordSlotEvent.FINISH, onWordFinish);
			dispatchEvent(new WordSlotHandlerEvent(WordSlotHandlerEvent.CREATE, _wordSlots[index]));
		}
		
		private function onWordFinish(e:WordSlotEvent):void
		{
			giveWordNewSpelling(e.target as IWordSlotModel);
			dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
		}
		
		private function giveWordNewSpelling(wordSlot:IWordSlotModel):void
		{
			wordSlot.wordToSpell = consumeSpelling();
		}
		
		/**
		 * Advances to the next spelling, returning that new spelling.
		 * @return first available spelling from the list
		 */
		private function consumeSpelling():String
		{
			do {
				_spellingListProgress++;
				if (_spellingListProgress >= _wordStrings.length) _spellingListProgress = 0;
			} while (isWordInUse(nextSpelling));
			return nextSpelling;
		}
		
		private function isWordInUse(word:String):Boolean
		{
			for (var i:int = 0; i < _wordSlots.length; ++i)
			{
				if (_wordSlots[i].wordToSpell == word) return true;
			}
			return false;
		}
		
	}

}