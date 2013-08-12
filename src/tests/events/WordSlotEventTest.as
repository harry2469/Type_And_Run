package tests.events
{
	import asunitsrc.asunit.framework.TestCase;
	import com.events.WordSlotEvent;
	
	public class WordSlotEventTest extends TestCase
	{
		private var _eventType:String = WordSlotEvent.ADVANCE;
		private var _instance:WordSlotEvent = new WordSlotEvent(_eventType);
		
		public function WordSlotEventTest(testMethod:String):void {
			super(testMethod);
		}
		
		public function test_data_retrieval():void {
			assertEquals("The type property of the event is equal to the passed in type", _eventType, _instance.type);
		}
		
		public function test_clone():void {
			var _instanceClone:WordSlotEvent = _instance.clone() as WordSlotEvent;
			assertEquals("The type property of the event is equal to the passed in type", _instance.type, _instanceClone.type);
		}
	}
}