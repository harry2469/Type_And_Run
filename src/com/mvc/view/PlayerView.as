package com.mvc.view
{
	// FlashDevelop Imports
	import com.events.EntityModelEvent;
	import com.mvc.model.EntityModel;
	import com.mvc.model.PlayerModel;
	
	// Flash Imports
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class PlayerView extends EntityView
	{
		public function PlayerView(stage:Stage, model:EntityModel)
		{
			super(stage, model, 0x000000);
		}
	}
}