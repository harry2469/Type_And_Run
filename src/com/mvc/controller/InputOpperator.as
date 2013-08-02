package com.mvc.controller
{
	// Flash Imports
	import com.mvc.model.words.IWordSlotLatcher;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	// My Imports
	import com.mvc.model.words.IWordSlotHandlerModel;
	
	/**
	 * Manage Input From The User.
	 * @author KristianWelsh
	 */
	public class InputOpperator
	{
		/** Referance to the stage for listeners */
		private var _stage:Stage = null;
		
		/** Referance to the Word Handler Model to pass input */
		private var _wordLatcher:IWordSlotLatcher = null;
		
		// PUBLIC
		
		/**
		 * Readys the object for opperation.
		 * @param	stage:Stage
		 * @param	wordHandlerModel:WordHandlerModel
		 */
		public function InputOpperator(stage:Stage, wordLatcher:IWordSlotLatcher)
		{
			_stage = stage;
			_wordLatcher = wordLatcher;
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		// PRIVATE
		
		/**
		 * Manage events that occur on key down.
		 * @param	e:KeyboardEvent
		 */
		private function keyDown(e:KeyboardEvent):void
		{
			_wordLatcher.acceptInput(e.charCode);
		}
	}
}