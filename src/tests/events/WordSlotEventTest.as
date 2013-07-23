package tests.events
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	
	// My imports
	import com.events.WordSlotEvent;
	
	/**
	 * Tests all public behavior of the WordSlotEventTest class.
	 * @author Kristian Welsh
	 */
	public class WordSlotEventTest extends TestCase
	{
		/** Every event type to pass into the events. */
		private var _type:String = "";
		
		/** Every event to test */
		private var _instance:WordSlotEvent = null;
		private var _instanceClone:WordSlotEvent = null;
		
		/**
		 * Start the test specified by the passed in string.
		 * @param	testMethod
		 */
		public function WordSlotEventTest(testMethod:String):void
		{
			super(testMethod);
		}
		
		/**
		 * Set up the test environment.
		 * Always called when test is created.
		 */
		protected override function setUp():void
		{
			_type = WordSlotEvent.ADVANCE;
			_instance = new WordSlotEvent(_type);
			_instanceClone = _instance.clone() as WordSlotEvent;
		}
		
		protected override function tearDown():void { }
		
		/**
		 * Tests whether the event stores its custom data correctly.
		 */
		public function testDataRetention():void
		{
			assertEquals("The type property of the event is equal to the passed in type", _type, _instance.type);
		}
		
		/**
		 * Tests whether a clone of the instance has retained the stored values of the cloned instace
		 */
		public function testClone():void
		{
			assertEquals("The type property of the event is equal to the passed in type", _instance.type, _instanceClone.type);
		}
	}
}