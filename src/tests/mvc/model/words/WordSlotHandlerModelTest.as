package tests.mvc.model.words
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	import com.events.WordCompleteEvent;
	import com.mvc.model.words.WordSlotLatcher;
	import testhelpers.MockWordSlotModel;
	
	//Flash imports
	import flash.events.Event;
	
	//My imports
	import com.events.WordSlotEvent;
	import com.events.WordSlotHandlerEvent;
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.model.words.WordSlotHandlerModel;
	import kris.Util;
	
	/**
	 * Tests all public behavior of the WordSlotHandlerTest class.
	 * @author Kristian Welsh
	 */
	public class WordSlotHandlerModelTest extends TestCase
	{
		private const NUM_SLOTS:int = 3;
		
		// Object under test and its dependancies.
		private var _wordList:Vector.<String>;
		private var _wordSlots:Vector.<IWordSlotModel>;
		private var _latchedWordSlots:Vector.<IWordSlotModel>;
		private var _instance:WordSlotHandlerModel;
		
		// Member variables for setting whitin listeners to assist in testing.
		private var _createEventReturnedWords:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
		private var _numAdvancements:int = 0;
		private var _numNonAdvancements:int = 0;
		private var _numJumps:uint;
		
		/**
		 * Start the test specified by the passed in string.
		 * @param	testMethod
		 */
		public function WordSlotHandlerModelTest(testMethod:String):void
		{
			super(testMethod);
		}
		
		/**
		 * Set up the test environment.
		 * Always called when test is created.
		 */
		protected override function setUp():void
		{
			_wordList = Vector.<String>(["AAA", "ABB", "ABC", "Word4", "Word5", "Word6"]);
			_wordSlots = createWordSlotModelVector();
			_latchedWordSlots = new Vector.<IWordSlotModel>();
			_instance = new WordSlotHandlerModel(_wordList, _wordSlots);
		}
		
		private function createWordSlotModelVector():Vector.<IWordSlotModel>
		{
			var wordObjects:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
			for (var i:int = 0; i < NUM_SLOTS; i++)
			{
				wordObjects.push(new MockWordSlotModel() as IWordSlotModel);
			}
			return wordObjects;
		}
		
		/**
		 * Tear down the test environment.
		 * Always called when test is destroyed.
		 */
		protected override function tearDown():void
		{
			_instance.destroy();
		}
		
		/**
		 * Tests initWordSlots()
		 */
		public function testInitWordSlots():void
		{
			_instance.addEventListener(WordSlotHandlerEvent.CREATE, eventRecorder);
			_instance.initWordSlots();
			_instance.removeEventListener(WordSlotHandlerEvent.CREATE, eventRecorder);
			var returnedWords:Vector.<IWordSlotModel> = _createEventReturnedWords;
			
			assertEquals("initWordSlots created the right number of IWordSlots", returnedWords.length, _wordSlots.length);
			for (var i:int = 0; i < returnedWords.length; ++i)
			{
				assertTrue("The relayed new word slot is of type IWordSlotModel.", returnedWords[i] is IWordSlotModel);
				assertEquals("The relayed words have the same strings as the input words", _wordList[i], returnedWords[i].wordToSpell);
			}
		}
		
		private function eventRecorder(e:WordSlotHandlerEvent):void
		{
			_createEventReturnedWords.push(e.newWord);
		}
		
		/**
		 * Tests whether after initWordSlots() has been called that when a wordslot dispatches a WordSlotEvent.FINISH event, it receives a new spelling.
		 */
		public function testWordFinishReset():void
		{
			//i feel like this test misses something
			_instance.initWordSlots();
			var i:int;
			for (i = 0; i < NUM_SLOTS; ++i)
			{
				_wordSlots[i].dispatchEvent(new WordSlotEvent(WordSlotEvent.FINISH));
				assertEquals("Dispatching a FINISH event on the words gives it the next word in the passed in list", _wordSlots[i].wordToSpell, _wordList[i + NUM_SLOTS]);
			}
			for (i = 0; i < NUM_SLOTS; ++i)
			{
				_wordSlots[i].dispatchEvent(new WordSlotEvent(WordSlotEvent.FINISH));
				assertEquals("Dispatching a FINISH event on the words after you have used every word on the list wraps back arround to the start of the list", _wordSlots[i].wordToSpell, _wordList[i]);
			}
		}
		
		public function testDispatchEventOnWordComplete():void
		{
			_instance.initWordSlots();
			_instance.addEventListener(WordCompleteEvent.JUMP, recordJump);
			
			_wordSlots[0].advanceWord(Util.toCharcode("A"));
			_wordSlots[0].advanceWord(Util.toCharcode("A"));
			_wordSlots[0].advanceWord(Util.toCharcode("A"));
			assertEquals("Dispatches a WordCompleteEvent.JUMP event when a word completes", 1, _numJumps);
			
			_wordSlots[1].advanceWord(Util.toCharcode("A"));
			_wordSlots[1].advanceWord(Util.toCharcode("B"));
			_wordSlots[1].advanceWord(Util.toCharcode("B"));
			assertEquals("Dispatches a WordCompleteEvent.JUMP event when a word completes", 2, _numJumps);
			
			_wordSlots[2].advanceWord(Util.toCharcode("A"));
			_wordSlots[2].advanceWord(Util.toCharcode("B"));
			_wordSlots[2].advanceWord(Util.toCharcode("C"));
			assertEquals("Dispatches a WordCompleteEvent.JUMP event when a word completes", 3, _numJumps);
		}
		
		private function recordJump(e:WordCompleteEvent):void
		{
			_numJumps++;
		}
	}
}