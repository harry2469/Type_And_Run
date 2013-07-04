package tests.events
{
	// Asunit imports
	import asunit.framework.TestCase;
	
	// Flash imports
	import flash.geom.Point;
	
	// My imports
	import com.events.WordSlotHandlerEvent;
	import com.mvc.model.WordSlotModel;
	
	/**
	 * Tests all public behavior of the WordSlotHandlerEvent class.
	 * @author Kristian Welsh
	 */
	public class WordSlotHandlerEventTest extends TestCase
	{
		/** Event type to pass into event. */
		private var _type:String = "";
		
		/** IWordSlotModel to pass into event. */
		private var _word:WordSlotModel = null;
		
		/** Point to pass into event. */
		private var _pos:Point = null;
		
		/** Instance of the event class to test. */
		private var _instance:WordSlotHandlerEvent = null;
		
		/**
		 * Start the test specified by the passed in string.
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
			_type = WordSlotHandlerEvent.CREATE;
			_word = new WordSlotModel();
			_pos = new Point(0, 0);
			_instance = new WordSlotHandlerEvent(_type, _word, _pos);
		}
		
		/**
		 * Tear down the test environment.
		 * Always called when test is destroyed.
		 */
		protected override function tearDown():void
		{
			_instance = null;
			_pos = null;
			_word = null;
		}
		
		/**
		 * Tests whether the event stores its custom data correctly.
		 */
		public function testDataRetention():void
		{
			//assertTrue("Can access the type property of the event.", _instance.type);
			//assertTrue("The type property of the event is a IWordSlotModel object.", _instance.type is String);
			assertEquals("The type property of the event is equal to the passed in type", _type, _instance.type);
			
			//assertTrue("Can access the newWord property of the event.", _instance.newWord);
			//assertTrue("The newWord property of the event is a IWordSlotModel object.", _instance.newWord is IWordSlotModel);
			assertEquals("The newWord property of the event is the passed in IWordSlotModel object.", _word, _instance.newWord);
			
			//assertTrue("Can access the position property of the event.", _instance.position);
			//assertTrue("The position property of the event is a Point object.", _instance.position is Point);
			assertTrue("The position property of the event is equal to the passed in value.", _instance.position.equals(_pos));
		}
		
		/**
		 * Tests whether a clone of the instance is equivalent to the instance itself.
		 */
		public function testClone():void
		{
			var newInstance:WordSlotHandlerEvent = _instance.clone() as WordSlotHandlerEvent;
			_instance = newInstance;
			testDataRetention();
		}
		
		/**
		 * Tests whether the string representation of the instance is as expected.
		 */
		public function testToString():void
		{
			assertEquals("The string representation of the instance is as expected.",
			"[WordSlotHandlerEvent type=\""
				+ WordSlotHandlerEvent.CREATE
				+ "\" newWord=" + _word.toString()
				+ " position=" + _pos.toString()
				+ " bubbles=false cancelable=false]",
			_instance.toString());
		}
	}
}