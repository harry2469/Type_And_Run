package com {
	import com.mvc.controller.GameController;
	import com.mvc.model.GameModel;
	import com.mvc.model.XMLParser;
	import com.mvc.view.GameView;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flashdevelop.utils.FlashConnect;
	import tests.MyTestRunner;
	
	[SWF(width="800",height="600",frameRate="60",backgroundColor="#FFFFFF")]
	
	/** @author Kristian Welsh */
	// TODO: collectables
	// TODO: xml
	public class Main extends Sprite {
		static public const OBSTACLES_XML_PATH:String = "../lib/data/Obstacles.xml";
		static public const COLLECTABLES_XML_PATH:String = "../lib/data/Collectables.xml";
		private static const SPELLINGS_XML_PATH:String = "../lib/data/Spellings.xml";
		
		private const IS_TEST_RUN:Boolean = false;
		
		private var _model:GameModel;
		private var _view:GameView;
		private var _controller:GameController;
		private var _parser:XMLParser;
		
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
		 * @example if our .swf is embeded in another .swf file, and hasn't been added to the stage yet
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
			_parser = new XMLParser();
			_parser.loadXMLFile(SPELLINGS_XML_PATH);
			_parser.addEventListener(Event.COMPLETE, assignWords);
		}
		
		private function assignWords(e:Event):void {
			_parser.removeEventListener(Event.COMPLETE, assignWords);
			
			var arr:Array = [];
			for (var i:uint = 0; i < _parser.xml.WORD.length(); i++) {
				arr.push(String(_parser.xml.WORD[i]));
			}
			_wordSpellings = Vector.<String>(arr);
			
			_parser.loadXMLFile(COLLECTABLES_XML_PATH);
			_parser.addEventListener(Event.COMPLETE, assignCollectables);
		}
		
		private function assignCollectables(e:Event):void {
			_parser.removeEventListener(Event.COMPLETE, assignCollectables);
			
			for (var i:uint = 0; i < _parser.xml.COLLECTABLE.length(); i++) {
				_collectables[i] = [];
				_collectables[i].push(_parser.xml.COLLECTABLE[i].X);
				_collectables[i].push(_parser.xml.COLLECTABLE[i].Y);
				_collectables[i].push(_parser.xml.COLLECTABLE[i].WIDTH);
				_collectables[i].push(_parser.xml.COLLECTABLE[i].HEIGHT);
			}
			
			_parser.loadXMLFile(OBSTACLES_XML_PATH);
			_parser.addEventListener(Event.COMPLETE, assignObstacles);
		}
		
		private function assignObstacles(e:Event):void {
			_parser.removeEventListener(Event.COMPLETE, assignObstacles);
			
			for (var i:uint = 0; i < _parser.xml.OBSTACLE.length(); i++) {
				_obstacles[i] = [];
				_obstacles[i].push(_parser.xml.OBSTACLE[i].X);
				_obstacles[i].push(_parser.xml.OBSTACLE[i].Y);
				_obstacles[i].push(_parser.xml.OBSTACLE[i].WIDTH);
				_obstacles[i].push(_parser.xml.OBSTACLE[i].HEIGHT);
			}
			
			createModelViewController();
		}
		
		private function createModelViewController():void {
			FlashConnect.trace(_wordSpellings);
			FlashConnect.trace(_collectables);
			FlashConnect.trace(_obstacles);
			_model = new GameModel(_wordSpellings, _obstacles, _collectables);
			_view = new GameView(_model, stage);
			_controller = new GameController(_model, stage);
			_model.startGame();
		}
	}
}