package events 
{
	// Flash Imports
	import flash.events.Event;
	import flash.geom.Point;
	
	// My Imports
	import mvc.model.WordModel;
	
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class WordHandlerEvent extends Event 
	{
		public static const CREATE:String = "create";
		
		private var _newWord:WordModel;
		private var _position:Point;
		
		public function WordHandlerEvent(type:String, newWord:WordModel, position:Point, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_newWord = newWord;
			_position = position
		}
		
		public override function clone():Event 
		{ 
			return new WordHandlerEvent(type, newWord, position, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("WordHandlerEvent", "type", "newWord", "position", "bubbles", "cancelable"); 
		}
		
		public function get newWord():WordModel 
		{
			return _newWord;
		}
		
		public function get position():Point 
		{
			return _position;
		}
		
	}
	
}