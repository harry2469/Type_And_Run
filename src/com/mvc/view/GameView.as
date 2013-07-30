package com.mvc.view
{
	// Flash Imports
	import com.mvc.model.GameModel;
	import com.mvc.view.words.IWordSlotView;
	import com.mvc.view.words.LettersSpelt;
	import com.mvc.view.words.LettersToSpell;
	import com.mvc.view.words.WordSlotView;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	// My imports
	import com.mvc.view.words.WordSlotHandlerView;
	
	/**
	 * Handles all of the tasks for veiwing things.
	 * @author Kristian Welsh
	 */
	public class GameView
	{
		private var _model:GameModel;
		
		/** Handles all view tasks of the Word Slots. */
		private var _wordHandler:WordSlotHandlerView;
		private var _player:PlayerView;
		private var _wordSlotHandlerView:WordSlotHandlerView;
		
		
		private var _obstacle:ObstacleView;
		
		// PUBLIC
		
		/**
		 * Initialises the view components of the game.
		 * @param	model
		 * @param	stage
		 */
		public function GameView(model:GameModel, stage:Stage)
		{
			_model = model;
			_wordSlotHandlerView = createWordSlotHandlerView(model, stage);
			_player = new PlayerView(stage, model.player);
			
			_obstacle = new ObstacleView(stage, model.obstacle);
		}
		
		public function toString():String
		{
			return "[GameView]";
		}
		
		// PRIVATE
		
		private function createWordSlotHandlerView(model:GameModel, stage:Stage):WordSlotHandlerView
		{
			var wordSlotViews:Vector.<IWordSlotView> = createWordSlotViewVector(stage);
			return new WordSlotHandlerView(stage, model.wordSlotHandler, wordSlotViews);
		}
		
		private function createWordSlotViewVector(stage:Stage):Vector.<IWordSlotView>
		{
			var wordObjects:Vector.<IWordSlotView> = new Vector.<IWordSlotView>();
			for (var i:int = 0; i < GameModel.NUMBER_OF_WORD_SLOTS_TO_CREATE; i++)
			{
				wordObjects.push(createWordSlotView(stage, i));
			}
			return wordObjects;
		}
		
		private function createWordSlotView(stage:Stage, i:int):IWordSlotView
		{
			return new WordSlotView(new LettersToSpell(), new LettersSpelt(), new Point(100, (i * 30) + 100), new TextFormat(), new TextFormat());
		}
	}
}