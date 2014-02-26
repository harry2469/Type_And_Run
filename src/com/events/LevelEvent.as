package com.events {
	import flash.events.Event;
	import flash.geom.Point;
	
	public class LevelEvent extends Event {
		public static const LEVEL_SUCCEEDED:String = "level succeeded";
		public static const LEVEL_FAILED:String = "level failed";
		
		public function LevelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}