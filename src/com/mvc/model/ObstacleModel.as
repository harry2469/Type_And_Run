package com.mvc.model
{
	import com.events.ObstacleModelEvent;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	/**
	 * Model of any incoming obsticals towards the player
	 * @author Kristian Welsh
	 */
	public class ObstacleModel extends EventDispatcher
	{
		private var _height:Number = 0;
		private var _width:Number = 0;
		private var _pos:Point = new Point(0, 0);
		
		public function ObstacleModel(x:Number, y:Number, width:Number, height:Number)
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
			dispatchEvent(new ObstacleModelEvent(ObstacleModelEvent.POSITION_CHANGE, _pos));
		}
		
	}

}