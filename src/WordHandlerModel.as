package  
{
	import events.WordEvent;
	import events.WordHandlerEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class WordHandlerModel extends EventDispatcher
	{
		private static const NUM_SLOTS:uint = 3;
		
		private var _wordSpellings:Vector.<String> = new Vector.<String>(NUM_SLOTS)
		private var _usedIndexes:Vector.<uint> = new Vector.<uint>(NUM_SLOTS);
		private var _wordObjects:Vector.<WordModel> = new Vector.<WordModel>(NUM_SLOTS);
		private var _wordStrings:Vector.<String> = new Vector.<String>();
		private var _latchedWords:Array = [];
		
		public function WordHandlerModel(wordList:Vector.<String>)
		{
			_wordStrings = wordList
		}
		
		public function initWordSlots():void 
		{
			for (var i:int = 0; i < NUM_SLOTS; i++) {
				_wordObjects[i] = new WordModel();
				_wordObjects[i].wordToSpell = extractRandomWordString();
				dispatchEvent(new WordHandlerEvent(WordHandlerEvent.CREATE, _wordObjects[i], new Point(100, i * 30 + 100)));
				_wordObjects[i].addEventListener(WordEvent.FINISH, refreshWord);
			}
		}
		
		private function refreshWord(e:WordEvent):void 
		{
			e.wordObject.wordToSpell = extractRandomWordString();
		}
		
		public function acceptInput(charCode:uint):void 
		{
			latchStartedWords(charCode);
			advanceLatchedWords(charCode);
		}
		
		/** Decide which word(s) to latch onto. */
		private function latchStartedWords(inputChar:uint):void 
		{
			if (_latchedWords.length != 0) return;
			for (var i:int = 0; i < NUM_SLOTS; i++) 
			{
				if (_wordObjects[i].isNextCharacterCode(inputChar)) {
					_latchedWords.push(_wordObjects[i]);
				}
			}
		}
		
		/** Advance progress on all latched words. */
		private function advanceLatchedWords(inputChar:uint):void 
		{
			for (var i:int = _latchedWords.length-1; i >= 0; i--) 
			{
				if (!_wordObjects[i].isNextCharacterCode(inputChar)) {
					_wordObjects[i].resetWord();
				}
				_latchedWords[i].advanceWord(inputChar)
			}
		}
		
		// BUG if there are no more unused strings it does into an infinite loop.
		/** Return an unused string from the wordStrings array. */
		private function extractRandomWordString():String {
			var acceptableInt:int = NaN;
			while(_usedIndexes.indexOf(acceptableInt) != -1) {
				acceptableInt = randomIntBetweenBounds(0, _wordStrings.length - 1)
			} 
			_usedIndexes.push(acceptableInt)
			return _wordStrings[acceptableInt];
		}
		
		/** Return an integer between bounds. */
		private function randomIntBetweenBounds(lowerBound:int, upperBound:int):int {
			return Math.floor(Math.random() * (upperBound - lowerBound + 1) + lowerBound)
		}
		
	}

}