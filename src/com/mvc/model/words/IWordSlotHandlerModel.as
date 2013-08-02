package com.mvc.model.words
{
	import flash.events.IEventDispatcher;
	/**
	 * Interface for the WordSlotHandlerModel
	 * @author Kristian Welsh
	 */
	public interface IWordSlotHandlerModel extends IEventDispatcher
	{
		function get wordSlots():Vector.<IWordSlotModel>
		function initWordSlots():void;
	}
}