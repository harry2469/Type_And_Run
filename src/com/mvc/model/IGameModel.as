package com.mvc.model {
	import com.mvc.model.entities.ICollectable;
	import com.mvc.model.entities.IObstacle;
	import com.mvc.model.entities.ObstacleModel;
	import com.mvc.model.entities.PlayerModel;
	import com.mvc.model.words.IWordSlotLatcher;
	import com.mvc.model.words.IWordSlotModel;
	import flash.events.IEventDispatcher;

	public interface IGameModel extends IEventDispatcher{
		function get wordSlotLatcher():IWordSlotLatcher;
		function get player():PlayerModel;
		function get ground():ObstacleModel;
		function getWordSlotAt(index:uint):IWordSlotModel;
		function get obstacles():Vector.<IObstacle>;
		function get collectables():Vector.<ICollectable>;
		function getCollectableAt(index:uint):ICollectable;
		function get counter():PointsCounterModel;
		function startGame():void;
		function showFailureScreen():void;
		function showSuccessScreen():void;
	}
}