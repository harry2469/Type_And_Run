package com.mvc.model.entities {
	public interface IPlayer extends IEntityModel {
		function fallIfFalling():void;
		function stopFalling():void;
		function get falling():Boolean;
		function advanceIfLeftOf(xTarget:Number):void;
	}
}