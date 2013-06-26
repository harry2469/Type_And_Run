package  
{
	import flash.display.Stage;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * Handle the display of spellable words
	 * @author 
	 */
	public class WordHandler 
	{
		private var _wordStrings:Array;			// TODO replace array with vector
		private var _wordObjects:Array;			// TODO replace array with vector
		private var _usedIndexes:Array = [];	// TODO replace array with vector
		
		public function WordHandler(stage:Stage, wordsToType:Array) 
		{
			_wordStrings = wordsToType
			var startingWords:Array = [extractRandomWordString(), extractRandomWordString(), extractRandomWordString()];
			
			_wordObjects = [new Word(stage, startingWords[0], 0),new Word(stage, startingWords[1], 30),new Word(stage, startingWords[2], 60)];
		}
		/** Return an unused string from the wordStrings array */
		private function extractRandomWordString():String {
			var acceptableInt:int = NaN;
			while(_usedIndexes.indexOf(acceptableInt) != -1) {
				acceptableInt = randomIntBetweenBounds(0, _wordStrings.length - 1)
			} 
			_usedIndexes.push(acceptableInt)
			return _wordStrings[acceptableInt];
		}
		/** Return an integer between bounds */
		private function randomIntBetweenBounds(lowerBound:int, upperBound:int):int {
			return Math.floor(Math.random() * (upperBound - lowerBound + 1) + lowerBound)
		}
		/** Return the current number of active word slots */
		public function get length():uint { return _wordObjects.length }
		/** Return all current active word slots */
		public function get wordObjects():Array { return _wordObjects; }
	}

}