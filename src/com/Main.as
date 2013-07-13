package com
{
	// Flash Imports
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flashdevelop.utils.FlashConnect;
	
	// My Imports
	import tests.MyTestRunner;
	
	/**
	 * Avoider/Typing Game Crossover.
	 * @author Kristian Welsh
	 */
	public class Main extends Sprite
	{
		/** Is this run intended to run the unit tests? */
		static public const TEST_PASS:Boolean = false;
		
		/** Runs the unit tests */
		private var _unitTestRunner:MyTestRunner;
		
		/** Controls the instantiation of all objects to decrease coupling and be able to swap out mocks for testing */
		private var _dependancyInjector:DependancyInjector;
		
		/** Initialises the aplication. */
		public function Main():void
		{
			// If this is a unit test run then only run the unit tests.
			if (TEST_PASS) {
				_unitTestRunner = new MyTestRunner(stage);
				return;
			}
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_dependancyInjector = new DependancyInjector(stage);
			_dependancyInjector.handlerModel.initWordSlots();
		}
		
		override public function toString():String
		{
			return "[Main]";
		}
	}
	
}