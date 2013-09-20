package com.mvc.model.data {
	import flash.events.IEventDispatcher;
	
	/** @author Kristian Welsh */
	public interface IDataImporter extends IEventDispatcher {
		function getWordData():Vector.<String>;
		function getCollectableData():Array;
		function getObstacleData():Array;
		function loadSpellings():void;
		function loadCollectables():void;
		function loadObstacles():void;
	}
}