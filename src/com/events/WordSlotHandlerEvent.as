package com.events
{
	// Flash Imports
	import flash.events.Event;
	import flash.geom.Point;
	
	// My Imports
	import com.mvc.model.words.IWordSlotModel;
	
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
		
		/**
		 * Calls super for the event and captures extra stored variables in globals.
		 * @param	type:String
		 * @param	newWord:IWordSlotModel
		 * @param	bubbles:Boolean (Optional)
		 * @param	cancelable:Boolean (Optional)
		 */
		public function WordSlotHandlerEvent(type:String, newWord:IWordSlotModel, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_newWord = newWord;
		}
		
		/**
		 * Returns a carbon copy of the object.
		 * @return	Clone of the object
		 */
		public override function clone():Event
		{
			return new WordSlotHandlerEvent(type, newWord, bubbles, cancelable);
		}
		
		/**
		 * Returns a string representation of the object.
		 * @return String Representation
		 */
		public override function toString():String
		{
			return formatToString("WordSlotHandlerEvent", "type", "newWord", "bubbles", "cancelable");
		}
		
		/**
		 * Returns the _newWord global.
		 * @return _newWord global.
		 */
		public function get newWord():IWordSlotModel
		{
			return _newWord;
		}
		
	}
	
}