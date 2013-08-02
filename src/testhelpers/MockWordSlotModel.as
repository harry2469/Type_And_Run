package testhelpers
{
	import com.events.WordSlotEvent;
	import com.mvc.model.words.IWordSlotModel;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class MockWordSlotModel extends EventDispatcher implements IWordSlotModel
	{
		private var _wordToSpell:String;
		private var _pos:int = 0;
		
		public function MockWordSlotModel(word:String = "")
		{
			super();
			_wordToSpell = word;
		}
		
		public function get wordToSpell():String { return _wordToSpell; }
		public function set wordToSpell(input:String):void { _wordToSpell = input; }
		
		public function get pos():int { return _pos; }
		
		public function isNextCharacterCode(inputChar:int):Boolean
		{
			if(!isNextCharCodeInternal(inputChar))dispatchEvent(new Event(Event.DEACTIVATE));
			return isNextCharCodeInternal(inputChar);
		}
		
		private function isNextCharCodeInternal(inputChar:int):Boolean
		{
			return inputChar == _wordToSpell.charCodeAt(_pos);
		}
		
		public function advanceWord(inputChar:int):void
		{
			if (!isNextCharCodeInternal(inputChar)) return;
			if (isFinished()) return;
			dispatchEvent(new Event(Event.ACTIVATE));
			_pos++;
		}
		
		public function resetWord():void { }
		private function isFinished():Boolean
		{
			if (_pos == _wordToSpell.length-1)
			{
				dispatchEvent(new WordSlotEvent(WordSlotEvent.FINISH));
			}
			return false
		}
	}

}