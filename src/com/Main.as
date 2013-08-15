package com {
	import com.mvc.controller.GameController;
	import com.mvc.model.GameModel;
	import com.mvc.view.GameView;
	import flash.display.Sprite;
	import flash.events.Event;
	import tests.MyTestRunner;
	
	[SWF(width="800",height="600",frameRate="60",backgroundColor="#FFFFFF")]
	
	/** @author Kristian Welsh */
	public class Main extends Sprite {
		private const IS_TEST_RUN:Boolean = false;
		
		private var _model:GameModel;
		private var _view:GameView;
		private var _controller:GameController;
		
		public function Main():void {
			if (IS_TEST_RUN)
				runTests();
			else
				startGameWhenStageIsAccessable();
		}
		
		private function runTests():void {
			new MyTestRunner(stage);
		}
		
		/**
		 * The stage may not be accessable under certain circumstances
		 * @example our .swf is embeded in another .swf file, and hasn't been added to the stage yet
		 */
		private function startGameWhenStageIsAccessable():void {
			if (stageIsAccessable())
				startGame();
			else
				addEventListener(Event.ADDED_TO_STAGE, startGame);
		}
		
		private function stageIsAccessable():Boolean {
			return stage != null;
		}
		
		private function startGame(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, startGame);
			createModelViewController();
			_model.startGame();
		}
		
		private function createModelViewController():void {
			_model = new GameModel();
			_view = new GameView(_model, stage);
			_controller = new GameController(_model, stage);
		}
	}
}