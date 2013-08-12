package com.mvc.controller
{
	import com.mvc.model.GameModel;
	import flash.display.Stage;
	
	/**
	 * Controlls all player interactability with the game
	 * @author Kristian Welsh
	 */
	public class GameController
	{
		// PUBLIC
		public function GameController(model:GameModel, stage:Stage)
		{
			var inputOperator:InputOpperator = new InputOpperator(stage, model.wordSlotLatcher);
		}
	}
}