package com.mvc.model
{
	import com.events.EntityModelEvent;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	/**
	 * Abstract model of any moving component that needs to be displayed to the player
	 * @author Kristian Welsh
	 */
	public class EntityModel extends EventDispatcher
	{
		protected var _height:Number = 0;
		protected var _width:Number = 0;
		protected var _pos:Point = new Point(0, 0);
		
		public function EntityModel(x:Number, y:Number, width:Number, height:Number)
		{
			moveBy(x, y);
			_width = width;
			_height = height;
		}
		
		public function moveBy(x:Number, y:Number):void
		{
			if (x == 0 && y == 0) return;
			_pos.x += x;
			_pos.y += y;
			dispatchEvent(new EntityModelEvent(EntityModelEvent.POSITION_CHANGE, _pos));
		}
		
		public function get x():Number { return _pos.x; }
		public function get y():Number { return _pos.y; }
		public function get width():Number { return _width; }
		public function get height():Number { return _height; }
		
	}
}