package tests.mvc.model.words {
	import asunitsrc.asunit.framework.TestCase;
	import com.events.WordCompleteEvent;
	import com.events.WordSlotEvent;
	import com.events.WordSlotHandlerEvent;
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.model.words.WordSlotHandlerModel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import kris.Util;
	import testhelpers.MockWordSlotModel;
	
	public class WordSlotHandlerModelTest extends TestCase {
		private const NUM_SLOTS:int = 3;
		
		private var _wordList:Vector.<String> = Vector.<String>(["AAA", "ABB", "ABC", "XXX", "XYY", "XYZ"]);
		private var _wordSlots:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
		private var _instance:WordSlotHandlerModel;
		
		private var _recordedWordCreations:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
		
		public function WordSlotHandlerModelTest(testMethod:String):void {
			super(testMethod);
		}
		
		protected override function setUp():void {
			createWordSlotModelVector();
			_instance = new WordSlotHandlerModel(_wordList, _wordSlots);
			_instance.addEventListener(WordSlotHandlerEvent.CREATE, eventRecorder);
			_instance.initWordSlots();
		}
		
		private function eventRecorder(e:WordSlotHandlerEvent):void {
			_recordedWordCreations.push(e.newWord);
		}
		
		private function createWordSlotModelVector():void {
			for (var i:int = 0; i < NUM_SLOTS; i++)
				_wordSlots.push(new MockWordSlotModel());
		}
		
		protected override function tearDown():void {
			_instance.destroy();
		}
		
		public function should_reject_incorrect_constructor_parameters():void {
			_wordList = new Vector.<String>();
			_wordSlots = new Vector.<IWordSlotModel>();
			assertTrue("Throws error if inputs are equal length", createInstanceThrowsError());
			
			_wordList = new Vector.<String>();
			_wordSlots = Vector.<IWordSlotModel>([new MockWordSlotModel()]);
			assertTrue("Throws error if there are more slots than strings", createInstanceThrowsError());
			
			_wordList = Vector.<String>([""]);
			_wordSlots = new Vector.<IWordSlotModel>();
			assertFalse("Does not throw an error if there are more strings than slots", createInstanceThrowsError());
		}
		
		private function createInstanceThrowsError():Boolean {
			try {
				new WordSlotHandlerModel(_wordList, _wordSlots);
				return false;
			} catch (error:Error) {
				return true;
			}
			throw new Error("Should not reach this point");
		}
		
		public function should_correctly_assign_spellings_to_word_slots():void {
			var returnedWords:Vector.<IWordSlotModel> = _recordedWordCreations;
			
			assertEquals("initWordSlots created the right number of IWordSlots", returnedWords.length, _wordSlots.length);
			for (var i:int = 0; i < returnedWords.length; ++i)
				assertEquals("The relayed words have the same strings as the input words", _wordList[i], returnedWords[i].wordToSpell);
		}
		
		/**
		 * Tests whether after initWordSlots() has been called that when a wordslot dispatches a WordSlotEvent.FINISH event, it receives a new spelling.
		 */
		public function testWordFinishReset():void {
			var i:int;
			for (i = 0; i < NUM_SLOTS; ++i) {
				_wordSlots[i].dispatchEvent(new WordSlotEvent(WordSlotEvent.FINISH));
				assertEquals("Dispatching a FINISH event on the words gives it the next word in the passed in list", _wordSlots[i].wordToSpell, _wordList[i + NUM_SLOTS]);
			}
			for (i = 0; i < NUM_SLOTS; ++i) {
				_wordSlots[i].dispatchEvent(new WordSlotEvent(WordSlotEvent.FINISH));
				assertEquals("Dispatching a FINISH event on the words after you have used every word on the list wraps back arround to the start of the list", _wordSlots[i].wordToSpell, _wordList[i]);
			}
		}
		
		public function testDispatchEventOnWordComplete():void {
			var numJumps:int = 0;
			_instance.addEventListener(WordCompleteEvent.JUMP, function(e:Event):void {numJumps++});
			
			advance(_wordSlots[0], "AAA");
			assertEquals("Dispatches a WordCompleteEvent.JUMP event when a word completes", 1, numJumps);
		}
		
		private function advance(wordSlot:IWordSlotModel, inputLetters:String):void {
			for (var i:int = 0; i < inputLetters.length; i++)
				wordSlot.advanceWord(Util.toCharcode(inputLetters.substr(i, 1)));
		}
	}
}