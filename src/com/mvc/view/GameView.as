package com.mvc.view
{
	// Flash Imports
	import com.mvc.model.GameModel;
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.view.text.LettersSpelt;
	import com.mvc.view.text.LettersToSpell;
	import com.mvc.view.WordSlotView;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	/**
	 * Handles all of the views for the game.
	 * @author Kristian Welsh
	 */
	public class GameView
	{
		private var _model:GameModel;
		
		private var _player:PlayerView;
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
			_player = new PlayerView(stage, model.player);
			_obstacle = new ObstacleView(stage, model.obstacle);
			var wordSlotViews:Vector.<WordSlotView> = createWordSlotViewVector(stage);
		}
		
		// PRIVATE
		
		private function createWordSlotViewVector(stage:Stage):Vector.<WordSlotView>
		{
			var wordObjects:Vector.<WordSlotView> = new Vector.<WordSlotView>();
			for (var i:int = 0; i < GameModel.NUMBER_OF_WORD_SLOTS_TO_CREATE; i++)
			{
				wordObjects.push(createWordSlotView(stage, i));
			}
			return wordObjects;
		}
		
		private function createWordSlotView(stage:Stage, i:int):WordSlotView
		{
			var position:Point = new Point(100, (i * 30) + 100);
			
			var lettersToSpell:LettersToSpell = new LettersToSpell(position)
			var lettersSpelt:LettersSpelt = new LettersSpelt(position);
			var model:IWordSlotModel = _model.getWordSlotAt(i);
			
			return new WordSlotView(stage, model, lettersToSpell, lettersSpelt);
		}
	}
}