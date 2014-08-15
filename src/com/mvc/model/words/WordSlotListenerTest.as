package com.mvc.model.words {
	import asunit.framework.TestCase;
	import com.events.WordSlotEvent;
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.model.words.WordSlotListener;
	import flash.events.Event;
	import kris.Util;
	import com.mvc.model.words.MockWordSlotModel;

	public class WordSlotListenerTest extends TestCase {
		private const NUM_SLOTS:int = 3;

		private var _wordList:Vector.<String> = Vector.<String>(["AAA", "ABB", "ABC", "XXX", "XYY", "XYZ"]);
		private var _wordSlots:Vector.<IWordSlotModel>;
		private var _instance:WordSlotListener;

		protected override function setUp():void {
			createWordSlotModelVector();
			_instance = new WordSlotListener(_wordList, _wordSlots);
			_instance.listen();
		}

		private function createWordSlotModelVector():void {
			_wordSlots = new Vector.<IWordSlotModel>();
			for (var i:int = 0; i < NUM_SLOTS; i++)
				_wordSlots.push(new MockWordSlotModel(_wordList[i]));
		}

		public function test_reset_word_when_word_completes():void {
			// extract class?
			var i:int;
			for (i = 0; i < NUM_SLOTS; ++i) {
				_wordSlots[i].dispatchEvent(new WordSlotEvent(WordSlotEvent.FINISH));
				assertEquals("Dispatching a FINISH event on the words gives it the next word in the passed in list", _wordList[i + NUM_SLOTS], _wordSlots[i].wordToSpell);
			}
			for (i = 0; i < NUM_SLOTS; ++i) {
				_wordSlots[i].dispatchEvent(new WordSlotEvent(WordSlotEvent.FINISH));
				assertEquals("Dispatching a FINISH event on the words after you have used every word on the list wraps back arround to the start of the list", _wordList[i], _wordSlots[i].wordToSpell);
			}
		}

		public function test_dispatch_event_when_word_completes():void {
			var numJumps:int = 0;
			_instance.addEventListener("test", function(e:Event):void {
					numJumps++
				});

			_wordSlots[0].dispatchEvent(new WordSlotEvent(WordSlotEvent.FINISH));
			assertEquals("Dispatches a WordCompleteEvent.JUMP event when a word completes", 1, numJumps);
		}

		private function advance(wordSlot:IWordSlotModel, inputLetters:String):void {
			for (var i:int = 0; i < inputLetters.length; i++)
				wordSlot.advanceWord(Util.toCharcode(inputLetters.substr(i, 1)));
		}
	}
}