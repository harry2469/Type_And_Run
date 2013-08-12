package com.events
{
	import flash.events.Event;
	
	/**
	 * Event for the WordSlotModel object.
	 * @author Kristian Welsh
	 */
	public class WordSlotEvent extends Event
	{
		public static const CHANGE:String = "change";
		public static const ADVANCE:String = "advance";
		public static const FINISH:String = "finish";
		
		private var _wordToSpell:String;
		
		public function get wordToSpell():String {
			return _wordToSpell;
		}
		
		public function WordSlotEvent(type:String, wordToSpell:String = null, bubbles:Boolean = false, cancelable:Boolean = false){
			super(type, bubbles, cancelable);
			_wordToSpell = wordToSpell;
		}
		
		public override function clone():Event {
			return new WordSlotEvent(type, wordToSpell, bubbles, cancelable);
		}
		
		public override function toString():String {
			return formatToString("WordSlotEvent", "type", "wordToSpell", "bubbles", "cancelable", "eventPhase");
		}
		
	}
	
}