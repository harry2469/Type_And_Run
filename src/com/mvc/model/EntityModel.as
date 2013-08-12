package com.mvc.model
{
	import com.events.EntityModelEvent;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import kris.RectangleCollision;
	
	/**
	 * Abstract model of any moving component that needs to be displayed to the player
	 * @author Kristian Welsh
	 */
	public class EntityModel extends EventDispatcher
	{
		private var _rectangle:Rectangle = new Rectangle(0, 0, 0, 0);
		
		public function EntityModel(x:Number, y:Number, width:Number, height:Number)
		{
			if (height < 0 || width < 0) throw new ArgumentError("cannot have negative dimentions");
			
			_rectangle.x = x;
			_rectangle.y = y;
			_rectangle.width = width;
			_rectangle.height = height;
		}
		
		public function moveTo(x:Number, y:Number):void
		{
			_rectangle.x = x;
			_rectangle.y = y;
			dispatchEvent(new EntityModelEvent(EntityModelEvent.POSITION_CHANGE, _rectangle.topLeft));
		}
		
		/**
		 * Only change this object's position through this function.
		 * Otherwise listeners of EntityModelEvent.POSITION_CHANGE events do not get updates.
		 */
		public function moveBy(x:Number, y:Number):void
		{
			_rectangle.x += x;
			_rectangle.y += y;
			dispatchEvent(new EntityModelEvent(EntityModelEvent.POSITION_CHANGE, _rectangle.topLeft));
		}
		
		public function isCollidingWith(collider:EntityModel):Boolean
		{
			return RectangleCollision.detect(this.rectangle, collider.rectangle);
		}
		
		public function collideWith(collider:EntityModel):void
		{
			_rectangle = RectangleCollision.resolve(_rectangle, collider.rectangle);
		}
		
		public function get rectangle():Rectangle
		{
			return _rectangle;
		}
		
		public function get x():Number { return _rectangle.x; }
		public function get y():Number { return _rectangle.y; }
	}
}