package com.mvc.controller {
	import asunit.framework.TestCase;
	import com.mvc.controller.InputOpperator;
	import flash.events.*;
	import com.mvc.model.words.MockWordSlotLatcher;

	public class InputOpperatorTest extends TestCase {
		private var _acceptInputLog:Vector.<KeyboardEvent> = new Vector.<KeyboardEvent>();
		private var _mockLatcher:MockWordSlotLatcher;
		private var _instance:InputOpperator;
		private var _keyboardInput:IEventDispatcher;

		protected override function setUp():void {
			_keyboardInput = new EventDispatcher();
			_mockLatcher = new MockWordSlotLatcher();
			_instance = new InputOpperator(_keyboardInput, _mockLatcher);
		}

		public function test_call_acceptInput_on_IWordSlotHandlerModel_when_key_press_detected():void {
			emulateKeyPress();
			assertCalledAcceptInput();
		}

		private function emulateKeyPress():void {
			_mockLatcher.addEventListener(KeyboardEvent.KEY_DOWN, logAcceptInput);
			_keyboardInput.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 113));
		}

		private function logAcceptInput(e:KeyboardEvent):void {
			_acceptInputLog.push(e);
		}

		private function assertCalledAcceptInput():void {
			assertEquals(113, _acceptInputLog[0].charCode);
		}
	}
}