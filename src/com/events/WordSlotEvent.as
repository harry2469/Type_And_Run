package com.events 
{
	// Flash Imports
	import flash.events.Event;
	
	// My Imports
	import com.mvc.model.WordSlotModel;
	
	/**
	 * Event for the Word object.
	 * @author Kristian Welsh
	 */
	public class WordSlotEvent extends Event 
	{
		/** Event Enumeration Constant */
		public static const CHANGE:String = "change";
		
		/** Event Enumeration Constant */
		public static const ADVANCE:String = "advance";
		
		/** Event Enumeration Constant */
		public static const FINISH:String = "finish";
		
		/**
		 * Call super on the new Event.
		 * @param	type
		 * @param	bubbles (Optional)
		 * @param	cancelable (Optional)
		 */
		public function WordSlotEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		/**
		 * Returns a carbon copy of the Event.
		 * @return	Clone of the object
		 */
		public override function clone():Event 
		{ 
			return new WordSlotEvent(type, bubbles, cancelable);
		} 
		
		/**
		 * Returns a string representation of the Event.
		 * @return String Representation
		 */
		public override function toString():String 
		{ 
			return formatToString("WordEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}