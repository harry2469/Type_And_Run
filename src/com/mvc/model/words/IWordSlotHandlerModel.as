package com.mvc.model.words
{
	import flash.events.IEventDispatcher;
	/**
	 * Interface for the WordSlotHandlerModel
	 * @author Kristian Welsh
	 */
	public interface IWordSlotHandlerModel extends IEventDispatcher
	{
		function getWordSlotAt(index:uint):IWordSlotModel;
		function get length():uint
		function isNextCharacterCode(index:uint, characterCode:int):Boolean;
		function initWordSlots():void;
	}
}