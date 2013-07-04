package com.events
{
	// Flash Imports
	import flash.events.Event;
	import flash.geom.Point;
	
	// My Imports
	import com.mvc.model.IWordSlotModel;
	
	/**
	 * Event for the WordHandlerModel object.
	 * @author Kristian Welsh
	 */
	public class WordSlotHandlerEvent extends Event
	{
		/** Event Enumeration Constant */
		public static const CREATE:String = "create";
		
		/** Refers to the new word input. */
		private var _newWord:IWordSlotModel;
		
		/** Refers to the new word's position. */
		private var _position:Point;
		
		/**
		 * Calls super for the event and captures extra stored variables in globals.
		 * @param	type:String
		 * @param	newWord:IWordSlotModel
		 * @param	position:Point
		 * @param	bubbles:Boolean (Optional)
		 * @param	cancelable:Boolean (Optional)
		 */
		public function WordSlotHandlerEvent(type:String, newWord:IWordSlotModel, position:Point, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_newWord = newWord;
			_position = position
		}
		
		/**
		 * Returns a carbon copy of the object.
		 * @return	Clone of the object
		 */
		public override function clone():Event
		{
			return new WordSlotHandlerEvent(type, newWord, position, bubbles, cancelable);
		}
		
		/**
		 * Returns a string representation of the object.
		 * @return String Representation
		 */
		public override function toString():String
		{
			return formatToString("WordSlotHandlerEvent", "type", "newWord", "position", "bubbles", "cancelable");
		}
		
		/**
		 * Returns the _newWord global.
		 * @return _newWord global.
		 */
		public function get newWord():IWordSlotModel
		{
			return _newWord;
		}
		
		/**
		 * Returns the _position global.
		 * @return _position global.
		 */
		public function get position():Point
		{
			return _position;
		}
		
	}
	
}