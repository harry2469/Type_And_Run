package tests.mvc.model
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	import com.events.EntityModelEvent;
	import com.mvc.model.EntityModel;
	import flash.geom.Point;
	import kris.Dimentions;
	
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
			assertEquals("moving by a zero value dispatches an event", 1, _positionChangeEvents.length);
			_positionChangeEvents.length = 0;
			
			instance.moveBy(1, 1);
			assertEquals("moving by a positive value dispatches an event", 1, _positionChangeEvents.length);
			_positionChangeEvents.length = 0;
			
			instance.moveBy(-1, -1);
			assertEquals("moving by a negative value dispatches an event", 1, _positionChangeEvents.length);
			_positionChangeEvents.length = 0;
			
			instance.moveBy(30, 80);
			assertEquals("dispatched events contain the current position of the instance, x", 30, _positionChangeEvents[0].x);
			assertEquals("dispatched events contain the current position of the instance, y", 80, _positionChangeEvents[0].y);
		}
		
		private function recordPositionChange(e:EntityModelEvent):void
		{
			_positionChangeEvents.push(e);
		}
		
		private function newModel(x:Number = 0, y:Number = 0, w:Number = 0, h:Number = 0):EntityModel {
			return new EntityModel(x, y, w, h);
		}
	}
}