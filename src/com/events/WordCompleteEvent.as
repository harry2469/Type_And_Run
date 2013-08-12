package com.events {
	import flash.events.Event;
	
	/** @author Kristian Welsh */
	public class WordCompleteEvent extends Event {
		public static const JUMP:String = "jump";
		
		public function WordCompleteEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}