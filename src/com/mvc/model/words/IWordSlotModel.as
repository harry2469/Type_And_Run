package com.mvc.model.words {
	import flash.events.IEventDispatcher;
	
	/** @author Kristian Welsh */
	public interface IWordSlotModel extends IEventDispatcher {
		function isNextCharacterCode(inputChar:int):Boolean;
		function advanceWord(inputChar:int):void;
		function resetWord():void;
		function get wordToSpell():String;
		function set wordToSpell(input:String):void;
	}
}