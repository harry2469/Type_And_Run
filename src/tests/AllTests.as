package tests
{
	import asunitsrc.asunit.framework.*;
	import flash.display.*;
	import tests.events.*;
	import tests.kris.*;
	import tests.mvc.controller.*;
	import tests.mvc.model.*;
	import tests.mvc.model.words.*;
	
	/**
	 * Executes all unit tests for the aplication.
	 * @author Kristian Welsh
	 */
	public class AllTests extends TestSuite {
		private static var _stage:Stage = null;
		
		public static function set stage(value:Stage):void {
			_stage = value;
		}
		
		/** Runs all unit tests. */
		public function AllTests() {
			super();
			if (_stage == null) throw new Error("You must set the stage for all tests before calling the constructor");
			
			wordSlotHandlerEvent();
			wordSlotEvent();
			
			entityModel();
			playerModel();
			wordSlotModel();
			wordSlotLatcher();
			wordSlotHandlerModel();
			
			inputOpperator();
			
			rectangleCollision();
		}
		
		
		private function wordSlotHandlerEvent():void {
			addTest(new WordSlotHandlerEventTest("test_data_retrieval"));
			addTest(new WordSlotHandlerEventTest("test_clone"));
		}
		
		private function wordSlotEvent():void {
			addTest(new WordSlotEventTest("test_data_retrieval"));
			addTest(new WordSlotEventTest("test_clone"));
		}
		
		
		private function entityModel():void {
			addTest(new EntityModelTest("can_get_x"));
			addTest(new EntityModelTest("can_get_y"));
			addTest(new EntityModelTest("should_dispatch_position_change_event_when_moved"));
		}
		
		private function playerModel():void {
			addTest(new PlayerModelTest("should_move_up_on_jump"));
		}
		
		private function wordSlotModel():void {
			addTest(new WordSlotModelTest("testUserCanGetAndSetWordToSpell"));
			addTest(new WordSlotModelTest("testSettingWordToSpellDispatchesChangeWordSlotEvent"));
			addTest(new WordSlotModelTest("testCorrectAdvanceWordCallDispatchesAdvanceWordSlotEvent"));
			addTest(new WordSlotModelTest("testUserCanCheckNextCharacterCodeAndAdvanceWord"));
			addTest(new WordSlotModelTest("testCompletingWordCallDispatchesFinishEvent"));
		}
		
		private function wordSlotLatcher():void {
			addTest(new WordSlotLatcherTest("test_accept_input_happy_case"));
			addTest(new WordSlotLatcherTest("test_accept_input_sad_case"));
			addTest(new WordSlotLatcherTest("should_type_words_from_multiple_different_slots_correctly"));
		}
		
		private function wordSlotHandlerModel():void {
			addTest(new WordSlotHandlerModelTest("should_correctly_assign_spellings_to_word_slots"));
			addTest(new WordSlotHandlerModelTest("testWordFinishReset"));
			addTest(new WordSlotHandlerModelTest("testDispatchEventOnWordComplete"));
			addTest(new WordSlotHandlerModelTest("should_reject_incorrect_constructor_parameters"));
		}
		
		
		private function inputOpperator():void {
			addTest(new InputOpperatorTest("should_call_acceptInput_on_its_IWordSlotHandlerModel_when_it_detects_a_key_press", _stage));
		}
		
		
		private function rectangleCollision():void {
			addTest(new RectangleCollisionTest("should_detect_correctly"));
			addTest(new RectangleCollisionTest("should_resolve_correctly"));
		}
	}
}