package com.mvc.model
{
	import com.events.PlayerModelEvent;
	import com.events.WordCompleteEvent;
	import com.mvc.model.words.IWordSlotHandlerModel;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class PlayerModel extends EventDispatcher implements IPlayerModel
	{
		private var _pos:Point;
		
		// PUBLIC
		
		public function PlayerModel(x:Number, y:Number, handler:IWordSlotHandlerModel)
		{
			_pos = new Point(x, y);
			handler.addEventListener(WordCompleteEvent.JUMP, jump);
		}
		
		public function get x():Number { return _pos.x; }
		public function get y():Number { return _pos.y; }
		
		// PRIVATE
		
		/**
		 * I would use private setters for x and y indevidually but a bug in the compiler wont
		 * let me mix public and private setters and getters of the same name.
		 */
		private function set pos(value:Point):void
		{
			_pos = value;
		}
		
		private function jump(e:WordCompleteEvent):void
		{
			pos = new Point(_pos.x, _pos.y - 50);
			dispatchEvent(new PlayerModelEvent(PlayerModelEvent.CHANGE_POSITION, _pos));
		}
	}
}