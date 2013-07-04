package com.mvc.view.word
{
	// Flash Imports
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	// My Imports
	import com.events.WordSlotEvent;
	import com.events.WordSlotHandlerEvent;
	import com.mvc.model.IWordSlotModel;
	
	/**
	 * Manage the display and visual aspects of word slot progression of the passed in IWordSlotModel object.
	 * @author Kristian Welsh
	 */
	public class WordSlotView implements IWordSlotView
	{
		/** Referance to the associated IWordSlotModel object to listen for relevent events. */
		private var _model:IWordSlotModel;
		
		/** Specialised text box to display letters of the current word that you have yet to spell. */
		private var _lettersToSpell:LettersToSpell;
		
		/** Specialised text box to display letters of the current word that you have already spelt. */
		private var _lettersSpelt:LettersSpelt;
		
		/** Referance to the document's stage. */
		private var _stage:Stage;
		
		private var _position:Point;
		
		/**
		 * Creates referances to the 2 text fields
		 */
		public function WordSlotView(lettersToSpell:LettersToSpell, lettersSpelt:LettersSpelt):void
		{
			_lettersToSpell = lettersToSpell;
			_lettersSpelt = lettersSpelt;
		}
		
		/**
		 * Readys the object for use.
		 * @param	stage
		 * @param	model
		 * @param	position
		 */
		public function init(stage:Stage, model:IWordSlotModel, position:Point):void
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
		private function initVars(stage:Stage, model:IWordSlotModel, position:Point):void
		{
			_stage = stage;
			_model = model;
			_position = position;
			_lettersToSpell.init(stage, position, _model.wordToSpell);
			_lettersSpelt.init(stage, position, new TextFormat());
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
		
		/**
		 * Returns a string representation of the Word, mainly the spelling.
		 * @exampleText Outputs something like: "[Word "cat"]"
		 */
		public function clone():IWordSlotView
		{
			return new WordSlotView(_lettersToSpell, _lettersSpelt);
		}
	}
}