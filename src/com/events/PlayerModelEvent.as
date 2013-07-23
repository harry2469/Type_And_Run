package com.events
{
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class PlayerModelEvent extends Event
	{
		public static const CHANGE_POSITION:String = "change position";
		
		private var _position:Point;
		
		public function PlayerModelEvent(type:String, pos:Point, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_position = pos;
		}
		
		public override function clone():Event
		{
			return new PlayerModelEvent(type, position, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("PlayerModelEvent", "type", "position", "bubbles", "cancelable", "eventPhase");
		}
		
		public function get position():Point { return _position; }
		
	}
	
}