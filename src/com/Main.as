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
		/** Location of the list of english word i am using */
		static public const DICTIONARY_URL:String = "../lib/brit-a-z.txt"; // lib/brit-a-z.txt // Change to this if publishing from flash
		
		/** List of words to spell. */
		private var _wordsToSpell:Vector.<String> = new Vector.<String>();
		
		/** Handles player input */
		private var _inputOperator:InputOpperator;
		
		/** Handles all view responsibilities for the game */
		private var _gameView:GameView;
		
		/** Handles all model responsibilities related to handling the word slots. */
		private var _handlerModel:WordSlotHandlerModel;
		
		/** Initialises the aplication. */
		public function Main():void 
		{
			var myTextLoader:URLLoader = new URLLoader();
			
			myTextLoader.addEventListener(Event.COMPLETE, onLoaded);
			myTextLoader.addEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			
			myTextLoader.load(new URLRequest(DICTIONARY_URL));//DICTIONARY_URL
		}
		
		/**
		 * Delay program start until dictonary file is loaded.
		 * @param	e:Event
		 */
		private function onLoaded(e:Event):void {
			FlashConnect.trace("YES");
			_wordsToSpell = retrieveWordVector(e.target.data);
			/*
			_handlerModel = new WordSlotHandlerModel(_wordsToSpell);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);*/
		}
		
		/**
		 * Handle what happens if an IOError occurs while loading the dictionary.
		 * @param	e:IOErrorEvent
		 */
		private function loaderIOErrorHandler(e:IOErrorEvent):void 
		{
			FlashConnect.trace("NO");
			throw new Error("Dictionary file cannot be found", 2);
		}
		
		/**
		 * Returns a vector of strings each containing a word from the dictionary file.
		 * @param	wordRaw
		 * @return	Vector of all words.
		 */
		private function retrieveWordVector(wordRaw:String):Vector.<String>
		{
			var returnedWords:Vector.<String> = Vector.<String>(wordRaw.split(/\n/));
			for (var i:int = 0; i < returnedWords.length; i++) 
			{
				returnedWords[i] = returnedWords[i].slice( 0, -1 );
			}
			return returnedWords;
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