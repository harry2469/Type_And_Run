package com.mvc.model
{
	import com.events.WordCompleteEvent;
	import com.mvc.model.words.IWordSlotHandlerModel;
	import flash.geom.Point;
	import kris.Dimentions;
	
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class PlayerModel extends EntityModel
	{
		// PUBLIC
		public function PlayerModel(position:Point, width:Number, height:Number, handler:IWordSlotHandlerModel)
		{
			super(position, new Dimentions(width, height));
			handler.addEventListener(WordCompleteEvent.JUMP, jump);
		}
		
		// PRIVATE
		private function jump(e:WordCompleteEvent):void
		{
			moveBy(0, -50);
		}
	}
}