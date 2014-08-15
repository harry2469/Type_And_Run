package com.mvc.model.words {
	import com.mvc.model.words.IWordSlotListener;
	import flash.events.EventDispatcher;

	/** @author Kristian Welsh */
	public class MockWordSlotListener extends EventDispatcher implements IWordSlotListener {
		// this is actually a stub
		public function listen():void {}
		public function destroy():void {}
	}
}