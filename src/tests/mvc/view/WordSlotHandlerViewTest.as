package tests.mvc.view
{
	// Asunit imports
	import asunitsrc.asunit.framework.TestCase;
	
	// Flash Imports
	import flash.display.Stage;
	import flash.events.Event;
	
	// My imports
	import com.events.WordSlotHandlerEvent;
	import com.mvc.model.words.IWordSlotHandlerModel;
	import com.mvc.model.words.WordSlotModel;
	import com.mvc.view.words.IWordSlotView;
	import com.mvc.view.words.WordSlotHandlerView;
	
	/**
	 * Tests all public behavior of the WordSlotHandlerViewTest class.
	 * @author Kristian Welsh
	 */
	public class WordSlotHandlerViewTest extends TestCase
	{
		private var _stage:Stage;
		private var _instance:WordSlotHandlerView;
		private var _model:IWordSlotHandlerModel;
		
		private var _numInits:int = 0;
		private var _wordObjects:Vector.<IWordSlotView>;
		
		/**
		 * Start the test specified by the passed in string.
		 * @param	testMethod
		 */
		public function WordSlotHandlerViewTest(testMethod:String, stage:Stage):void
		{
			_stage = stage;
			super(testMethod);
		}
		
		/**
		 * Set up the test environment.
		 * Always called when test is created.
		 */
		protected override function setUp():void
		{
			_wordObjects = new Vector.<IWordSlotView>();
			var wordMockAssignmentTemp:MockWordSlotView;
			
			for (var i:int = 0; i < 3; ++i)
			{
				wordMockAssignmentTemp = new MockWordSlotView();
				wordMockAssignmentTemp.addEventListener(Event.ACTIVATE, logInit);
				_wordObjects.push(wordMockAssignmentTemp as IWordSlotView);
			}
			
			_model = new StubWordSlotHandlerModel();
			_instance = new WordSlotHandlerView(_stage, _model, _wordObjects);
		}
		
		private function logInit(e:Event):void
		{
			_numInits++;
		}
		
		/**
		 * Tear down the test environment.
		 * Always called when test is destroyed.
		 */
		protected override function tearDown():void
		{
			var word:MockWordSlotView
			for (var i:int = 0; i < 3; ++i)
			{
				word = _wordObjects[i] as MockWordSlotView;
				word.removeEventListener(Event.ACTIVATE, logInit);
			}
		}
		
		/**
		 * Tests that the object calls init() on all of its IWordSlotView objects when you
		 * dispatch a WordSlotHandlerEvent.CREATE event on its IWordSlotHandlerModel.
		 */
		public function should_call_init_on_word_views_when_create_event_dispatched():void
		{
			//assertEquals("Should not call init on IWordSlotView until WordSlotHandlerEvent.CREATE is dispatched on IWordSlotHandlerModel", 0, _numInits);
			
			_model.dispatchEvent(new WordSlotHandlerEvent(WordSlotHandlerEvent.CREATE, new WordSlotModel()));
			//assertEquals("Should call init on IWordSlotView when WordSlotHandlerEvent.CREATE is dispatched on IWordSlotHandlerModel", 1, _numInits);
			
			_model.dispatchEvent(new WordSlotHandlerEvent(WordSlotHandlerEvent.CREATE, new WordSlotModel()));
			//assertEquals("Should work for each object", 2, _numInits);
			
			_model.dispatchEvent(new WordSlotHandlerEvent(WordSlotHandlerEvent.CREATE, new WordSlotModel()));
			//assertEquals("Should work for each object", 3, _numInits);
			
			_model.dispatchEvent(new WordSlotHandlerEvent(WordSlotHandlerEvent.CREATE, new WordSlotModel())); //here
			/*assertEquals("Should not work for extra objects", 3, _numInits);*/
		}
	}
}

// Flash Imports
import flash.display.Stage;
import flash.events.Event;
import flash.events.EventDispatcher;

// My imports
import com.mvc.model.words.IWordSlotHandlerModel;
import com.mvc.model.words.IWordSlotModel;
import com.mvc.view.words.IWordSlotView;

class MockWordSlotView extends EventDispatcher implements IWordSlotView
{
	public function init(stage:Stage, model:IWordSlotModel):void
	{
		dispatchEvent(new Event(Event.ACTIVATE));
	}
}

class StubWordSlotHandlerModel extends EventDispatcher implements IWordSlotHandlerModel
{
	public function acceptInput(charCode:int):void { }
	public function initWordSlots():void { }
}