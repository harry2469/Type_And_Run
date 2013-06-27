package com.mvc.controller
{
	// Flash Imports
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	// My Imports
	import com.mvc.model.WordSlotHandlerModel;
	
	/**
	 * Manage Input From The User.
	 * @author KristianWelsh
	 */
	public class InputOpperator 
	{
		/** Referance to the stage for listeners */
		private var _stage:Stage = null;
		
		/** Referance to the Word Handler Model to pass input */
		private var _wordHandlerModel:WordSlotHandlerModel = null;
		
		/**
		 * Readys the object for opperation.
		 * @param	stage:Stage
		 * @param	wordHandlerModel:WordHandlerModel
		 */
		public function InputOpperator(stage:Stage, wordHandlerModel:WordSlotHandlerModel) 
		{
			initVars(stage, wordHandlerModel);
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		/**
		 * Stop Listening For Keypresses (For Pause Menus And The Like).
		 */
		public function stopListening():void
		{
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		/**
		 * Set the object referances.
		 * @param	stage:Stage
		 * @param	wordHandlerModel:WordHandlerModel
		 */
		private function initVars(stage:Stage, wordHandlerModel:WordSlotHandlerModel):void 
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