package testhelpers
{
	import com.events.WordCompleteEvent;
	import com.mvc.model.words.IWordSlotHandlerModel;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	public class MockWordSlotHandlerModel extends EventDispatcher implements IWordSlotHandlerModel
	{
		public function acceptInput(charCode:int):void {
			dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, charCode));
		}
		public function initWordSlots():void { }
		public function finishWord():void {
			dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
		}
	}
}