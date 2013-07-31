package com.mvc.view.words
{
	import com.events.WordSlotEvent;
	import com.mvc.model.words.IWordSlotModel;
	
	/**
	 * Manage the display and visual aspects of word slot progression of the passed in IWordSlotModel object.
	 * @author Kristian Welsh
	 */
	public class WordSlotView
	{
		/** Displays letters of the current word that you have yet to spell. */
		private var _lettersToSpell:LettersToSpell;
		
		/** Displays letters of the current word that you have already spelt. */
		private var _lettersSpelt:LettersSpelt;
		
		// PUBLIC
		
		/**
		 * Creates referances to the 2 text fields
		 */
		public function WordSlotView(model:IWordSlotModel, lettersToSpell:LettersToSpell, lettersSpelt:LettersSpelt):void
		{
			addListeners(model);
			_lettersToSpell = lettersToSpell;
			_lettersSpelt = lettersSpelt;
		}
		
		// PRIVATE
		
		/**
		 * Adds all event listeners to the word's model.
		 */
		private function addListeners(model:IWordSlotModel):void
		{
			model.addEventListener(WordSlotEvent.ADVANCE, handleAdvance);
			model.addEventListener(WordSlotEvent.CHANGE, handleChange);
		}
		
		/**
		 * Exchange letters between text boxes in correct curcumstances then adjust the current position.
		 * @param	e:WordSlotEvent
		 */
		private function handleAdvance(e:WordSlotEvent):void
		{
			_lettersSpelt.text += _lettersToSpell.shift();
		}
		
		/**
		 * Changes the viewable word to the new word in model.
		 * @param	e:WordSlotEvent
		 */
		private function handleChange(e:WordSlotEvent):void
		{
			_lettersToSpell.text = e.wordToSpell;
			_lettersSpelt.text = "";
		}
	}
}