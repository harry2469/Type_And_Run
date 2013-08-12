package com {
	import com.mvc.controller.GameController;
	import com.mvc.model.GameModel;
	import com.mvc.view.GameView;
	import flash.display.Sprite;
	import flash.events.Event;
	import tests.MyTestRunner;
	
	/**
	 * Avoider/Typing Game Crossover.
	 * @author Kristian Welsh
	 */
	public class Main extends Sprite {
		private const IS_TEST_RUN:Boolean = false;
		
		private var _model:GameModel;
		private var _view:GameView;
		private var _controller:GameController;
		
		public function Main():void {
			if (IS_TEST_RUN)
				runTests();
			else
				startGame();
		}
		
		private function startGame():void {
			if (stageIsAccessable())
				initMVC();
			else
				addEventListener(Event.ADDED_TO_STAGE, initMVC);
		}
		
		private function initMVC(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, initMVC);
			createMVC();
			_model.startGame();
		}
		
		private function createMVC():void {
			_model = new GameModel();
			_view = new GameView(_model, stage);
			_controller = new GameController(_model, stage);
		}
		
		private function runTests():void {
			new MyTestRunner(stage);
		}
		
		private function stageIsAccessable():Boolean {
			return stage != null;
		}
	}
}