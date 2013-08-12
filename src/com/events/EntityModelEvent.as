package com.events {
	import flash.events.Event;
	import flash.geom.Point;
	
	/** @author Kristian Welsh */
	public class EntityModelEvent extends Event {
		public static const POSITION_CHANGE:String = "position change";
		
		private var _position:Point;
		
		public function EntityModelEvent(type:String, position:Point, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_position = position;
		}
		
		public function get x():Number {
			return _position.x;
		}
		
		public function get y():Number {
			return _position.y;
		}
	}
}