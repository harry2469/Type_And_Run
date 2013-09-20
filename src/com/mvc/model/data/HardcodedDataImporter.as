package com.mvc.model.data {
	import flash.events.*;
	
	/** @author Kristian Welsh */
	public class HardcodedDataImporter extends EventDispatcher implements IDataImporter {
		public function getWordData():Vector.<String> {
			return Vector.<String>(["qqqq", "wwww", "eeee", "rrrr", "tttt", "yyyy"]);
		}
		
		public function getCollectableData():Array {
			return [
			[500, 320, 20, 9],
			[520, 320, 20, 9],
			[540, 329, 20, 9]];
		}
		
		public function getObstacleData():Array {
			return [
			[480, 412, 43, 41],
			[680, 412, 43, 41],
			[880, 412, 43, 41]];
		}
		
		public function loadSpellings():void {
			signalLoaded();
		}
		
		public function loadCollectables():void {
			signalLoaded();
		}
		
		public function loadObstacles():void {
			signalLoaded();
		}
		
		private function signalLoaded():void {
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}