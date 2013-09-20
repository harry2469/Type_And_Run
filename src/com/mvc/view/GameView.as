package com.mvc.view {
	import com.mvc.model.entities.*;
	import com.mvc.model.GameModel;
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.view.text.*;
	import com.mvc.view.WordSlotView;
	import flash.display.*;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class GameView {
		private var _model:GameModel;
		private var _player:PlayerView;
		private var _ground:GroundView;
		private var _wordSlotViews:Vector.<WordSlotView> = new Vector.<WordSlotView>();
		private var _obstacles:Vector.<ObstacleView> = new Vector.<ObstacleView>();
		private var _collectables:Vector.<CollectableView> = new Vector.<CollectableView>();
		
		public function GameView(model:GameModel, container:DisplayObjectContainer) {
			_model = model;
			_player = new PlayerView(container, model.player);
			_ground = new GroundView(container, model.ground);
			populateCollectables(container);
			populateObstacles(container);
			populateWordSlotViewVector(container);
		}
		
		private function populateCollectables(container:DisplayObjectContainer):void {
			var collectableModels:Vector.<CollectableModel> = _model.collectables;
			for (var i:uint = 0; i < collectableModels.length; i++)
				_collectables.push(new CollectableView(container, collectableModels[i]));
		}
		
		private function populateObstacles(container:DisplayObjectContainer):void {
			var obstacleModels:Vector.<ObstacleModel> = _model.obstacles;
			for (var i:uint = 0; i < obstacleModels.length; i++)
				_obstacles.push(new ObstacleView(container, obstacleModels[i]));
		}
		
		private function populateWordSlotViewVector(container:DisplayObjectContainer):void {
			for (var i:int = 0; i < GameModel.NUMBER_OF_WORD_SLOTS; i++)
				_wordSlotViews.push(createWordSlotView(container, i));
		}
		
		private function createWordSlotView(container:DisplayObjectContainer, i:int):WordSlotView {
			var position:Point = new Point(100, (i * 30) + 100); // not final placement
			var lettersToSpell:LettersToSpell = new LettersToSpell(position);
			var lettersSpelt:LettersSpelt = new LettersSpelt(position);
			var model:IWordSlotModel = _model.getWordSlotAt(i);
			
			return new WordSlotView(container, model, lettersToSpell, lettersSpelt);
		}
	}
}