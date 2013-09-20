package com.events {
	import flash.events.Event;
	
	/** @author Kristian Welsh */
	public class PointsCounterEvent extends Event {
		public static const UPDATE_AMOUNT:String = "update amount";
		
		private var _amount:uint;
		
		public function PointsCounterEvent(type:String, amount:uint, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_amount = amount;
		}
		
		public override function clone():Event {
			return new PointsCounterEvent(type, amount, bubbles, cancelable);
		}
		
		public override function toString():String {
			return formatToString("PointsCounterEvent", "type", "amount", "bubbles", "cancelable", "eventPhase");
		}
		
		public function get amount():uint {
			return _amount;
		}
	}
}