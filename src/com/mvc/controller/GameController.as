package com.mvc.controller
{
	import com.mvc.model.GameModel;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class GameController
	{
		// PUBLIC
		public function GameController(model:GameModel, stage:Stage)
		{
			var _inputOperator:InputOpperator = new InputOpperator(stage, model.wordSlotLatcher);
		}
	}
}