package tests.mvc.model
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	import com.events.ObstacleModelEvent;
	import com.mvc.model.ObstacleModel;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * Tests all public behavior of the ObstacleModelTest class.
	 * @author Kristian Welsh
	 */
	public class ObstacleModelTest extends TestCase
	{
		private var _positionChanges:Vector.<Point> = new Vector.<Point>;
		/**
		 * Start the test specified by the passed in string.
		 * @param	testMethod
		 */
		public function ObstacleModelTest(testMethod:String):void
		{
			super(testMethod);
		}
		
		/** When its position changes, it should dispatch an ObstacleModelEvent.POSITION_CHANGE event */
		public function should_dispatch_event_on_position_change():void
		{
			var instance:ObstacleModel = new ObstacleModel(100, 200, 25, 25);
			instance.addEventListener(ObstacleModelEvent.POSITION_CHANGE, logPositionChange);
			instance.moveBy(100, 0);
			
			assertEquals(
			"After changing the position of the instance once, one ObstacleModelEvent.POSITION_CHANGE event should have been dispatched",
			1, _positionChanges.length);
			
			assertTrue(
			"The dispatched event contains a point that is the corect new position of the instance",
			_positionChanges[0].equals( new Point(200, 200) ));
			
			
			instance = null;
		}
		
		private function logPositionChange(e:ObstacleModelEvent):void
		{
			_positionChanges.push(e.position);
		}
	}
}