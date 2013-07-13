package tests.events
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	
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
			_instance = new WordSlotHandlerEvent(_type, _word);
		}
		
		/**
		 * Tear down the test environment.
		 * Always called when test is destroyed.
		 */
		protected override function tearDown():void
		{
			_instance = null;
			_word = null;
		}
		
		/**
		 * Tests whether the event stores its custom data correctly.
		 */
		public function testDataRetention():void
		{
			assertEquals("The type property of the event is equal to the passed in type", _type, _instance.type);
			
			assertEquals("The newWord property of the event is the passed in IWordSlotModel object.", _word, _instance.newWord);
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
	}
}