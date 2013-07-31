package com.events
{
	import flash.events.Event;
	import flash.geom.Point;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * Events for any Entity
	 * @author Kristian Welsh
	 */
	public class EntityModelEvent extends Event
	{
		public static const POSITION_CHANGE:String = "position change";
		
		private var _position:Point;
		
		public function get x():Number { return _position.x; }
		public function get y():Number { return _position.y; }
		
		public function EntityModelEvent(type:String, position:Point = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_position = position;
			FlashConnect.trace(2);
		}
		
		public override function clone():Event
		{
			return new EntityModelEvent(type, _position, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("EntityModelEvent", "x", "y", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
	
}