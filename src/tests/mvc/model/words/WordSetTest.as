package tests.mvc.model.words
{
	import asunitsrc.asunit.framework.TestCase;
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.model.words.WordSet;
	import kris.Util;
	import testhelpers.MockWordSlotModel;
	
	/**
	 * Tests all public behavior of the WordSetTest class.
	 * @author Kristian Welsh
	 */
	public class WordSetTest extends TestCase
	{
		private var _wordStrings:Vector.<String>;
		private var _wordSlots:Vector.<IWordSlotModel>;
		/**
		 * Start the test specified by the passed in string.
		 * @param	testMethod
		 */
		public function WordSetTest(testMethod:String):void
		{
			super(testMethod);
		}
		
		/**
		 * The constructor should throw an exception if the number of Strings you pass in is less than or equal to the number of WordSlots
		 */
		public function should_throw_exception_if_less_strings_than_slots():void
		{
			_wordStrings = new Vector.<String>();
			_wordSlots = new Vector.<IWordSlotModel>();
			
			assertThrows(Error, createInstance );
			
			_wordSlots.push(new MockWordSlotModel());
			
			assertThrows(Error, createInstance );
			
			_wordSlots.length = 0;
			_wordStrings.push("");
			
			createInstance(); // should not throw error
		}
		
		private function createInstance():WordSet
		{
			return new WordSet(_wordStrings, _wordSlots);
		}
		
		public function should_dispatch_event_on_word_complete():void
		{/*
			_wordStrings = Vector.<String>(["AAA", "BBB"]);
			_wordSlots = Vector.<IWordSlotModel>([new MockWordSlotModel()]);
			
			var instance:WordSet = new WordSet(_wordStrings, _wordSlots);
			
			_instance.initWordSlots();
			_instance.addEventListener(WordCompleteEvent.JUMP, recordJump);
			
			_instance.acceptInput(Util.toCharcode("A"));
			_instance.acceptInput(Util.toCharcode("A"));
			_instance.acceptInput(Util.toCharcode("A"));
			assertEquals("Dispatches a WordCompleteEvent.JUMP event when a word completes", 1, _numJumps);
			
			_instance.acceptInput(Util.toCharcode("B"));
			_instance.acceptInput(Util.toCharcode("B"));
			_instance.acceptInput(Util.toCharcode("B"));
			assertEquals("Dispatches a WordCompleteEvent.JUMP event when a word completes", 2, _numJumps);
			*/
		}
	}
}