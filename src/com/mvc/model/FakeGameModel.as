package com.mvc.model {
	import com.mvc.model.entities.ICollectable;
	import com.mvc.model.entities.IObstacle;
	import com.mvc.model.entities.ObstacleModel;
	import com.mvc.model.entities.PlayerModel;
	import com.mvc.model.words.IWordSlotLatcher;
	import com.mvc.model.words.IWordSlotModel;
	import flash.events.EventDispatcher;

	public class FakeGameModel extends EventDispatcher implements IGameModel {
		public function get wordSlotLatcher():IWordSlotLatcher {
			return null;
		}

		public function get player():PlayerModel {
			return null;
		}

		public function get ground():ObstacleModel {
			return null;
		}

		public function getWordSlotAt(index:uint):IWordSlotModel {
			return null;
		}

		public function get obstacles():Vector.<IObstacle> {
			return null;
		}

		public function get collectables():Vector.<ICollectable> {
			return null;
		}

		public function getCollectableAt(index:uint):ICollectable {
			return null;
		}

		public function get counter():PointsCounterModel {
			return null;
		}

		public function startGame():void {

		}

		public function showFailureScreen():void {

		}

		public function showSuccessScreen():void {

		}
	}
}