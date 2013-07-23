package com.mvc.model
{
	import com.events.ObstacleModelEvent;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class ObstacleModel extends EventDispatcher
	{
		private var _height:Number = 0;
		private var _width:Number = 0;
		private var _pos:Point = new Point(0, 0);
		
		public function ObstacleModel(x:Number, y:Number, width:Number, height:Number)
		{
			_pos.x = x;
			_pos.y = y;
			_width = width;
			_height = height;
		}
		
		public function moveBy(x:Number, y:Number):void
		{
			_pos.x += x;
			_pos.y += y;
			dispatchEvent(new ObstacleModelEvent(ObstacleModelEvent.POSITION_CHANGE, _pos));
		}
		
	}

}