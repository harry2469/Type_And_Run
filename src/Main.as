package 
{
	// Flash Imports
	import flash.display.Sprite;
	import flash.events.Event;
	
	// My Imports
	import mvc.controller.InputOpperator;
	import mvc.model.WordHandlerModel;
	import mvc.view.GameView;
	
	// BUG words starting with the same letter retain progress on continuation.
	
	/**
	 * Avoider/Typing Game Crossover.
	 * @author Kristian Welsh
	 */
	public class Main extends Sprite 
	{
		private var _wordsToSpell:Vector.<String> = Vector.<String>(["abbb", "accc", "addd", "aeee", "afff", "aggg"]);
		private var _inputOperator:InputOpperator;
		private var _gameView:GameView;
		
		private var _handlerModel:WordHandlerModel = new WordHandlerModel(_wordsToSpell);
		
		/** Initialises the aplication. */
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		/** This function is called when added to the stage to ensure there is a stage to add objects to. */
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_gameView = new GameView(stage, _wordsToSpell, _handlerModel);
			_inputOperator = new InputOpperator(stage, _handlerModel);
			_handlerModel.initWordSlots()
		}
	}
	
}