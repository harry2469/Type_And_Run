package com.mvc.view {
	import com.mvc.model.EntityModel;
	import flash.display.Stage;
	
	/** @author Kristian Welsh */
	public class PlayerView extends EntityView {
		
		[Embed(source="../../../../lib/images/simple/player.png")]
		private var image:Class;
		
		public function PlayerView(stage:Stage, model:EntityModel) {
			super(stage, model, image);
		}
	}
}