package tests
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestSuite;
	import tests.mvc.model.words.WordSlotHandlerModelTest;
	import tests.mvc.model.words.WordSlotModelTest;
	
	// Flash Imports
	import flash.display.Stage;
	
	// My imports
	import tests.events.WordSlotHandlerEventTest;
	import tests.events.WordSlotEventTest;
	import tests.mvc.controller.InputOpperatorTest;
	import tests.mvc.model.ObstacleModelTest;
	import tests.mvc.model.PlayerModelTest;
	import tests.mvc.view.PlayerViewTest;
	import tests.mvc.view.WordSlotHandlerViewTest;
	
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
			wordSlotHandlerView();
			playerModel();
			playerView();
			obstacleModel();
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
			addTest(new WordSlotHandlerModelTest("testDispatchEventOnWordComplete"));
		}
		
		private function wordSlotModel():void
		{
			addTest(new WordSlotModelTest("testUserCanGetAndSetWordToSpell"));
			addTest(new WordSlotModelTest("testSettingWordToSpellDispatchesChangeWordSlotEvent"));
			addTest(new WordSlotModelTest("testCorrectAdvanceWordCallDispatchesAdvanceWordSlotEvent"));
			addTest(new WordSlotModelTest("testUserCanCheckNextCharacterCodeAndAdvanceWord"));
			addTest(new WordSlotModelTest("testCompletingWordCallDispatchesFinishEvent"));
		}
		
		private function wordSlotHandlerView():void
		{
			addTest(new WordSlotHandlerViewTest("should_call_init_on_word_views_when_create_event_dispatched", _stage));
		}
		
		private function playerModel():void
		{
			addTest(new PlayerModelTest("testCanGetXAndY"));
			addTest(new PlayerModelTest("testJump"));
			addTest(new PlayerModelTest("should_dispatch_position_change_event_on_jump"));
		}
		
		private function playerView():void
		{
			addTest(new PlayerViewTest("testArtPositioning", _stage));
			addTest(new PlayerViewTest("should_update_art_position_when_model_dispatches_change_position_event", _stage));
		}
		
		private function obstacleModel():void
		{
			addTest(new ObstacleModelTest("should_dispatch_event_on_position_change"));
		}
	}
}