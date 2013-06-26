package
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * Manage Input From The User And Advance Word Progress.
	 * @author 
	 */
	public class InputOpperator 
	{
		private var _stage:Stage = null;
		private var _wordHandler:WordHandler = null;
		private var _latchedWords:Array = [];
		
		/** readys the class for opperation. */
		public function InputOpperator(stage:Stage, wordHandler:WordHandler) 
		{
			_stage = stage;
			_wordHandler = wordHandler
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		/** manage events that occur on key down. */
		private function keyDown(e:KeyboardEvent):void 
		{
			latchStartedWords(e.charCode);
			advanceLatchedWords(e.charCode);
		}
		
		/** Decide which word(s) to latch onto. */
		private function latchStartedWords(inputChar:uint):void 
		{
			if (_latchedWords.length != 0) return;
			for (var i:int = 0; i < _wordHandler.length; i++) 
			{
				if (_wordHandler.wordObjects[i].isNextCharacterCode(inputChar)) {
					_latchedWords.push(_wordHandler.wordObjects[i]);
				}
			}
		}
		
		/** Advance progress on all latched words. */
		private function advanceLatchedWords(inputChar:uint):void 
		{
			for (var i:int = 0; i < _latchedWords.length; i++) 
			{
				_latchedWords[i].advanceWord(inputChar)
			}
		}
		
		/** Stop Listening For Keypresses (For Pause Menus And The Like). */
		public function stopListening():void
		{
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
	}

}