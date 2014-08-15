package com.mvc.model.words {
	import com.mvc.model.words.IWordSlotLatcher;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;

	/** @author Kristian Welsh */
	public class MockWordSlotLatcher extends EventDispatcher implements IWordSlotLatcher {
		public function acceptInput(charCode:int):void {
			var event:KeyboardEvent = keyDownEventWithCharCode(charCode);
			dispatchEvent(event);
		}

		private function keyDownEventWithCharCode(charCode:int):KeyboardEvent {
			var event:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN);
			event.charCode = charCode;
			return event;
		}
	}
}