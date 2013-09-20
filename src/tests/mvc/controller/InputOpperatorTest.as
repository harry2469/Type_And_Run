package tests.mvc.controller {
	import asunitsrc.asunit.framework.TestCase;
	import com.mvc.controller.InputOpperator;
	import flash.events.*;
	import testhelpers.MockWordSlotLatcher;
	
	public class InputOpperatorTest extends TestCase {
		private var _acceptInputLog:Vector.<KeyboardEvent> = new Vector.<KeyboardEvent>();
		private var _mockLatcher:MockWordSlotLatcher;
		private var _instance:InputOpperator;
		private var _keyboardInput:IEventDispatcher;
		
		public function InputOpperatorTest(testMethod:String):void {
			super(testMethod);
		}
		
		protected override function setUp():void {
			_keyboardInput = new EventDispatcher();
			_mockLatcher = new MockWordSlotLatcher();
			_instance = new InputOpperator(_keyboardInput, _mockLatcher);
		}
		
		public function should_call_acceptInput_with_correct_keycode_on_its_IWordSlotHandlerModel_when_it_detects_a_key_press():void {
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