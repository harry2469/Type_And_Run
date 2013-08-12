package com.events {
	import flash.events.Event;
	
	/** @author Kristian Welsh */
	public class WordSlotEvent extends Event {
		public static const CHANGE:String = "change";
		public static const ADVANCE:String = "advance";
		public static const FINISH:String = "finish";
		
		private var _wordToSpell:String;
		
		public function WordSlotEvent(type:String, wordToSpell:String = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_wordToSpell = wordToSpell;
		}
		
		public function get wordToSpell():String {
			return _wordToSpell;
		}
	}
}