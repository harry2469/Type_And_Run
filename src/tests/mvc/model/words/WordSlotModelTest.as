package tests.mvc.model.words {
	import asunitsrc.asunit.framework.TestCase;
	import com.events.WordSlotEvent;
	import com.mvc.model.words.WordSlotModel;
	import kris.Util;
	
	/** @author Kristian Welsh */
	public class WordSlotModelTest extends TestCase {
		private var _instance:WordSlotModel = null;
		
		private var _advanceEvents:Vector.<WordSlotEvent> = new Vector.<WordSlotEvent>
		private var _changeEvents:Vector.<WordSlotEvent> = new Vector.<WordSlotEvent>
		private var _finishEvents:Vector.<WordSlotEvent> = new Vector.<WordSlotEvent>
		
		public function WordSlotModelTest(testMethod:String):void {
			super(testMethod);
		}
		
		protected override function setUp():void {
			_instance = new WordSlotModel();
			_instance.addEventListener(WordSlotEvent.ADVANCE, logAdvance);
			_instance.addEventListener(WordSlotEvent.CHANGE, logChange);
			_instance.addEventListener(WordSlotEvent.FINISH, logFinish);
		}
		
		protected override function tearDown():void {
			_instance.removeEventListener(WordSlotEvent.ADVANCE, logAdvance);
			_instance.removeEventListener(WordSlotEvent.CHANGE, logChange);
			_instance.removeEventListener(WordSlotEvent.FINISH, logFinish);
		}
		
		private function logAdvance(e:WordSlotEvent):void {
			_advanceEvents.push(e);
		}
		
		private function logChange(e:WordSlotEvent):void {
			_changeEvents.push(e);
		}
		
		private function logFinish(e:WordSlotEvent):void {
			_finishEvents.push(e);
		}
		
		public function testUserCanGetAndSetWordToSpell():void {
			_instance.wordToSpell = "foo";
			assertEquals("You can get and set the value of wordToSpell on the object", "foo", _instance.wordToSpell);
			assertEquals("Double check for assurance that the method is a query, and not also a command", "foo", _instance.wordToSpell);
			
			_instance.wordToSpell = "";
			assertEquals("You can set wordToSpell to an empty string", "", _instance.wordToSpell);
		}
		
		public function testSettingWordToSpellDispatchesChangeWordSlotEvent():void {
			_instance.wordToSpell = "foo";
			assertEquals("Setting word to spell to an arbitrary value dispatches a WordSlotEvent.CHANGE event", 1, _changeEvents.length);
			
			_instance.wordToSpell = "bar";
			assertEquals("Works more than once", 2, _changeEvents.length);
		}
		
		public function testCorrectAdvanceWordCallDispatchesAdvanceWordSlotEvent():void {
			_instance.wordToSpell = "foo";
			_instance.advanceWord(Util.toCharcode("f"));
			assertEquals("Setting word to spell to an arbitrary value dispatches a WordSlotEvent.ADVANCE event", 1, _advanceEvents.length);
			
			_instance.advanceWord(Util.toCharcode("o"));
			assertEquals("Works more than once", 2, _advanceEvents.length);
			
			_instance.advanceWord(Util.toCharcode("X"));
			assertEquals("Only dispatches on correct inputs", 2, _advanceEvents.length);
		}
		
		public function testCompletingWordCallDispatchesFinishEvent():void {
			_instance.wordToSpell = "foo";
			_instance.advanceWord(Util.toCharcode("f"));
			_instance.advanceWord(Util.toCharcode("o"));
			_instance.advanceWord(Util.toCharcode("o"));
			assertEquals("Successfully completeing a word dispatches a WordSlotEvent.FINISH event", 1, _finishEvents.length);
			
			_instance.wordToSpell = "bar";
			_instance.advanceWord(Util.toCharcode("b"));
			_instance.advanceWord(Util.toCharcode("a"));
			_instance.advanceWord(Util.toCharcode("r"));
			assertEquals("Works mre than once.", 2, _finishEvents.length);
		}
		
		public function testUserCanCheckNextCharacterCodeAndAdvanceWord():void {
			_instance.wordToSpell = "abc";
			assertTrue("Function correctly returns the next character before any changes", _instance.isNextCharacterCode("a".charCodeAt(0)));
			assertTrue("Double check for assurance that the method is a query, not a command", _instance.isNextCharacterCode("a".charCodeAt(0)));
			
			_instance.advanceWord(Util.toCharcode("a"));
			assertTrue("Function correctly returns the new next character after a correct character input", _instance.isNextCharacterCode("b".charCodeAt(0)));
			
			_instance.advanceWord(Util.toCharcode("b"));
			assertTrue("Function correctly returns the new next character after a correct character input", _instance.isNextCharacterCode("c".charCodeAt(0)));
		}
	}
}