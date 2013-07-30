package tests.mvc.model
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	import com.events.EntityModelEvent;
	import com.mvc.model.EntityModel;
	
	/**
	 * Tests all public behavior of the EntityModelTest class.
	 * @author Kristian Welsh
	 */
	public class EntityModelTest extends TestCase
	{
		
		private var _positionChangeEvents:Array = [];
		
		/**
		 * Start the test specified by the passed in string.
		 * @param	testMethod
		 */
		public function EntityModelTest(testMethod:String):void
		{
			super(testMethod);
		}
		
		/**
		 * Tests that you can get correct x and y properties from the object.
		 */
		public function can_get_x_and_y():void
		{
			var instance:EntityModel = new EntityModel(0, 0, 0, 0);
			
			assertEquals("you get a correct x property from the object", 0, instance.x);
			assertEquals("you get a correct y property from the object", 0, instance.y);
			
			instance = new EntityModel(10, 10, 0, 0);
			assertEquals("you get a correct x property from the object", 10, instance.x);
			assertEquals("you get a correct y property from the object", 10, instance.y);
			
			instance = new EntityModel(-10, -10, 0, 0);
			assertEquals("you get a correct x property from the object", -10, instance.x);
			assertEquals("you get a correct y property from the object", -10, instance.y);
		}
		
		public function should_dispatch_position_change_event_when_moved():void
		{
			var instance:EntityModel = new EntityModel(0, 0, 0, 0);
			instance.addEventListener(EntityModelEvent.POSITION_CHANGE, recordPositionChange);
			
			instance.moveBy(0, 0);
			assertEquals("moving my zero doesnt change value", 1, _positionChangeEvents.length);
			
			assertEquals("dispatches the seccond event correctly", 2, _positionChangeEvents.length);
		}
		
		private function recordPositionChange(e:EntityModelEvent):void
		{
			_positionChangeEvents.push(e);
		}
	}
}