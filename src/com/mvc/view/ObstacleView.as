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
		// PUBLIC
		public function ObstacleView(stage:Stage, model:ObstacleModel)
		{
			super(stage, model, 0xFF0000);
		}
	}
}