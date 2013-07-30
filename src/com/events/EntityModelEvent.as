package com.events
{
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * Events for any game objects
	 * @author Kristian Welsh
	 */
	public class EntityModelEvent extends Event
	{
		public static const POSITION_CHANGE:String = "position change";
		
		private var _position:Point;
		
		public function EntityModelEvent(type:String, position:Point = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_position = position;
		}
		
		public override function clone():Event
		{
			return new EntityModelEvent(type, position, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("EntityModelEvent", "position", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		public function get position():Point { return _position; }
	}
	
}