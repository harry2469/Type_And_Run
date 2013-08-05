package com.mvc.model
{
	import com.events.EntityModelEvent;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import kris.Dimentions;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * Abstract model of any moving component that needs to be displayed to the player
	 * @author Kristian Welsh
	 */
	public class EntityModel extends EventDispatcher
	{
		private var _rectangle:Rectangle = new Rectangle(0, 0, 0, 0);
		
		public function EntityModel(position:Point, dimentions:Dimentions)
		{
			_rectangle.x = position.x;
			_rectangle.y = position.y;
			_rectangle.width = dimentions.width;
			_rectangle.height = dimentions.height;
		}
		
		public function moveBy(x:Number, y:Number):void
		{
			if (x == 0 && y == 0) return;
			_rectangle.x += x;
			_rectangle.y += y;
			dispatchEvent(new EntityModelEvent(EntityModelEvent.POSITION_CHANGE, _rectangle.topLeft));
		}
		
		public function isCollidingWith(collider:EntityModel):Boolean
		{
			if (collider == this) throw new Error("An entity can not check for collision against itself");
			if (collider.x == this.x && collider.y == this.y) return true;
			return rectangle.intersects(collider.rectangle);
		}
		
		public function collideWith(collider:EntityModel):void
		{
			if (!isCollidingWith(collider)) return;
			var collisionRect:Rectangle = rectangle.intersection(collider.rectangle);
		}
		
		public function get rectangle():Rectangle
		{
			return _rectangle;
		}
		
		public function get x():Number { return _rectangle.x; }
		public function get y():Number { return _rectangle.y; }
	}
}