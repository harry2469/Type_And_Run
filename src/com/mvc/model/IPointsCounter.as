package com.mvc.model {
	import flash.events.IEventDispatcher;
	public interface IPointsCounter extends IEventDispatcher {
		function addPoint():void;
	}
}