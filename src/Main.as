package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.flashdevelop.utils.FlashConnect;
	
	// TODO rename all instances of "Typing" something to "Spelling" something
	
	/**
	 * Avoider/Typing Game Crossover
	 * @author Kristian Welsh
	 */
	public class Main extends Sprite 
	{
		private var _wordsToType:Array = ["f00", "f00", "foo", "foo", "fOO"];
		private var _inputOperator:InputOpperator;
		private var _gameView:GameView;
		/** initialises the aplication */
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		/** is called when added to the stage to ensure there is a stage to add objects to */
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_gameView = new GameView(stage, _wordsToType);
			_inputOperator = new InputOpperator(stage, _gameView.wordHandler);
		}
	}
	
}