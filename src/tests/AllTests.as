package tests
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestSuite;
	import tests.events.WordSlotEventTest;
	import tests.mvc.controller.InputOpperatorTest;
	import tests.mvc.model.WordSlotHandlerModelTest;
	import tests.mvc.model.WordSlotModelTest;
	
	// Flash Imports
	import flash.display.Stage;
	
	// My imports
	import tests.events.WordSlotHandlerEventTest;
	
	/**
	 * Executes all unit tests for the aplication.
	 * @author Kristian Welsh
	 */
	public class AllTests extends TestSuite
	{
		private static var _stage:Stage = null;
		
		public static function set stage(value:Stage):void
		{
			_stage = value;
		}
		
		/** Runs all unit tests. */
		public function AllTests()
		{
			super();
			if (_stage == null) throw new Error("You must set the stage for all tests before calling the constructor", 2);
			
			wordSlotHandlerEvent();
			wordSlotEvent();
			inputOpperator();
			wordSlotHandlerModel();
			wordSlotModel();
		}
		
		private function wordSlotHandlerEvent():void
		{
			addTest(new WordSlotHandlerEventTest("testDataRetention"));
			addTest(new WordSlotHandlerEventTest("testClone"));
		}
		
		private function wordSlotEvent():void
		{
			addTest(new WordSlotEventTest("testDataRetention"));
			addTest(new WordSlotEventTest("testClone"));
		}
		
		private function inputOpperator():void
		{
			addTest(new InputOpperatorTest("testKeyPress", _stage));
		}
		
		private function wordSlotHandlerModel():void
		{
			addTest(new WordSlotHandlerModelTest("testInitWordSlots"));
			addTest(new WordSlotHandlerModelTest("testWordFinishReset"));
			addTest(new WordSlotHandlerModelTest("testAcceptInputHappyCase1"));
			addTest(new WordSlotHandlerModelTest("testAcceptInputSadCase1"));
		}
		
		private function wordSlotModel():void
		{
			addTest(new WordSlotModelTest("testGettingAndSettingWordToSpell"));
			addTest(new WordSlotModelTest("testIsNextCharacterCode"));
		}
	}
}