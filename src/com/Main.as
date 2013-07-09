package com
{
	// Flash Imports
	import flash.display.Sprite;
	import flash.events.Event;
	
	// My Imports
	import tests.MyTestRunner;
	
	// BUG top word is ALWAYS aardvark.
	
	// TODO see if removing the clone functions is possible due to all my constructions happening in a central location.
	
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
		
		private var _dependancyInjector:DependancyInjector;
		
		/** Initialises the aplication. */
		public function Main():void
		{
			// If this is a unit test run then only run the unit tests.
			if (TEST_PASS) {
				_unitTestRunner = new MyTestRunner(stage)
				return;
			}
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * This function is called when added to the stage to ensure there is a stage to add objects to.
		 * @param	e
		 */
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