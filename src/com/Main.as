package com {
	import com.mvc.controller.GameController;
	import com.mvc.model.data.*;
	import com.mvc.model.GameModel;
	import com.mvc.view.GameView;
	import flash.display.Sprite;
	import flash.events.Event;
	import tests.MyTestRunner;
	
	[SWF(width="800",height="600",frameRate="60",backgroundColor="#FFFFFF")]
	
	public class Main extends Sprite {
		private const IS_TEST_RUN:Boolean = false;
		
		private var _model:GameModel;
		private var _view:GameView;
		private var _controller:GameController;
		private var _parser:IDataImporter;
		
		private var _wordSpellings:Vector.<String>;
		private var _collectables:Array = [];
		private var _obstacles:Array = [];
		
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
		 * for example if our .swf is embeded in another .swf file, and hasn't been added to the stage yet
		 */
		private function startGameWhenStageIsAccessable():void {
			if (stageIsAccessable())
				loadWords();
			else
				addEventListener(Event.ADDED_TO_STAGE, loadWords);
		}
		
		private function stageIsAccessable():Boolean {
			return stage != null;
		}
		
		private function loadWords(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, loadWords);
			_parser = new HardcodedDataImporter();
			_parser.addEventListener(Event.COMPLETE, assignWords);
			_parser.loadSpellings();
		}
		
		private function assignWords(e:Event):void {
			_parser.removeEventListener(Event.COMPLETE, assignWords);
			_wordSpellings = _parser.getWordData();
			_parser.addEventListener(Event.COMPLETE, assignCollectables);
			_parser.loadCollectables();
		}
		
		private function assignCollectables(e:Event):void {
			_parser.removeEventListener(Event.COMPLETE, assignCollectables);
			_collectables = _parser.getCollectableData();
			_parser.addEventListener(Event.COMPLETE, assignObstacles);
			_parser.loadObstacles();
		}
		
		private function assignObstacles(e:Event):void {
			_obstacles = _parser.getObstacleData();
			createModelViewController();
		}
		
		private function createModelViewController():void {
			_model = new GameModel(_wordSpellings, _obstacles, _collectables);
			_view = new GameView(_model, stage);
			_controller = new GameController(_model, stage);
			_model.startGame();
		}
	}
}