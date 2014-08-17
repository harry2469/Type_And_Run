package com.mvc.model.entities {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;

	public class FakeEntity extends EventDispatcher implements IEntityModel {
		public function moveBy(x:Number, y:Number):void {

		}

		public function set rectangle(value:Rectangle):void {

		}

		public function get rectangle():Rectangle {
			return new Rectangle();
		}

		public function get y():Number {
			return 0;
		}

		public function get x():Number {
			return 0;
		}
	}
}