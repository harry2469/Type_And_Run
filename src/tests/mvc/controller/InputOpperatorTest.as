package tests.mvc.controller
{
	import asunitsrc.asunit.framework.TestCase;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import testhelpers.MockWordSlotHandlerModel;
	import flash.display.Stage;
	import com.mvc.controller.InputOpperator;
	import com.mvc.model.words.IWordSlotHandlerModel;
	import testhelpers.MockWordSlotLatcher;
	
	/**
	 * Tests all public behavior of the InputOpperatorTest class.
	 * @author Kristian Welsh
	 */
	public class InputOpperatorTest extends TestCase
	{
		private var _stage:Stage = null;
		private var _acceptInputList:Vector.<int> = new Vector.<int>();
		
		public function InputOpperatorTest(testMethod:String, stage:Stage):void
		{
			_stage = stage;
			super(testMethod);
		}
		
		/**
		 * Tests that InputOpperator calls acceptInput on its IWordSlotHandlerModel when it detects a key press
		 */
		public function testKeyPress():void
		{
			var model:MockWordSlotLatcher = new MockWordSlotLatcher();
			var instance:InputOpperator = new InputOpperator(_stage, model);
			
			model.addEventListener(KeyboardEvent.KEY_DOWN, validateInputCharacter);
			_stage.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 113));
			assertEquals(113, _acceptInputList[_acceptInputList.length-1]);
		}
		
		private function validateInputCharacter(e:KeyboardEvent):void
		{
			_acceptInputList.push(e.charCode);
		}
	}
}