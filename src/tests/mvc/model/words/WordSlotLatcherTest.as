package tests.mvc.model.words {
	import asunitsrc.asunit.framework.TestCase;
	import com.events.WordSlotEvent;
	import com.mvc.model.words.IWordSlotModel;
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
		
		private var _wordList:Vector.<String> = Vector.<String>(["AAA", "ABB", "ABC", "XXX", "XYY", "XYZ"]);
		private var _wordSlots:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
		private var _instance:WordSlotLatcher;
		private var _handler:MockWordSlotHandlerModel;
		
		private var _numAdvancements:int = 0;
		private var _numNonAdvancements:int = 0;
		private var _numFinished:int = 0;
		
		public function WordSlotLatcherTest(testMethod:String):void {
			super(testMethod);
		}
		
		protected override function setUp():void {
			populateWordSlots();
			_handler = new MockWordSlotHandlerModel(_wordSlots);
			_instance = new WordSlotLatcher(_handler, new Vector.<IWordSlotModel>());
		}
		
		private function populateWordSlots():void {
			for (var i:int = 0; i < NUM_WORDS; i++)
				populateIndex(i);
		}
		
		private function populateIndex(index:int):void {
			_wordSlots.push(new MockWordSlotModel(_wordList[index]));
			listenToWordSlotAtIndex(index);
		}
		
		private function listenToWordSlotAtIndex(index:int):void {
			_wordSlots[index].addEventListener(Event.ACTIVATE, function(e:Event):void { ++_numAdvancements; });
			_wordSlots[index].addEventListener(Event.DEACTIVATE, function(e:Event):void { ++_numNonAdvancements; });
			_wordSlots[index].addEventListener(WordSlotEvent.FINISH, function(e:WordSlotEvent):void { ++_numFinished; });
		}
		
		/** User types one word without mistakes. */
		public function test_accept_input_happy_case():void {
			giveInputs("ABC");
			
			assertEquals("Words receive an advanceWord call with the correct charCode the the correct number of times", NUM_WORDS*2, _numAdvancements);
			assertEquals("Words receive a failing external isNextCharacterCode call the correct number of times", NUM_WORDS-1, _numNonAdvancements);
		}
		
		/** User starts typing a word correctly, but makes a mistake before finishing the word. */
		public function test_accept_input_sad_case():void {
			giveInputs("AX");
			
			assertEquals("Words receive an advanceWord call with the correct charCode the the correct number of times", NUM_WORDS, _numAdvancements);
			assertEquals("Words receive a failing external isNextCharacterCode call the correct number of times", NUM_WORDS, _numNonAdvancements);
		}
		
		/** User starts types a word correctly, then types a word form a different wordSlot correctly. */
		public function should_type_words_from_multiple_different_slots_correctly():void {
			giveInputs("ABC");
			_handler.finishWord();
			giveInputs("ABB");
			
			assertEquals(2, _numFinished);
		}
		
		private function giveInputs(inputLetters:String):void {
			for (var i:int = 0; i < inputLetters.length; i++)
				_instance.acceptInput(Util.toCharcode(inputLetters.substr(i, 1)));
		}
	}
}