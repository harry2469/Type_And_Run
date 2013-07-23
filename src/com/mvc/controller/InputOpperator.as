package com.mvc.controller
{
	// Flash Imports
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
		private var _wordHandlerModel:IWordSlotHandlerModel = null;
		
		// PUBLIC
		
		/**
		 * Readys the object for opperation.
		 * @param	stage:Stage
		 * @param	wordHandlerModel:WordHandlerModel
		 */
		public function InputOpperator(stage:Stage, wordHandlerModel:IWordSlotHandlerModel)
		{
			initVars(stage, wordHandlerModel);
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		// PRIVATE
		
		/**
		 * Set the object referances.
		 * @param	stage:Stage
		 * @param	wordHandlerModel:WordHandlerModel
		 */
		private function initVars(stage:Stage, wordHandlerModel:IWordSlotHandlerModel):void
		{
			_stage = stage;
			_wordHandlerModel = wordHandlerModel
		}
		
		/**
		 * Manage events that occur on key down.
		 * @param	e:KeyboardEvent
		 */
		private function keyDown(e:KeyboardEvent):void
		{
			_wordHandlerModel.acceptInput(e.charCode);
		}
	}
}