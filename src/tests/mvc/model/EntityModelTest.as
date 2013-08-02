package tests.mvc.model
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	import com.events.EntityModelEvent;
	import com.mvc.model.EntityModel;
	import flash.geom.Point;
	import org.flashdevelop.utils.FlashConnect;
	
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
		
		public function should_check_colliision_with_other_entitys_correctly():void
		{
			var callOn:EntityModel = new EntityModel(0, 0, 0, 0);
			var callWith:EntityModel = new EntityModel(0, 0, 0, 0);
			assertTrue("Calling isCollidingWith on itself should throw an error", collisionWithThrowsError(callOn, callOn));
			
			callOn = new EntityModel(0, 0, 0, 0);
			callWith = new EntityModel(0, 0, 0, 0);
			assertTrue("Calling isCollidingWith on entities at the same position should return true", callOn.isCollidingWith(callWith));
			
			callWith = new EntityModel(1, 1, 0, 0);
			assertFalse("Calling isCollidingWith on two points at the different positions should return false", callOn.isCollidingWith(callWith));
			
			callOn = new EntityModel(1, 1, 5, 5);
			callWith = new EntityModel(2, 2, 5, 5);
			assertTrue("Calling isCollidingWith on two intersecting non-point entities should return true", callOn.isCollidingWith(callWith));
			
			callOn = new EntityModel(1, 1, 5, 5);
			callWith = new EntityModel(6, 6, 5, 5);
			assertFalse("Calling isCollidingWith on two entities with corners at the same position should return false", callOn.isCollidingWith(callWith));
			
			callOn = new EntityModel(0, 0, 5, 5);
			callWith = new EntityModel(5, 0, 5, 5);
			assertFalse("Calling isCollidingWith on two entities with sides at the same position should return false", callOn.isCollidingWith(callWith));
		}
		
		private function collisionWithThrowsError(callOn:EntityModel, callWith:EntityModel):Boolean
		{
			try {
				callOn.isCollidingWith(callWith);
				return false; // doesnt get called if error is thrown
			} catch (error:Error) {
				return true;
			}
			return false; // should not reach this point
		}
		
		public function should_collide_with_other_entitys_correctly():void
		{
			var callOn:EntityModel = new EntityModel(0, 0, 0, 0);
			var callWith:EntityModel = new EntityModel(0, 0, 0, 0);
			assertTrue("Calling collideWith on itself should throw an error", collideWithThrowsError(callOn, callOn));
			assertFalse("Calling collideWith on itself should not throw an error", collideWithThrowsError(callOn, callWith));
			// TODO finish this method
		}
		
		private function collideWithThrowsError(callOn:EntityModel, callWith:EntityModel):Boolean
		{
			try {
				callOn.collideWith(callWith);
				return false; // doesnt get called if error is thrown
			} catch (error:Error) {
				return true;
			}
			return false; // should not reach this point
		}
	}
}