package com.mvc.model.data {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.*;
	import kris.Util;
	import org.flashdevelop.utils.FlashConnect;
	
	/** @author Kristian Welsh */
	public class XMLParser extends EventDispatcher implements IDataImporter {
		static private const OBSTACLES_XML_PATH:String = "../lib/data/Obstacles.xml";
		static private const COLLECTABLES_XML_PATH:String = "../lib/data/Collectables.xml";
		static private const SPELLINGS_XML_PATH:String = "../lib/data/Spellings.xml";
		
		private var _xml:XML = null;
		
		public function getWordData():Vector.<String> {
			var words:Array = [];
			for (var i:uint = 0; i < _xml.WORD.length(); i++)
				words.push(String(_xml.WORD[i]));
			return Vector.<String>(words);
		}
		
		public function getCollectableData():Array {
			var collectables:Array = [];
			for (var i:uint = 0; i < _xml.COLLECTABLE.length(); i++) {
				collectables[i] = [];
				collectables[i].push(_xml.COLLECTABLE[i].X);
				collectables[i].push(_xml.COLLECTABLE[i].Y);
				collectables[i].push(_xml.COLLECTABLE[i].WIDTH);
				collectables[i].push(_xml.COLLECTABLE[i].HEIGHT);
			}
			return collectables;
		}
		
		public function getObstacleData():Array {
			var obstacles:Array = [];
			for (var i:uint = 0; i < _xml.OBSTACLE.length(); i++) {
				obstacles[i] = [];
				obstacles[i].push(_xml.OBSTACLE[i].X);
				obstacles[i].push(_xml.OBSTACLE[i].Y);
				obstacles[i].push(_xml.OBSTACLE[i].WIDTH);
				obstacles[i].push(_xml.OBSTACLE[i].HEIGHT);
			}
			return obstacles;
		}
		
		public function loadSpellings():void {
			loadXMLFile(SPELLINGS_XML_PATH);
		}
		
		public function loadCollectables():void {
			loadXMLFile(COLLECTABLES_XML_PATH);
		}
		
		public function loadObstacles():void {
			loadXMLFile(OBSTACLES_XML_PATH);
		}
		
		private function loadXMLFile(path:String):void {
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loadFileData);
			tryToLoadXML(loader, path);
		}
		
		private function loadFileData(e:Event):void {
			_xml = new XML(e.target.data);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function tryToLoadXML(xmlLoader:URLLoader, path:String):void {
			try {
				xmlLoader.load(new URLRequest(path));
			} catch (error:Error) {
				FlashConnect.trace("Error occurred while trying to load an XML file at: " + path);
				throw error;
			}
		}
	}
}