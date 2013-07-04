package com
{
	// FlashDevelop imports
	
	// Flash Imports
	import flash.display.Sprite;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	
	// My Imports
	import com.mvc.controller.InputOpperator;
	import com.mvc.model.WordSlotHandlerModel;
	import com.mvc.model.WordSlotModel;
	import com.mvc.view.GameView;
	import tests.MyTestRunner;
	
	// BUG after you complete a spelling only that wordslot will start spelling again untill a fail, which resets it.
	
	// BUG top word is ALWAYS aardvark.
	
	/**
	 * Avoider/Typing Game Crossover.
	 * @author Kristian Welsh
	 */
	public class Main extends Sprite
	{
		/** Is this run intended to run the unit tests? */
		static public const TEST_PASS:Boolean = false;
		
		/** List of words to spell. */
		private var _wordsToSpell:Vector.<String> = Vector.<String>(["rat", "cat", "dog"]);
		
		/** Handles player input */
		private var _inputOperator:InputOpperator;
		
		/** Handles all view responsibilities for the game */
		private var _gameView:GameView;
		
		/** Handles all model responsibilities related to handling the word slots. */
		private var _handlerModel:WordSlotHandlerModel;
		private var runner:MyTestRunner;
		
		/** Initialises the aplication. */
		public function Main():void
		{
			// If this is a unit test run then only run the unit tests.
			if (TEST_PASS) {
				runner = new MyTestRunner(stage)
				return;
			}
			
			_handlerModel = new WordSlotHandlerModel(_wordsToSpell);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * This function is called when added to the stage to ensure there is a stage to add objects to.
		 * @param	e
		 */
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_gameView = new GameView(stage, _wordsToSpell, _handlerModel);
			_inputOperator = new InputOpperator(stage, _handlerModel);
			
			_handlerModel.initWordSlots(new WordSlotModel());
		}
	}
	
}