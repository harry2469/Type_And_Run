package com.mvc.model.words {
	import flash.events.IEventDispatcher;
	/** @author Kristian Welsh */
	public interface IWordSlotListener extends IEventDispatcher {
		function listen():void;
		function destroy():void;
	}
}