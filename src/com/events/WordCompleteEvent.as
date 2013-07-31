package com.events
{
	import flash.events.Event;
	
	/**
	 * Carries the information that a word in a specific slot has finished
	 * @author Kristian Welsh
	 */
	public class WordCompleteEvent extends Event
	{
		public static const JUMP:String = "jump";
		
		public function WordCompleteEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new WordCompleteEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("WordCompleteEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
	
}