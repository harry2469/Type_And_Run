package com.mvc.model.words
{
	
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public interface IWordSlotLatcher
	{
		function unlatchAll():void;
		function acceptInput(charCode:int):void;
	}
	
}