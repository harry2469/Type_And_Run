package tests.mvc.model
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	import com.events.EntityModelEvent;
	import com.mvc.model.EntityModel;
	import flash.geom.Point;
	import kris.Dimentions;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * Tests all public behavior of the EntityModelTest class.
	 * @author Kristian Welsh
	 */
	public class EntityModelTest extends TestCase
	{
		private static const DIMENTIONS_0:Dimentions = new Dimentions(0, 0);
		private static const POSITION_0:Point = new Point(0, 0);
		
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
			var instance:EntityModel = newModel();
			assertEquals("you get a correct x property from the object for zero values", 0, instance.x);
			
			instance = newModel(10);
			assertEquals("you get a correct x property from the object for positive values", 10, instance.x);
			
			instance = newModel(-10);
			assertEquals("you get a correct x property from the object for negative values", -10, instance.x);
		}
		
		/**
		 * Tests that you can get correct y property from the object.
		 */
		public function can_get_y():void
		{
			var instance:EntityModel = newModel();
			assertEquals("you get a correct y property from the object for zero values", 0, instance.y);
			
			instance = newModel(0, 10);
			assertEquals("you get a correct y property from the object for positive values", 10, instance.y);
			
			instance = newModel(0, -10);
			assertEquals("you get a correct y property from the object for negative values", -10, instance.y);
		}
		
		public function should_dispatch_position_change_event_when_moved():void
		{
			var instance:EntityModel = newModel();
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
			var callOn:EntityModel = newModel();
			var callWith:EntityModel = newModel();
			assertTrue("Calling isCollidingWith on itself should throw an error", tryFunction(callOn.collideWith, callOn));
			
			callOn = newModel();
			callWith = newModel();
			assertTrue("Calling isCollidingWith on entities at the same position should return true", areColliding(callOn, callWith));
			
			callOn = newModel();
			callWith = newModel(1, 1);
			assertFalse("Calling isCollidingWith on two points at the different positions should return false", areColliding(callOn, callWith));
			
			callOn = newModel(1, 1, 5, 5);
			callWith = newModel(2, 2, 5, 5);
			assertTrue("Calling isCollidingWith on two intersecting non-point entities should return true", areColliding(callOn, callWith));
			
			callOn = newModel(1, 1, 5, 5);
			callWith = newModel(6, 6, 5, 5);
			assertFalse("Calling isCollidingWith on two entities with corners at the same position should return false", areColliding(callOn, callWith));
			
			callOn = newModel(0, 0, 5, 5);
			callWith = newModel(5, 0, 5, 5);
			assertFalse("Calling isCollidingWith on two entities with a touching side should return false", areColliding(callOn, callWith));
		}
		
		public function should_collide_with_other_entitys_correctly():void
		{
			var callOn:EntityModel = newModel();
			var callWith:EntityModel = newModel();
			assertTrue("Calling collideWith on itself should throw an error", tryFunction(callOn.isCollidingWith, callOn));
			assertFalse("Calling collideWith on itself should not throw an error", tryFunction(callOn.isCollidingWith, callWith));
			// TODO finish this method
		}
		
		private function newModel(x:Number = 0, y:Number = 0, w:Number = 0, h:Number = 0):EntityModel
		{
			return new EntityModel(new Point(x, y), new Dimentions(w, h));
		}
		
		private function areColliding(entity1:EntityModel, entity2:EntityModel):Boolean
		{
			return entity1.isCollidingWith(entity2);
		}
		
		private function tryFunction(func:Function, ... args):Boolean
		{
			try {
				func.apply(null, args);
				return false; // doesnt get called if error is thrown
			} catch (error:Error) {
				return true;
			}
			return false; // should not reach this point
		}
	}
}