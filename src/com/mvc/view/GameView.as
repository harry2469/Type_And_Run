package com.mvc.view {
	import com.mvc.model.GameModel;
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.view.text.*;
	import com.mvc.view.WordSlotView;
	import flash.display.Stage;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class GameView {
		private var _model:GameModel;
		private var _player:PlayerView;
		private var _obstacle:ObstacleView;
		private var _wordSlotViews:Vector.<WordSlotView> = new Vector.<WordSlotView>();
		
		public function GameView(model:GameModel, stage:Stage) {
			_model = model;
			_player = new PlayerView(stage, model.player);
			_obstacle = new ObstacleView(stage, model.obstacle);
			populateWordSlotViewVector(stage);
		}
		
		private function populateWordSlotViewVector(stage:Stage):void {
			for (var i:int = 0; i < GameModel.NUMBER_OF_WORD_SLOTS; i++)
				_wordSlotViews.push(createWordSlotView(stage, i));
		}
		
		private function createWordSlotView(stage:Stage, i:int):WordSlotView {
			var position:Point = new Point(100, (i * 30) + 100); // not final
			var lettersToSpell:LettersToSpell = new LettersToSpell(position);
			var lettersSpelt:LettersSpelt = new LettersSpelt(position);
			var model:IWordSlotModel = _model.getWordSlotAt(i);
			
			return new WordSlotView(stage, model, lettersToSpell, lettersSpelt);
		}
	}
}