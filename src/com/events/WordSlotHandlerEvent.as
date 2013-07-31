package com.events
{
	// Flash Imports
	import flash.events.Event;
	import flash.geom.Point;
	import org.flashdevelop.utils.FlashConnect;
	
	// My Imports
	import com.mvc.model.words.IWordSlotModel;
	
	/**
	 * Event for the WordHandlerModel object.
	 * @author Kristian Welsh
	 */
	public class WordSlotHandlerEvent extends Event
	{
		public static const CREATE:String = "create";
		
		private var _newWord:IWordSlotModel;
		
		public function get newWord():IWordSlotModel { return _newWord; }
		
		public function WordSlotHandlerEvent(type:String, newWord:IWordSlotModel, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_newWord = newWord;
			FlashConnect.trace(1);
		}
		
		public override function clone():Event
		{
			return new WordSlotHandlerEvent(type, newWord, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("WordSlotHandlerEvent", "type", "newWord", "bubbles", "cancelable");
		}
		
	}
	
}