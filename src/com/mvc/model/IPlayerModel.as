package com.mvc.model
{
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public interface IPlayerModel extends IEventDispatcher
	{
		function get x():Number;
		function get y():Number;
	}
	
}