package com.mvc.view.word
{
	// Flash Imports
	import flash.display.Stage;
	import flash.geom.Point;
	
	// My Imports
	import com.events.WordSlotEvent;
	import com.events.WordSlotHandlerEvent;
	import com.mvc.model.WordSlotModel;
	
	/**
	 * Manage the display and visual aspects of word slot progression of the passed in WordSlotModel object.
	 * @author Kristian Welsh
	 */
	public class WordSlotView
	{
		/** Referance to the associated WordSlotModel object to listen for relevent events. */
		private var _model:WordSlotModel;
		
		/** Specialised text box to display letters of the current word that you have yet to spell. */
		private var _lettersToSpell:LettersToSpell;
		
		/** Specialised text box to display letters of the current word that you have already spelt. */
		private var _lettersSpelt:LettersSpelt;
		
		/**
		 * Readys the object for use.
		 * @param	stage
		 * @param	model
		 * @param	position
		 */
		public function WordSlotView(stage:Stage, model:WordSlotModel, position:Point):void
		{
			initVars(stage, model, position);
			addModelListeners();
		}
		
		/**
		 * Initialise model referance and both text boxes.
		 * @param	stage
		 * @param	model
		 * @param	position
		 */
		private function initVars(stage:Stage, model:WordSlotModel, position:Point):void 
		{
			_model = model
			_lettersToSpell = new LettersToSpell(stage, position, _model.wordToSpell);
			_lettersSpelt = new LettersSpelt(stage, position);
		}
		
		/**
		 * Adds all event listeners to the word's model.
		 */
		private function addModelListeners():void 
		{
			_model.addEventListener(WordSlotEvent.ADVANCE, handleAdvance);
			_model.addEventListener(WordSlotEvent.CHANGE, handleChange);
		}
		
		/**
		 * Exchange letters between text boxes in correct curcumstances then adjust the current position.
		 * @param	e:WordSlotEvent
		 */
		private function handleAdvance(e:WordSlotEvent):void
		{
			_lettersSpelt.advanceWord(_lettersToSpell);
			_lettersToSpell.advanceWord();
		}
		
		/**
		 * Changes the viewable word to the new word in model.
		 * @param	e:WordSlotEvent
		 */
		private function handleChange(e:WordSlotEvent):void
		{
			_lettersToSpell.changeWord(_model.wordToSpell);
			_lettersSpelt.reset();
		}
		
		/**
		 * Returns a string representation of the Word, mainly the spelling.
		 * @exampleText Outputs something like: "[Word "cat"]"
		 */
		public function toString():String
		{
			return "[Word Slot View \"" + _model.wordToSpell + "\"]";
		}
	}
}