package tests.mvc.model.words {
	import asunitsrc.asunit.framework.TestCase;
	import com.mvc.model.words.*;
	import com.SoundManager;
	import flash.events.Event;
	import kris.Util;
	import testhelpers.*;

	/** @author Kristian Welsh */
	public class WordSlotLatcherTest extends TestCase {
		private static const NUM_WORDS:Number = 3;

		private var _wordList:Vector.<String> = Vector.<String>(["AAA", "ABB", "ABC", "XXX", "XYY", "XYZ"]);
		private var _wordSlots:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
		private var _instance:WordSlotLatcher;

		private var _numAdvancements:int = 0;
		private var _numNonAdvancements:int = 0;

		public function WordSlotLatcherTest(testMethod:String):void {
			super(testMethod);
		}

		protected override function setUp():void {
			populateWordSlots();
			_instance = new WordSlotLatcher(_wordSlots, new MockWordSlotListener(), new SoundManager(), new Vector.<IWordSlotModel>());
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
			_wordSlots[index].addEventListener(Event.ACTIVATE, function(e:Event):void {
					++_numAdvancements;
				});
			_wordSlots[index].addEventListener(Event.DEACTIVATE, function(e:Event):void {
					++_numNonAdvancements;
				});
		}

		/** User types one word without mistakes. */
		public function test_accept_input_happy_case():void {
			giveInputs("ABC");

			assertEquals("Words receive an advanceWord call with the correct charCode the the correct number of times", NUM_WORDS * 2, _numAdvancements);
			assertEquals("Words receive a failing external isNextCharacterCode call the correct number of times", NUM_WORDS - 1, _numNonAdvancements);
		}

		/** User starts typing a word correctly, but makes a mistake before finishing the word. */
		public function test_accept_input_sad_case():void {
			giveInputs("AX");
			giveInputs("A");

			assertEquals("Words receive an advanceWord call with the correct charCode the the correct number of times", NUM_WORDS * 2, _numAdvancements);
			assertEquals("Words receive a failing external isNextCharacterCode call the correct number of times", NUM_WORDS, _numNonAdvancements);
		}

		private function giveInputs(inputLetters:String):void {
			for (var i:int = 0; i < inputLetters.length; i++)
				_instance.acceptInput(Util.toCharcode(inputLetters.substr(i, 1)));
		}
	}
}