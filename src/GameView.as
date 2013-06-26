package
{
	import flash.display.Stage;
	
	/**
	 * Currently just a wrapper for the word handler but i will add more after initial input is prototyped.
	 * @author Kristian Welsh
	 */
	public class GameView 
	{
		private var _wordHandler:WordHandlerView;
		/** initialise the view of the game. */
		public function GameView(stage:Stage, wordsToSpell:Vector.<String>, handlerModel:WordHandlerModel) 
		{
			_wordHandler = new WordHandlerView(stage, handlerModel);
		}
		/** Return the word handler. */
		public function get wordHandler():WordHandlerView { return _wordHandler; }
	}
}