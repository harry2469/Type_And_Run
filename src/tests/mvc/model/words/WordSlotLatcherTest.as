package tests.mvc.model.words
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	import com.events.WordCompleteEvent;
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.model.words.WordSlotHandlerModel;
	import com.mvc.model.words.WordSlotLatcher;
	import flash.events.Event;
	import kris.Util;
	import testhelpers.MockWordSlotHandlerModel;
	import testhelpers.MockWordSlotModel;
	
	/**
	 * Tests all public behavior of the WordSlotLatcherTest class.
	 * @author Kristian Welsh
	 */
	public class WordSlotLatcherTest extends TestCase
	{
		static public const NUM_WORDS:Number = 3;
		
		// Object under test and its dependancies.
		private var _wordList:Vector.<String>;
		private var _wordSlots:Vector.<IWordSlotModel>;
		private var _latchedWordSlots:Vector.<IWordSlotModel>;
		private var _instance:WordSlotLatcher;
		
		// Member variables for setting whitin listeners to assist in testing.
		private var _createEventReturnedWords:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
		private var _numAdvancements:int = 0;
		private var _numNonAdvancements:int = 0;
		private var _numJumps:uint;
		
		/**
		 * Start the test specified by the passed in string.
		 * @param	testMethod
		 */
		public function WordSlotLatcherTest(testMethod:String):void
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
			_instance = new WordSlotLatcher(new MockWordSlotHandlerModel(_wordSlots), new Vector.<IWordSlotModel>());
		}
		
		private function createWordSlotModelVector():Vector.<IWordSlotModel>
		{
			var wordObjects:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
			for (var i:int = 0; i < NUM_WORDS; i++)
			{
				wordObjects.push(new MockWordSlotModel(_wordList[i]) as IWordSlotModel);
			}
			return wordObjects;
		}
		
		/**
		 * Tests acceptInput()'s behaviour in the case that the user types a word without mistakes.
		 */
		public function testAcceptInputHappyCase1():void
		{
			for (var i:int = 0; i < _wordSlots.length; ++i)
			{
				_wordSlots[i].wordToSpell = _wordList[i];
				_wordSlots[i].addEventListener(Event.ACTIVATE, recordAdvancement);
				_wordSlots[i].addEventListener(Event.DEACTIVATE, recordNonAdvancement);
			}
			
			_instance.acceptInput(Util.toCharcode("A"));
			_instance.acceptInput(Util.toCharcode("B"));
			_instance.acceptInput(Util.toCharcode("C"));
			
			assertEquals("Words receive an advanceWord call with the correct charCode the the correct number of times", NUM_WORDS*2, _numAdvancements);
			assertEquals("Words receive a failing external isNextCharacterCode call the correct number of times", NUM_WORDS-1, _numNonAdvancements);
			
		}
		
		/**
		 * Tests acceptInput()'s behaviour in the case that the user starts typing a word correctly, but makes a mistake before finishing the word.
		 */
		public function testAcceptInputSadCase1():void
		{
			for (var i:int = 0; i < _wordSlots.length; ++i)
			{
				_wordSlots[i].wordToSpell = _wordList[i];
				_wordSlots[i].addEventListener(Event.ACTIVATE, recordAdvancement);
				_wordSlots[i].addEventListener(Event.DEACTIVATE, recordNonAdvancement);
			}
			
			_instance.acceptInput(Util.toCharcode("A"));
			_instance.acceptInput(Util.toCharcode("X"));
			
			assertEquals("Words receive an advanceWord call with the correct charCode the the correct number of times", NUM_WORDS, _numAdvancements);
			assertEquals("Words receive a failing external isNextCharacterCode call the correct number of times", NUM_WORDS, _numNonAdvancements);
		}
		
		private function recordAdvancement(e:Event):void
		{
			++_numAdvancements
		}
		
		private function recordNonAdvancement(e:Event):void
		{
			++_numNonAdvancements
		}
		
		private function recordJump(e:WordCompleteEvent):void
		{
			_numJumps++
		}
	}
}