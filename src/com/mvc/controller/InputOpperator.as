package com.mvc.controller {
	import com.mvc.model.words.IWordSlotLatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	
	/**
	 * Manage Keyboard Input From The User.
	 * @author KristianWelsh
	 */
	public class InputOpperator {
		private var _wordLatcher:IWordSlotLatcher = null;
		
		public function InputOpperator(keyboardInput:IEventDispatcher, wordLatcher:IWordSlotLatcher) {
			_wordLatcher = wordLatcher;
			
			keyboardInput.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void {
			_wordLatcher.acceptInput(e.charCode);
		}
	}
}