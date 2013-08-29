package com.mvc.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.*;
	import kris.Util;
	import org.flashdevelop.utils.FlashConnect;
	/** @author Kristian Welsh */
	public class XMLParser extends EventDispatcher {
		private var _xmlContent:XML = null;
		private var _xmlLoader:URLLoader;
		
		public function loadXMLFile(path:String):void {
			_xmlLoader = new URLLoader();
			_xmlLoader.addEventListener(Event.COMPLETE, foo);
			tryToLoadXML(_xmlLoader, path);
		}
		
		private function tryToLoadXML(xmlLoader:URLLoader, path:String):void {
			try {
				xmlLoader.load(new URLRequest(path));
			} catch (error:Error) {
				FlashConnect.trace("Error occurred during XML file load");
				throw error;
			}
		}
		
		private function foo(e:Event):void {
			this.xmlContent = new XML(e.target.data);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function set xmlContent(value:XML):void {
			_xmlContent = value;
		}
		
		public function get xml():XML {
			return _xmlContent;
		}
		
		public function tagContentsAsArray(tagName:String):Array {
			var tagContents:XMLList = _xmlContent.descendants(tagName);
			
			var returnMe:Array = [];
			for (var i:int = 0; i < tagContents.length(); ++i)
				addToArrayIfValid(returnMe, tagContents, i);
			return returnMe;
		}
		
		private function addToArrayIfValid(returnMe:Array, tagContents:XMLList, index:int):void {
			if (isValidOutput(tagContents, index))
				returnMe.push(tagContents[index]);
		}
		
		private function isValidOutput(tagContents:XMLList, index:int):Boolean {
			return "" + tagContents[index] != "" && Util.stringLetterAt(0, tagContents[index]) != "<";
		}
	}
}