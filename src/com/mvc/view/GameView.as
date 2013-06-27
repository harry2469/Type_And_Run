package com.mvc.view
{
	// Flash Imports
	import flash.display.Stage;
	
	// My Imports
	import com.mvc.model.WordSlotHandlerModel;
	
	/**
	 * Currently just a wrapper for the word handler.
	 * I will add more when more needs to be displayed.
	 * @author Kristian Welsh
	 */
	public class GameView 
	{
		/** Handles all view tasks of the Word Slots. */
		private var _wordHandler:WordSlotHandlerView;
		
		/**
		 * Initialises the view components of the game.
		 * @param	stage
		 * @param	wordsToSpell
		 * @param	handlerModel
		 */
		public function GameView(stage:Stage, wordsToSpell:Vector.<String>, handlerModel:WordSlotHandlerModel) 
		{
			_wordHandler = new WordSlotHandlerView(stage, handlerModel);
		}
	}
}