package testhelpers {
	import com.events.WordCompleteEvent;
	import com.mvc.model.words.IWordSlotHandlerModel;
	import com.mvc.model.words.IWordSlotModel;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	public class MockWordSlotHandlerModel extends EventDispatcher implements IWordSlotHandlerModel {
		private var _wordSlots:Vector.<IWordSlotModel>;
		public function initWordSlots():void {
		}
		public function MockWordSlotHandlerModel(wordSlotModels:Vector.<IWordSlotModel> = null) {
			super();
			wordSlotModels ||= new Vector.<IWordSlotModel>();
			_wordSlots = wordSlotModels
		}
		
		public function get wordSlots():Vector.<IWordSlotModel> {
			return _wordSlots;
		}
		
		public function acceptInput(charCode:int):void {
			dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, charCode));
		}
		
		public function finishWord():void {
			dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
		}
		
		public function get length():uint {
			return _wordSlots.length;
		}
		
		public function isNextCharacterCode(index:uint, characterCode:int):Boolean {
			return _wordSlots[index].isNextCharacterCode(characterCode);
		}
		
		public function getWordSlotAt(index:uint):IWordSlotModel {
			return _wordSlots[index];
		}
		
		public function getWordSlots():Vector.<IWordSlotModel> {
			return _wordSlots;
		}
	}
}