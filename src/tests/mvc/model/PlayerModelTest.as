package tests.mvc.model
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	import com.events.EntityModelEvent;
	import flash.geom.Point;
	import testhelpers.MockWordSlotHandlerModel;
	
	// My imports
	import com.mvc.model.words.IWordSlotHandlerModel;
	import com.events.WordCompleteEvent;
	import com.mvc.model.PlayerModel;
	
	/**
	 * Tests all public behavior of the PlayerModelTest class.
	 * @author Kristian Welsh
	 */
	public class PlayerModelTest extends TestCase
	{
		private var _positionChangeEvents:Vector.<EntityModelEvent> = new Vector.<EntityModelEvent>();
		
		/**
		 * Start the test specified by the passed in string.
		 * @param	testMethod
		 */
		public function PlayerModelTest(testMethod:String):void
		{
			super(testMethod);
		}
		
		/**
		 * Tests that when a WordCompleteEvent.FINISH event is dispatched on handler, instance's y value decreases by 50
		 */
		public function should_move_up_on_jump():void
		{
			var handler:IWordSlotHandlerModel = new MockWordSlotHandlerModel();
			var instance:PlayerModel = new PlayerModel(new Point(0, 0), 0, 0, handler);
			
			handler.dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
			
			assertEquals("instance correctly responds to a WordCompleteEvent.FINISH from handler", -50, instance.y);
			
			instance = new PlayerModel(new Point(666, 500), 0, 0, handler);
			handler.dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
			assertEquals("instance correctly responds to a WordCompleteEvent.FINISH from handler", 450, instance.y);
			
			instance = new PlayerModel(new Point(666, -500), 0, 0, handler);
			handler.dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
			assertEquals("instance correctly responds to a WordCompleteEvent.FINISH from handler", -550, instance.y);
			
			instance = null;
			handler = null;
		}
		
		
	}
}