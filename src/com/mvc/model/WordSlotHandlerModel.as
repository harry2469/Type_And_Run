package com.mvc.model
{
	// Flash Imports
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import org.flashdevelop.utils.FlashConnect;
	
	// My Imports
	import com.events.WordSlotEvent;
	import com.events.WordSlotHandlerEvent;
	
	/**
	 * Handles all Model responsibilitys of working with the WordSlots.
	 * @author Kristian Welsh
	 */
	public class WordSlotHandlerModel extends EventDispatcher implements IWordSlotHandlerModel
	{
		// TODO: merge _wordStrings and _wordSlots somehow?
		
		public static const NUM_SLOTS:uint = 3;
		
		/** Assigned at constructor to be a list of spellable words. */
		private var _wordStrings:Vector.<String>;
		
		/** Holds a referance to each of the WordSlots as they're created. */
		private var _wordSlots:Vector.<IWordSlotModel>;
		
		/** Holds all words that are currently being actively spelt by the player. */
		private var _latchedWordSlots:Vector.<IWordSlotModel>;
		
		/** The current index you are at in the _wordStrings array. */
		private var _spellingListProgress:uint = 0;
		
		// PUBLIC FUNCTIONS
		
		/**
		 * Set the initial values of all dependencies.
		 * @param List of word spellings to assign.
		 * @param List of word slots to handle.
		 * @param List of word slots that are currently being correctly spelled by the user.
		 */
		public function WordSlotHandlerModel(wordList:Vector.<String>, wordSlots:Vector.<IWordSlotModel>, latchedWordSlots:Vector.<IWordSlotModel>):void
		{
			if (!(wordList.length > wordSlots.length)) throw new Error("The passed in wordList Vector needs to be longer than the wordSlots Vector.", 3);
			
			_wordStrings = wordList;
			_wordSlots = wordSlots;
			_latchedWordSlots = latchedWordSlots;
		}
		
		/**
		 * Destroys the object in a clean and memory concious fashion.
		 */
		public function destroy():void
		{
			removeAllListeners();
		}
		
		/**
		 * Set up all the word slots and give each a word to spell.
		 */
		public function initWordSlots():void
		{
			for (var i:uint = 0; i < _wordSlots.length; i++) {
				initWordSlotAtIndex(i);
			}
		}
		
		/**
		 * Send advance and reset messages to the valid wordslots for the input character.
		 * @param Character code of the key parse
		 */
		public function acceptInput(charCode:uint):void
		{
			latchValidWords(charCode);
			advanceLatchedWords(charCode);
		}
		
		override public function toString():String
		{
			return "[WordSlotHandlerModel]";
		}
		
		// PRIVATE FUNCITONS
		
		private function initWordSlotAtIndex(index:int):void
		{
			giveWordNewSpelling(_wordSlots[index]);
			_wordSlots[index].addEventListener(WordSlotEvent.FINISH, onWordFinish);
			dispatchEvent(new WordSlotHandlerEvent(WordSlotHandlerEvent.CREATE, _wordSlots[index]));
		}
		
		private function giveWordNewSpelling(wordSlot:IWordSlotModel):void
		{
			wordSlot.wordToSpell = returnNextWord();
		}
		
		// non-determinstic
		private function returnNextWord():String
		{
			if (_spellingListProgress >= _wordStrings.length) _spellingListProgress = 0;
			var returnMe:String = _wordStrings[_spellingListProgress];
			_spellingListProgress++;
			
			// Could find a better (and non-recursive) way of dealing with this in the future.
			// Possibly extract boolean method from checking logic.
			if (isWordInUse(returnMe)) returnMe = returnNextWord();
			
			return returnMe;
		}
		
		
		/*
			if (_spellingListProgress >= _wordStrings.length) _spellingListProgress = 0;
			var returnMe:String = _wordStrings[_spellingListProgress];
			_spellingListProgress++;
			
			// Could find a better (and non-recursive) way of dealing with this in the future.
			// Possibly extract boolean method from checking logic.
			if (isWordInUse(returnMe)) returnMe = returnNextWord();
			
			return returnMe;*/
		
		private function isWordInUse(word:String):Boolean
		{
			for (var i:int = 0; i < _wordSlots.length; ++i)
			{
				if (_wordSlots[i].wordToSpell == word) return true;
			}
			return false;
		}
		
		private function onWordFinish(e:WordSlotEvent):void
		{
			giveWordNewSpelling(e.target as IWordSlotModel);
			_latchedWordSlots.length = 0;
		}
		
		private function latchValidWords(inputChar:uint):void
		{
			if (_latchedWordSlots.length != 0) return;
			for (var i:int = 0; i < _wordSlots.length; i++)
			{
				if (_wordSlots[i].isNextCharacterCode(inputChar)) {
					_latchedWordSlots.push(_wordSlots[i]);
				}
			}
		}
		
		private function advanceLatchedWords(inputChar:uint):void
		{
			for (var i:int = _latchedWordSlots.length-1; i >= 0; --i)
			{
				if (!_latchedWordSlots[i].isNextCharacterCode(inputChar)) {
					unlatchIndex(i);
				} else {
					_latchedWordSlots[i].advanceWord(inputChar);
				}
			}
		}
		
		/**
		 * Cleanly reset and remove element at index on _latchedWordSlots.
		 * @param	index
		 */
		private function unlatchIndex(index:int):void
		{
			_latchedWordSlots[index].resetWord();
			_latchedWordSlots.splice(index, 1);
		}
		
		private function removeAllListeners():void
		{
			for (var i:int = 0; i < _wordSlots.length; ++i)
			{
				if (_wordSlots[i].hasEventListener(WordSlotEvent.FINISH)){
					_wordSlots[i].removeEventListener(WordSlotEvent.FINISH, onWordFinish);
				}
			}
		}
	}
}