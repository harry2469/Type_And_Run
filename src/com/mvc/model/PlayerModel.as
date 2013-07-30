package com.mvc.model
{
	import com.events.WordCompleteEvent;
	import com.mvc.model.words.IWordSlotHandlerModel;
	
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class PlayerModel extends EntityModel
	{
		// PUBLIC
		public function PlayerModel(x:Number, y:Number, handler:IWordSlotHandlerModel)
		{
			super(x, y, 10, 50);
			handler.addEventListener(WordCompleteEvent.JUMP, jump);
		}
		
		// PRIVATE
		private function jump(e:WordCompleteEvent):void
		{
			moveBy(0, -50);
		}
	}
}