package com.mvc.model.entities {
	import com.events.EntityModelEvent;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	
	/// Abstract model of any moveable component.
	public class EntityModel extends EventDispatcher {
		private var _rectangle:Rectangle;
		
		public function EntityModel(x:Number, y:Number, width:Number, height:Number) {
			if (height < 0 || width < 0)
				throw new ArgumentError("cannot have negative dimentions");
			
			_rectangle = new Rectangle(x, y, width, height)
		}
		
		public function get x():Number {
			return _rectangle.x;
		}
		
		public function get y():Number {
			return _rectangle.y;
		}
		
		public function get rectangle():Rectangle {
			return _rectangle;
		}
		
		public function set rectangle(value:Rectangle):void {
			_rectangle = value;
			signalMovement();
		}
		
		public function moveBy(x:Number, y:Number):void {
			_rectangle.x += x;
			_rectangle.y += y;
			signalMovement();
		}
		
		private function signalMovement():void {
			dispatchEvent(new EntityModelEvent(EntityModelEvent.POSITION_CHANGE, _rectangle.topLeft));
		}
	}
}