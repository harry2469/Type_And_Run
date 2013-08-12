package com.mvc.view {
	import com.mvc.model.ObstacleModel;
	import flash.display.Stage;
	
	/* @author Kristian Welsh */
	public class ObstacleView extends EntityView {
		
		[Embed(source="../../../../lib/images/simple/Obstacle.png")]
		private var image:Class;
		
		public function ObstacleView(stage:Stage, model:ObstacleModel) {
			super(stage, model, image);
		}
	}
}