package com.mvc.model.words {
	import flash.events.IEventDispatcher;
	/** @author Kristian Welsh */
	public interface IWordSlotHandlerModel extends IEventDispatcher {
		function initWordSlots():void;
		function get wordSlots():Vector.<IWordSlotModel>;
	}
}