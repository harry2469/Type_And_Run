package tests {
	import asunitsrc.asunit.framework.*;
	import flash.display.*;
	import tests.kris.*;
	import tests.mvc.controller.*;
	import tests.mvc.model.*;
	import tests.mvc.model.words.*;
	
	/** @author Kristian Welsh */
	public class AllTests extends TestSuite {
		
		public function AllTests() {
			super();
			
			entityModel();
			wordSlotModel();
			wordSlotLatcher();
			wordSlotListener();
			
			inputOpperator();
			
			rectangleCollision();
		}
		
		private function entityModel():void {
			addTest(new EntityModelTest("should_dispatch_position_change_event_when_moved"));
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
		}
		
		private function wordSlotListener():void {
			addTest(new WordSlotListenerTest("should_reset_word_when_word_finishes"));
			addTest(new WordSlotListenerTest("should_dispatch_event_when_word_completes"));
		}
		
		private function inputOpperator():void {
			addTest(new InputOpperatorTest("should_call_acceptInput_with_correct_keycode_on_its_IWordSlotHandlerModel_when_it_detects_a_key_press"));
		}
		
		
		private function rectangleCollision():void {
			// detect
			addTest(new RectangleCollisionTest("detect_should_throw_error_when_both_arguments_are_the_same_object"));
			addTest(new RectangleCollisionTest("calling_detect_on_intersecting_rectangles_should_return_true"));
			addTest(new RectangleCollisionTest("calling_detect_on_rectangles_with_a_touching_side_should_return_false"));
			// resolve
			addTest(new RectangleCollisionTest("calling_resolve_should_throw_error_when_both_arguments_are_the_same_object"));
			addTest(new RectangleCollisionTest("calling_reslove_on_not_colliding_rectangles_returns_reactionary"));
			addTest(new RectangleCollisionTest("should_reslove_to_left_correctly_1"));
			addTest(new RectangleCollisionTest("should_reslove_to_left_correctly_2"));
			addTest(new RectangleCollisionTest("should_reslove_to_right_correctly_1"));
			addTest(new RectangleCollisionTest("should_reslove_to_right_correctly_2"));
			addTest(new RectangleCollisionTest("should_reslove_to_top_correctly_1"));
			addTest(new RectangleCollisionTest("should_reslove_to_top_correctly_2"));
			addTest(new RectangleCollisionTest("should_reslove_to_bottom_correctly_1"));
			addTest(new RectangleCollisionTest("should_reslove_to_bottom_correctly_2"));
		}
	}
}