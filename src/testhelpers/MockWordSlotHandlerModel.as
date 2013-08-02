package testhelpers
{
	import com.events.WordCompleteEvent;
	import com.mvc.model.words.IWordSlotHandlerModel;
	import com.mvc.model.words.IWordSlotModel;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	public class MockWordSlotHandlerModel extends EventDispatcher implements IWordSlotHandlerModel
	{
		private var _wordSlots:Vector.<IWordSlotModel>;
		public function MockWordSlotHandlerModel(mockWordSlotModels:Vector.<IWordSlotModel> = null)
		{
			super();
			mockWordSlotModels ||= new Vector.<IWordSlotModel>();
			_wordSlots = mockWordSlotModels
		}
		public function get wordSlots():Vector.<IWordSlotModel> { return _wordSlots; }
		public function acceptInput(charCode:int):void {
			dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, charCode));
		}
		public function initWordSlots():void { }
		public function finishWord():void {
			dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
		}
	}
}