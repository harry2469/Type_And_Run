package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class WordEvent extends Event 
	{
		public static const CHANGE:String = "change";
		public static const ADVANCE:String = "advance";
		public static const FINISH:String = "finish";
		
		private var _advanceCharCode:int = NaN;
		private var _wordObject:WordModel = null;
		
		public function WordEvent(type:String, advanceCharCode:int = NaN, wordObject:WordModel = null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
			_advanceCharCode = advanceCharCode;
			_wordObject = wordObject;
		} 
		
		public override function clone():Event 
		{ 
			return new WordEvent(type, advanceCharCode, wordObject, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("WordEvent", "type", "advanceCharCode", "wordObject", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get advanceCharCode():int 
		{
			return _advanceCharCode;
		}
		
		public function get wordObject():WordModel 
		{
			return _wordObject;
		}
		
	}
	
}