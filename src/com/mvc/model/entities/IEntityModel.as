package com.mvc.model.entities {
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;

	public interface IEntityModel extends IEventDispatcher {
		function moveBy(x:Number, y:Number):void;
		function set rectangle(value:Rectangle):void;
		function get rectangle():Rectangle;
		function get y():Number;
		function get x():Number;
	}
}