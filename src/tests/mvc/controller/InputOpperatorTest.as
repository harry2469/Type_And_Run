package tests.mvc.controller {
	import asunitsrc.asunit.framework.TestCase;
	import com.mvc.controller.InputOpperator;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import testhelpers.MockWordSlotLatcher;
	
	public class InputOpperatorTest extends TestCase {
		private var _stage:Stage = null;
		private var _acceptInputList:Vector.<int> = new Vector.<int>();
		
		public function InputOpperatorTest(testMethod:String, stage:Stage):void {
			_stage = stage;
			super(testMethod);
		}
		
		public function should_call_acceptInput_on_its_IWordSlotHandlerModel_when_it_detects_a_key_press():void {
			var model:MockWordSlotLatcher = new MockWordSlotLatcher();
			var instance:InputOpperator = new InputOpperator(_stage, model);
			model.addEventListener(KeyboardEvent.KEY_DOWN, validateInputCharacter);
			
			_stage.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 113));
			
			assertEquals(113, _acceptInputList[_acceptInputList.length-1]);
		}
		
		private function validateInputCharacter(e:KeyboardEvent):void {
			_acceptInputList.push(e.charCode);
		}
	}
}