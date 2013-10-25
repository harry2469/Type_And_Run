package testhelpers {
	import com.events.WordSlotEvent;
	import com.mvc.model.words.IWordSlotModel;
	import flash.events.*;
	
	public class MockWordSlotModel extends EventDispatcher implements IWordSlotModel {
		private var _wordToSpell:String;
		private var _pos:int = 0;
		
		public function MockWordSlotModel(word:String) {
			super();
			_wordToSpell = word;
		}
		
		public function get wordToSpell():String {
			return _wordToSpell;
		}
		
		public function set wordToSpell(input:String):void {
			_wordToSpell = input;
			_pos = 0;
			dispatchEvent(new WordSlotEvent(WordSlotEvent.CHANGE, _wordToSpell));
		}
		
		public function isNextCharacterCode(inputChar:int):Boolean {
			var result:Boolean = isNextCharCodeInternal(inputChar);
			if (!result)
				dispatchEvent(new Event(Event.DEACTIVATE));
			return result;
		}
		
		private function isNextCharCodeInternal(inputChar:int):Boolean {
			return inputChar == _wordToSpell.charCodeAt(_pos);
		}
		
		public function advanceWord(inputChar:int):void {
			if (!shouldAdvance(inputChar))
				return;
			dispatchEvent(new Event(Event.ACTIVATE));
			_pos++;
		}
		
		private function shouldAdvance(inputChar:int):Boolean {
			if (!isNextCharCodeInternal(inputChar))
				return false;
			return true;
		}
		
		public function resetWord():void {
			wordToSpell = wordToSpell;
		}
		
		public function get action():String {
			return "test";
		}
	}
}