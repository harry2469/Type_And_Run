package com.mvc.model
{
	import com.events.WordCompleteEvent;
	import com.mvc.model.words.IWordSlotHandlerModel;
	import com.mvc.model.words.IWordSlotLatcher;
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.model.words.WordSlotHandlerModel;
	import com.mvc.model.words.WordSlotLatcher;
	import com.mvc.model.words.WordSlotModel;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import kris.Dimentions;
	import kris.Util;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * Contains the bulk of the logic
	 * @author Kristian Welsh
	 */
	public class GameModel extends EventDispatcher
	{
		public static const NUMBER_OF_WORD_SLOTS_TO_CREATE:int = 3
		
		private var _wordSlotHandler:IWordSlotHandlerModel;
		private var _player:PlayerModel;
		
		private var _obstacle:ObstacleModel;
		private var _timer:Timer;
		private var _wordSlots:Vector.<IWordSlotModel>;
		private var _wordSlotLatcher:IWordSlotLatcher;
		
		// PUBLIC
		
		public function get wordSlotLatcher():IWordSlotLatcher { return _wordSlotLatcher; }
		public function get obstacle():ObstacleModel { return _obstacle; }
		public function get player():PlayerModel { return _player; }
		
		public function getWordSlotAt(i:int):IWordSlotModel
		{
			return _wordSlots[i];
		}
		
		public function GameModel():void
		{
			createWordSlotSystem();
			_player = new PlayerModel(new Point(800/2-20, 600/2-75), 53, 53, _wordSlotHandler);
			
			_obstacle = new ObstacleModel(new Point(600, 600/2-30), new Dimentions(43, 41));
			
			_timer = new Timer(10);
			_timer.addEventListener(TimerEvent.TIMER, tock);
		}
		
		public function startAplication():void
		{
			_wordSlotHandler.initWordSlots();
			_timer.start();
		}
		
		// PRIVATE
		
		private function tock(e:TimerEvent):void
		{
			_obstacle.moveBy(-1, 0);
			_player.collideWith(_obstacle);
		}
		
		/**
		 * Builds WordSlotHandlerModel and injects its dependancies.
		 * @return WordSlotHandlerModel
		 */
		private function createWordSlotSystem():void
		{
			var wordsToSpell:Vector.<String> = Vector.<String>(["aaaaaaa", "bbbbbb", "ccccc", "dddd", "eee", "ff", "g"]);
			wordsToSpell = Util.scrambleStringVector(wordsToSpell);
			_wordSlots = createWordSlotModelVector();
			_wordSlotHandler = new WordSlotHandlerModel(wordsToSpell, _wordSlots);
			var latchedWordSlots:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
			
			_wordSlotLatcher = new WordSlotLatcher(_wordSlotHandler, latchedWordSlots);
		}
		
		/**
		 * Populates a vector with WordSlotModels
		 * @return the vector
		 */
		private function createWordSlotModelVector():Vector.<IWordSlotModel>
		{
			var wordObjects:Vector.<IWordSlotModel> = new Vector.<IWordSlotModel>();
			for (var i:int = 0; i < NUMBER_OF_WORD_SLOTS_TO_CREATE; i++)
			{
				wordObjects.push(new WordSlotModel() as IWordSlotModel);
			}
			return wordObjects;
		}
	}

}