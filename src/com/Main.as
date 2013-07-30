package com
{
	import com.mvc.controller.GameController;
	import com.mvc.model.GameModel;
	import com.mvc.view.GameView;
	import com.mvc.view.PlayerView;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flashdevelop.utils.FlashConnect;
	import tests.MyTestRunner;
	
	/**
	 * Avoider/Typing Game Crossover.
	 * @author Kristian Welsh
	 */
	public class Main extends Sprite
	{
		/** Is this run a run of the unit tests? */
		private const TEST_RUN:Boolean = false;
		
		private var _model:GameModel;
		private var _view:GameView;
		private var _controller:GameController;
		
		public function Main():void
		{
			//If this is a unit test run then only run the unit tests.
			if (TEST_RUN) {
				var _unitTestRunner:MyTestRunner = new MyTestRunner(stage);
				return;
			}
			if (stage) initMVC();
			else addEventListener(Event.ADDED_TO_STAGE, initMVC);
		}
		
		private function initMVC(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initMVC);
			
			_model = new GameModel();
			_view = new GameView(_model, stage);
			_controller = new GameController(_model, stage);
			
			_model.startAplication();
		}
	}
	
}