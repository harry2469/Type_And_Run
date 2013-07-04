package com.mvc.view
{
	// Flash Imports
	import flash.display.Stage;
	import flash.events.Event;
	
	// My Imports
	import com.mvc.model.WordSlotHandlerModel;
	import com.mvc.view.word.WordSlotView;
	import com.events.WordSlotHandlerEvent;
	import com.events.WordSlotHandlerEvent;
	
	/**
	 * Handle the display of spellable words.
	 * @author Kristian Welsh
	 */
	public class WordSlotHandlerView
	{
		/** Referance to the game's stage */
		private var _stage:Stage;
		
		/** Referance to the object's model component. */
		private var _model:WordSlotHandlerModel;
		
		/** List of active WordSlotView Objects. */
		private var _wordObjects:Vector.<WordSlotView> = new Vector.<WordSlotView>();
		
		/**
		 * Readys the object for use.
		 * @param	stage
		 * @param	model
		 */
		public function WordSlotHandlerView(stage:Stage, model:WordSlotHandlerModel):void
		{
			initVars(stage, model);
			addListeners();
		}
		
		/**
		 * Set the global object referances to the passed in values.
		 * @param	stage
		 * @param	model
		 */
		private function initVars(stage:Stage, model:WordSlotHandlerModel):void
		{
			_stage = stage;
			_model = model;
		}
		
		/**
		 * Adds all needed listeners to the associated model.
		 */
		private function addListeners():void
		{
			_model.addEventListener(WordSlotHandlerEvent.CREATE, wordCreated);
		}
		
		/**
		 * Adds a WordSlotView object to the referance list and provides needed globals and event variables.
		 * @param	e:WordSlotHandlerEvent
		 */
		private function wordCreated(e:WordSlotHandlerEvent):void
		{
			_wordObjects.push(new WordSlotView(_stage, e.newWord, e.position));
		}
	}

}