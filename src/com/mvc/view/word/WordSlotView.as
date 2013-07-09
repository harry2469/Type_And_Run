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
		
		/** The position of both the text objects */
		private var _position:Point;
		
		/** The format for both of the text formats injected here for consistency */
		private var _format1:TextFormat;
		
		/** The format for both of the text formats injected here for consistency */
		private var _format2:TextFormat;
		
		// PUBLIC FUNCTIONS
		
		/**
		 * Creates referances to the 2 text fields
		 */
		public function WordSlotView(lettersToSpell:LettersToSpell, lettersSpelt:LettersSpelt, position:Point, format1:TextFormat, format2:TextFormat):void
		{
			_lettersToSpell = lettersToSpell;
			_lettersSpelt = lettersSpelt;
			_position = position;
			_format1 = format1;
			_format2 = format2;
		}
		
		/**
		 * Readys the object for use.
		 * @param	stage
		 * @param	model
		 */
		public function init(stage:Stage, model:IWordSlotModel):void
		{
			initVars(stage, model);
			addModelListeners();
		}
		
		public function toString():String
		{
			return "[WordSlotView]";
		}
		
		// PRIVATE FUNCTIONS
		
		/**
		 * Initialise model referance and both text boxes.
		 * @param	stage
		 * @param	model
		 */
		private function initVars(stage:Stage, model:IWordSlotModel):void
		{
			_stage = stage;
			_model = model;
			_lettersToSpell.init(stage, _position, _model.wordToSpell, _format1);
			_lettersSpelt.init(stage, _position, _format2);
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
	}
}