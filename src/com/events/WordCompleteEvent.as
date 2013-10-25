package com.events {
	import flash.events.Event;
	
	/** @author Kristian Welsh */
	public class WordCompleteEvent extends Event {
		public static const JUMP:String = "jump";
		public static const DUCK:String = "duck";
		public static const RUN:String = "run";
		
		public function WordCompleteEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}