package tests.events
{
	import asunitsrc.asunit.framework.TestCase;
	import com.events.WordSlotHandlerEvent;
	import testhelpers.MockWordSlotModel;
	
	public class WordSlotHandlerEventTest extends TestCase
	{
		private var _eventType:String = WordSlotHandlerEvent.CREATE;
		private var _wordSlot:MockWordSlotModel = new MockWordSlotModel();
		private var _instance:WordSlotHandlerEvent = new WordSlotHandlerEvent(_eventType, _wordSlot);
		
		public function WordSlotHandlerEventTest(testMethod:String):void {
			super(testMethod);
		}
		
		public function test_data_retrieval():void {
			assertEquals("The type property of the event is equal to the passed in type", _eventType, _instance.type);
			assertEquals("The newWord property of the event is the passed in IWordSlotModel object.", _wordSlot, _instance.newWord);
		}
		
		public function test_clone():void {
			var clone:WordSlotHandlerEvent = _instance.clone() as WordSlotHandlerEvent;
			assertEquals("The type property of the event is equal to the passed in type", _instance.type, clone.type);
			assertEquals("The newWord property of the event is the passed in IWordSlotModel object.", _instance.newWord, clone.newWord);
		}
	}
}