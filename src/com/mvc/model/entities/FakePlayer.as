package com.mvc.model.entities {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;

	public class FakePlayer extends FakeEntity implements IPlayer {

		public function fallIfFalling():void {

		}

		public function stopFalling():void {

		}

		public function get falling():Boolean {
			return true;
		}

		public function advanceIfLeftOf(xTarget:Number):void {

		}
	}
}