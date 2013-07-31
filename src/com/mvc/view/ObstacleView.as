package com.mvc.view
{
	// FlashDevelop Imports
	import com.events.EntityModelEvent;
	import com.mvc.model.ObstacleModel;
	import com.mvc.model.PlayerModel;
	
	// Flash Imports
	import flash.display.Stage;
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class ObstacleView extends EntityView
	{
		[Embed(source="../../../../lib/images/simple/Obstacle.png")]
		private var image:Class;
		
		// PUBLIC
		public function ObstacleView(stage:Stage, model:ObstacleModel)
		{
			super(stage, model, image);
		}
	}
}