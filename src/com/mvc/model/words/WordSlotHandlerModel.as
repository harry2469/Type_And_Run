package com.mvc.model.words
{
	// Flash Imports
	import com.events.WordCompleteEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
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
		
		// Variables
		
		/** List of words the player is currently spelling correctly. */
		private var _latchedWordSlots:Vector.<IWordSlotModel>;
		
		/**
		 * The current index you are at in the _wordStrings array.
		 * This starts at -1 so that when you want a new word
		 * you can increase it then use it immediately.
		 */
		private var _spellingListProgress:int = -1;
		
		private var _wordSet:WordSet;
		
		// PUBLIC
		
		/**
		 * Set the initial values of all dependencies.
		 * @param List of word spellings to assign.
		 * @param List of word slots to handle.
		 * @param List of word slots that are currently being correctly spelled by the user.
		 */
		public function WordSlotHandlerModel(wordSet:WordSet, latchedWordSlots:Vector.<IWordSlotModel>):void
		{//#~
			_wordSet = wordSet;
			_latchedWordSlots = latchedWordSlots;
		}
		
		/** Destroys the object in a clean and memory concious fashion. */
		public function destroy():void
		{
			_wordSet.destroy();
		}
		
		/** Set up all the word slots and give each a word to spell. */
		public function initWordSlots():void
		{
			_wordSet.initWordSlots();
		}
		
		/**
		 * Send advance and reset messages to the valid wordslots for the input character.
		 * @param Character code of the key parse
		 */
		public function acceptInput(charCode:int):void
		{
			latchValidWords(charCode);
			advanceAllLatchedWords(charCode);
		}
		
		// PRIVATE
		
		private function latchValidWords(inputChar:int):void
		{
			if (_latchedWordSlots.length != 0) return;
			for (var i:int = 0; i < _wordSet.length; i++)
			{
				if (_wordSet.isNextCharacterCode(i, inputChar)) {
					_latchedWordSlots.push(_wordSet.wordAt(i));
				}
			}
		}
		
		private function advanceAllLatchedWords(inputChar:int):void
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
	}
}