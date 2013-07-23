package tests.mvc.view
{
	// Flash imports
	import flash.display.Stage;
	import flash.geom.Point;
	
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	
	// My imports
	import com.mvc.model.PlayerModel;
	import com.mvc.view.PlayerView;
	import com.mvc.model.IPlayerModel;
	import com.mvc.model.words.WordSlotHandlerModel;
	
	/**
	 * Tests all public behavior of the PlayerViewTest class.
	 * @author Kristian Welsh
	 */
	public class PlayerViewTest extends TestCase
	{
		private var _stage:Stage;
		/**
		 * Start the test specified by the passed in string.
		 * @param	testMethod
		 */
		public function PlayerViewTest(testMethod:String, stage:Stage):void
		{
			_stage = stage;
			super(testMethod);
		}
		
		/**
		 * Tests the positioning of the art
		 */
		public function testArtPositioning():void
		{
			//positive
			var instance:PlayerView = new PlayerView(_stage, new MockPlayerModel(180,50));
			assertEquals("The art of the player view is placed at the correct x location.", 180, instance.x);
			assertEquals("The art of the player view is placed at the correct y location.", 50, instance.y);
			instance.destroy();
			
			//negative
			instance = new PlayerView(_stage, new MockPlayerModel(-7536,-29));
			assertEquals("The art of the player view is placed at the correct x location.", -7536, instance.x);
			assertEquals("The art of the player view is placed at the correct y location.", -29, instance.y);
			instance.destroy();
			
			//zero
			instance = new PlayerView(_stage, new MockPlayerModel(0,0));
			assertEquals("The art of the player view is placed at the correct x location.", 0, instance.x);
			assertEquals("The art of the player view is placed at the correct y location.", 0, instance.y);
			instance.destroy();
		}
		
		public function should_update_art_position_when_model_dispatches_change_position_event():void
		{
			//settup
			var model:MockPlayerModel = new MockPlayerModel(180, 50);
			var instance:PlayerView = new PlayerView(_stage, model);
			
			//positive
			model.pos = new Point(400, 200);
			model.dispatchChangePositionEvent();
			assertEquals("Works with positive values for X", 400, instance.x);
			assertEquals("Works with positive values for Y", 200, instance.y);
			
			//negative
			model.pos = new Point(-123, -321);
			model.dispatchChangePositionEvent();
			assertEquals("Works with negative values for X", -123, instance.x);
			assertEquals("Works with negative values for Y", -321, instance.y);
			
			//zero
			model.pos = new Point(0, 0);
			model.dispatchChangePositionEvent();
			assertEquals("Works with 0 value for X", 0, instance.x);
			assertEquals("Works with 0 value for Y", 0, instance.y);
			
			//teardown
			instance.destroy();
		}
	}
}

// My imports
import com.events.PlayerModelEvent;
import com.mvc.model.IPlayerModel;
import flash.events.EventDispatcher;
import flash.geom.Point;

class MockPlayerModel extends EventDispatcher implements IPlayerModel
{
	private var _pos:Point = new Point();
	
	public function MockPlayerModel(x:Number, y:Number):void
	{
		_pos.x = x;
		_pos.y = y;
	}
	
	public function set pos(value:Point):void { _pos = value; }
	
	public function get x():Number { return _pos.x; }
	public function get y():Number { return _pos.y; }
	
	public function dispatchChangePositionEvent():void
	{
		dispatchEvent(new PlayerModelEvent(PlayerModelEvent.CHANGE_POSITION, _pos));
	}
}