package tests.events
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	
	// Flash imports
	import flash.geom.Point;
	
	// My imports
	import com.events.WordSlotHandlerEvent;
	import com.mvc.model.words.WordSlotModel;
	
	/**
	 * Tests all public behavior of the WordSlotHandlerEvent class.
	 * @author Kristian Welsh
	 */
	public class WordSlotHandlerEventTest extends TestCase
	{
		private var _eventType:String = "";
		private var _wordSlot:WordSlotModel = null;
		private var _instance:WordSlotHandlerEvent = null;
		
		/**
		 * Start the passed in test.
		 * @param	testMethod
		 */
		public function WordSlotHandlerEventTest(testMethod:String):void
		{
			super(testMethod);
		}
		
		/**
		 * Set up the test environment.
		 * Always called when test is created.
		 */
		protected override function setUp():void
		{
			_eventType = WordSlotHandlerEvent.CREATE;
			_wordSlot = new WordSlotModel();
			_instance = new WordSlotHandlerEvent(_eventType, _wordSlot);
		}
		
		protected override function tearDown():void { }
		
		/**
		 * Tests whether the event stores its custom data correctly.
		 */
		public function testDataRetention():void
		{
			assertEquals("The type property of the event is equal to the passed in type", _eventType, _instance.type);
			assertEquals("The newWord property of the event is the passed in IWordSlotModel object.", _wordSlot, _instance.newWord);
		}
		
		/**
		 * Tests whether a clone of the instance is equivalent to the instance itself.
		 */
		public function testClone():void
		{
			var newInstance:WordSlotHandlerEvent = _instance.clone() as WordSlotHandlerEvent;
			assertEquals("The type property of the event is equal to the passed in type", _instance.type, newInstance.type);
			assertEquals("The newWord property of the event is the passed in IWordSlotModel object.", _instance.newWord, newInstance.newWord);
		}
	}
}