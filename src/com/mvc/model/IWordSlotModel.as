package com.mvc.model
{
	import flash.events.IEventDispatcher;
	/**
	 * Interface for WordSlotModel
	 * @author Kristian Welsh
	 */
	public interface IWordSlotModel extends IEventDispatcher
	{
		function get wordToSpell():String
		
		function set wordToSpell(input:String):void
		
		function isNextCharacterCode(inputChar:uint):Boolean
		
		function advanceWord(inputChar:uint):void
		
		//function resetWord():void
	}
	
}