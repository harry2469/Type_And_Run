package com.events
{
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class ObstacleModelEvent extends Event
	{
		public static const POSITION_CHANGE:String = "position change";
		
		private var _position:Point = null;
		
		public function ObstacleModelEvent(type:String, position:Point = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_position = position;
		}
		
		public override function clone():Event
		{
			return new ObstacleModelEvent(type, position, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("ObstacleModelEvent", "position", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		public function get position():Point { return _position; }
		
	}
	
}