package
{
	import flash.display.Stage;
	
	/**
	 * Currently just a wrapper for the word handler but i will add more after initial input is prototyped.
	 * @author Kristian Welsh
	 */
	public class GameView 
	{
		private var _wordHandler:WordHandler;
		/** initialise the view of the game */
		public function GameView(stage:Stage, wordsToType:Array) 
		{
			_wordHandler = new WordHandler(stage, wordsToType);
		}
		
		public function get wordHandler():WordHandler { return _wordHandler; }
	}
}