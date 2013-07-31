package tests.mvc.model
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	import com.events.EntityModelEvent;
	import com.mvc.model.EntityModel;
	import flash.geom.Point;
	
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
		 * Tests that you can get correct x property from the object.
		 */
		public function can_get_x():void
		{
			var instance:EntityModel = new EntityModel(0, 0, 0, 0);
			assertEquals("you get a correct x property from the object for zero values", 0, instance.x);
			
			instance = new EntityModel(10, 0, 0, 0);
			assertEquals("you get a correct x property from the object for positive values", 10, instance.x);
			
			instance = new EntityModel(-10, 0, 0, 0);
			assertEquals("you get a correct x property from the object for negative values", -10, instance.x);
		}
		
		/**
		 * Tests that you can get correct y property from the object.
		 */
		public function can_get_y():void
		{
			var instance:EntityModel = new EntityModel(0, 0, 0, 0);
			assertEquals("you get a correct y property from the object for zero values", 0, instance.y);
			
			instance = new EntityModel(0, 10, 0, 0);
			assertEquals("you get a correct y property from the object for positive values", 10, instance.y);
			
			instance = new EntityModel(0, -10, 0, 0);
			assertEquals("you get a correct y property from the object for negative values", -10, instance.y);
		}
		
		/**
		 * Tests that you can get correct width property from the object.
		 */
		public function can_get_width():void
		{
			var instance:EntityModel = new EntityModel(0, 0, 0, 0);
			assertEquals("you get a correct width property from the object for zero values", 0, instance.width);
			
			instance = new EntityModel(0, 0, 10, 0);
			assertEquals("you get a correct width property from the object for positive values", 10, instance.width);
			
			instance = new EntityModel(0, 0, -10, 0);
			assertEquals("you get a correct width property from the object for negative values", -10, instance.width);
		}
		
		/**
		 * Tests that you can get correct height property from the object.
		 */
		public function can_get_height():void
		{
			var instance:EntityModel = new EntityModel(0, 0, 0, 0);
			assertEquals("you get a correct height property from the object for zero values", 0, instance.height);
			
			instance = new EntityModel(0, 0, 0, 10);
			assertEquals("you get a correct height property from the object for positive values", 10, instance.height);
			
			instance = new EntityModel(0, 0, 0, -10);
			assertEquals("you get a correct height property from the object for negative values", -10, instance.height);
		}
		
		public function should_dispatch_position_change_event_when_moved():void
		{
			var instance:EntityModel = new EntityModel(0, 0, 0, 0);
			instance.addEventListener(EntityModelEvent.POSITION_CHANGE, recordPositionChange);
			
			instance.moveBy(0, 0);
			assertEquals("moving by zero doesnt dispatch an event", 0, _positionChangeEvents.length);
			
			instance.moveBy(1, 1);
			assertEquals("moving by a positive value dispatches an event", 1, _positionChangeEvents.length);
			
			instance.moveBy(-1, -1);
			assertEquals("moving by a negative value dispatches an event", 2, _positionChangeEvents.length);
			
			_positionChangeEvents.length = 0;
			instance.moveBy(30, 80);
			assertEquals("dispatched events contain the current position of the instance, x", 30, _positionChangeEvents[0].x);
			assertEquals("dispatched events contain the current position of the instance, y", 80, _positionChangeEvents[0].y);
		}
		
		private function recordPositionChange(e:EntityModelEvent):void
		{
			_positionChangeEvents.push(e);
		}
	}
}