package tests.mvc.model
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	import com.events.PlayerModelEvent;
	import org.flashdevelop.utils.FlashConnect;
	
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
		private var _positionChangeEvents:Vector.<PlayerModelEvent> = new Vector.<PlayerModelEvent>();
		
		/**
		 * Start the test specified by the passed in string.
		 * @param	testMethod
		 */
		public function PlayerModelTest(testMethod:String):void
		{
			super(testMethod);
		}
		
		/**
		 * Tests that you can get correct x and y properties from the object
		 */
		public function testCanGetXAndY():void
		{
			var handler:IWordSlotHandlerModel = new MockWordSlotHandlerModel();
			var instance:PlayerModel = new PlayerModel(0, 0, handler);
			
			assertEquals("you get a correct x property from the object", 0, instance.x);
			assertEquals("you get a correct y property from the object", 0, instance.y);
			
			instance = new PlayerModel(10, 10, handler);
			assertEquals("you get a correct x property from the object", 10, instance.x);
			assertEquals("you get a correct y property from the object", 10, instance.y);
			
			instance = new PlayerModel(-10, -10, handler);
			assertEquals("you get a correct x property from the object", -10, instance.x);
			assertEquals("you get a correct y property from the object", -10, instance.y);
			
			instance = null;
			handler = null;
		}
		
		/**
		 * Tests that when a WordCompleteEvent.FINISH event is dispatched on handler, instance's y value decreases by 50
		 */
		public function testJump():void
		{
			var handler:IWordSlotHandlerModel = new MockWordSlotHandlerModel();
			var instance:PlayerModel = new PlayerModel(0, 0, handler);
			
			handler.dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
			
			assertEquals("instance correctly responds to a WordCompleteEvent.FINISH from handler", -50, instance.y);
			
			instance = new PlayerModel(666, 500, handler);
			handler.dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
			assertEquals("instance correctly responds to a WordCompleteEvent.FINISH from handler", 450, instance.y);
			
			instance = new PlayerModel(666, -500, handler);
			handler.dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
			assertEquals("instance correctly responds to a WordCompleteEvent.FINISH from handler", -550, instance.y);
			
			instance = null;
			handler = null;
		}
		
		public function should_dispatch_position_change_event_on_jump():void
		{
			var handler:IWordSlotHandlerModel = new MockWordSlotHandlerModel();
			var instance:PlayerModel = new PlayerModel(0, 0, handler);
			instance.addEventListener(PlayerModelEvent.CHANGE_POSITION, recordPositionChange);
			
			handler.dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
			assertEquals("dispatches the first event correctly", 1, _positionChangeEvents.length);
			
			handler.dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
			assertEquals("dispatches the seccond event correctly", 2, _positionChangeEvents.length);
		}
		
		private function recordPositionChange(e:PlayerModelEvent):void
		{
			FlashConnect.trace("TRACE");
			_positionChangeEvents.push(e);
		}
	}
}
import com.events.WordCompleteEvent;
import com.mvc.model.words.IWordSlotHandlerModel;
import flash.events.EventDispatcher;

class MockWordSlotHandlerModel extends EventDispatcher implements IWordSlotHandlerModel
{
	public function acceptInput(charCode:int):void { }
	public function initWordSlots():void { }
	public function finishWord():void
	{
		dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
	}
}