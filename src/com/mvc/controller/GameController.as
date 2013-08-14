package com.mvc.controller {
	import com.Main;
	import com.mvc.model.GameModel;
	import flash.display.Stage;
	
	/** @author Kristian Welsh */
	public class GameController {
		public function GameController(model:GameModel, stage:Stage) {
			var inputOperator:InputOpperator = new InputOpperator(stage, model.wordSlotLatcher);
		}
	}
}