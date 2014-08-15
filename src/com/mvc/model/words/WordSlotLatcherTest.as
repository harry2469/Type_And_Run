package com.mvc.model.words {
	import asunit.framework.TestCase;
	import com.mvc.model.words.*;
	import com.SoundManager;
	import flash.events.Event;
	import kris.Util;

	/** @author Kristian Welsh */
	public class WordSlotLatcherTest extends TestCase {
		private static const NUM_WORDS:Number = 3;

		private const WORD_LIST:Vector.<String> = Vector.<String>(["AA", "AA", "BB"]);

		private var _wordSlots:Vector.<IWordSlotModel>;
		private var _instance:WordSlotLatcher;

		private var _numAdvancements:int = 0;
		private var _numNonAdvancements:int = 0;

		public function WordSlotLatcherTest(testMethod:String = null):void {
			super(testMethod);
		}

		protected override function setUp():void {
			_wordSlots = new Vector.<IWordSlotModel>();
			populateWordSlots();
			_instance = new WordSlotLatcher(_wordSlots, new MockWordSlotListener(), new SoundManager(), new Vector.<IWordSlotModel>());
			_numAdvancements = 0;
			_numNonAdvancements = 0;
		}

		private function populateWordSlots():void {
			for (var i:int = 0; i < NUM_WORDS; i++)
				populateIndex(i);
		}

		private function populateIndex(index:int):void {
			_wordSlots.push(new MockWordSlotModel(WORD_LIST[index]));
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

		public function test_user_types_without_mistakes():void {
			giveInputs("AA");

			assertEquals("Words receive an advanceWord call with the correct charCode the the correct number of times", 4, _numAdvancements);
			assertEquals("Words receive a failing external isNextCharacterCode call the correct number of times", 1, _numNonAdvancements);
		}

		public function test_user_makes_mistake_mid_word():void {
			giveInputs("AX");
			giveInputs("A");

			assertEquals("Words receive an advanceWord call with the correct charCode the the correct number of times", 4, _numAdvancements);
			assertEquals("Words receive a failing external isNextCharacterCode call the correct number of times", 4, _numNonAdvancements);
		}

		private function giveInputs(inputLetters:String):void {
			for (var i:int = 0; i < inputLetters.length; i++)
				_instance.acceptInput(Util.toCharcode(inputLetters.substr(i, 1)));
		}
	}
}