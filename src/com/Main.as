package com
{
	// Flash Imports
	import flash.display.Sprite;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import org.flashdevelop.utils.FlashConnect;
	
	// My Imports
	import com.mvc.controller.InputOpperator;
	import com.mvc.model.WordSlotHandlerModel;
	import com.mvc.view.GameView;
	
	// BUG after you complete a spelling only that wordslot will start spelling again untill a fail, which resets it.
	
	// BUG top word is ALWAYS aardvark.
	
	/**
	 * Avoider/Typing Game Crossover.
	 * @author Kristian Welsh
	 */
	public class Main extends Sprite 
	{
		/** List of words to spell. */
		private var _wordsToSpell:Vector.<String> = Vector.<String>(["foo", "cat", "dog", "watch", "wallet", "phone", "mane", "main"]);
		
		/** Handles player input */
		private var _inputOperator:InputOpperator;
		
		/** Handles all view responsibilities for the game */
		private var _gameView:GameView;
		
		/** Handles all model responsibilities related to handling the word slots. */
		private var _handlerModel:WordSlotHandlerModel;
		
		/** Initialises the aplication. */
		public function Main():void 
		{
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
			
			_handlerModel.initWordSlots();
		}
	}
	
}