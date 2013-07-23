package tests.mvc.controller
{
	// Asunit Imports
	import asunitsrc.asunit.framework.TestCase;
	import flash.events.KeyboardEvent;
	
	// Flash Imports
	import flash.display.Stage;
	
	// My Imports
	import com.mvc.controller.InputOpperator;
	import com.mvc.model.words.IWordSlotHandlerModel;
	
	/**
	 * Tests all public behavior of the InputOpperatorTest class.
	 * @author Kristian Welsh
	 */
	public class InputOpperatorTest extends TestCase
	{
		/** instance to test */
		private var _instance:InputOpperator = null;
		private var _stage:Stage = null;
		private var _model:IWordSlotHandlerModel = null;
		/**
		 * Start the test specified by the passed in string.
		 * @param	testMethod
		 */
		public function InputOpperatorTest(testMethod:String, stage:Stage):void
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
			_model = new MockWordSlotHandlerModel(this);
			_instance = new InputOpperator(_stage, _model);
		}
		
		/**
		 * Tear down the test environment.
		 * Always called when test is destroyed.
		 */
		protected override function tearDown():void
		{
			_instance = null;
			_model = null;
		}
		
		/**
		 * Tests that InputOpperator calls acceptInput on its IWordSlotHandlerModel when it detects a key press
		 */
		public function testKeyPress():void
		{
			_stage.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 113));
		}
		
		public function verifyKeyPress(charCode:int):void
		{
			assertEquals(113, charCode);
		}
	}
}

// Flash Imports
import flash.events.EventDispatcher;

// My Imports
import com.mvc.model.words.IWordSlotHandlerModel;
import tests.mvc.controller.InputOpperatorTest;

class MockWordSlotHandlerModel extends EventDispatcher implements IWordSlotHandlerModel
{
	private var _testReferance:InputOpperatorTest = null;
	
	public function MockWordSlotHandlerModel(inputOpperatorTest:InputOpperatorTest)
	{
		_testReferance = inputOpperatorTest;
	}
	
	public function acceptInput(charCode:int):void
	{
		_testReferance.verifyKeyPress(charCode)
	}
	
	public function initWordSlots():void { }
}