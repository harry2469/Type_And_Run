package tests
{
	import asunitsrc.asunit.framework.TestSuite;
	import flash.display.Stage;
	import tests.events.WordSlotHandlerEventTest;
	import tests.events.WordSlotEventTest;
	import tests.mvc.controller.InputOpperatorTest;
	import tests.mvc.model.EntityModelTest;
	import tests.mvc.model.PlayerModelTest;
	import tests.mvc.model.EntityModelTest;
	import tests.mvc.model.words.WordSlotHandlerModelTest;
	import tests.mvc.model.words.WordSlotLatcherTest;
	import tests.mvc.model.words.WordSlotModelTest;
	
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
			if (_stage == null) throw new Error("You must set the stage for all tests before calling the constructor");
			
			wordSlotHandlerEvent();
			wordSlotEvent();
			inputOpperator();
			wordSlotHandlerModel();
			wordSlotModel();
			playerModel();
			entityModel();
			wordSlotLatcher();
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
			addTest(new WordSlotHandlerModelTest("testDispatchEventOnWordComplete"));
			addTest(new WordSlotHandlerModelTest("should_reject_incorrect_constructor_parameters"));
		}
		
		private function wordSlotLatcher():void
		{
			addTest(new WordSlotLatcherTest("testAcceptInputHappyCase1"));
			addTest(new WordSlotLatcherTest("testAcceptInputSadCase1"));
		}
		
		private function wordSlotModel():void
		{
			addTest(new WordSlotModelTest("testUserCanGetAndSetWordToSpell"));
			addTest(new WordSlotModelTest("testSettingWordToSpellDispatchesChangeWordSlotEvent"));
			addTest(new WordSlotModelTest("testCorrectAdvanceWordCallDispatchesAdvanceWordSlotEvent"));
			addTest(new WordSlotModelTest("testUserCanCheckNextCharacterCodeAndAdvanceWord"));
			addTest(new WordSlotModelTest("testCompletingWordCallDispatchesFinishEvent"));
		}
		
		private function playerModel():void
		{
			addTest(new PlayerModelTest("should_move_up_on_jump"));
		}
		
		private function entityModel():void
		{
			addTest(new EntityModelTest("can_get_x"));
			addTest(new EntityModelTest("can_get_y"));
			addTest(new EntityModelTest("should_dispatch_position_change_event_when_moved"));
			addTest(new EntityModelTest("should_check_colliision_with_other_entitys_correctly"));
			addTest(new EntityModelTest("should_collide_with_other_entitys_correctly"));
		}
	}
}