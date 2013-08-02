package com.mvc.model.words
{
	import flash.events.IEventDispatcher;
	
	/**
	 * Interface for the IWordSlotModel object
	 * @author Kristian Welsh
	 */
	public interface IWordSlotModel extends IEventDispatcher
	{
		function isNextCharacterCode(inputChar:int):Boolean;
		function get wordToSpell():String;
		function set wordToSpell(input:String):void;
		function advanceWord(inputChar:int):void;
		function resetWord():void;
	}
}