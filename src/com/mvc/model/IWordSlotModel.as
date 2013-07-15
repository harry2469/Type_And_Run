package com.mvc.model
{
	import flash.events.IEventDispatcher;
	
	/**
	 * Interface for the IWordSlotModel object
	 * @author Kristian Welsh
	 */
	public interface IWordSlotModel extends IEventDispatcher
	{
		function get wordToSpell():String;
		function set wordToSpell(input:String):void;
		function isNextCharacterCode(inputChar:int):Boolean;
		function advanceWord(inputChar:int):void;
		function resetWord():void;
	}
}