package com.mvc.model
{
	import flash.geom.Point;
	import kris.Dimentions;
	/**
	 * Model of any incoming obsticals towards the player
	 * @author Kristian Welsh
	 */
	public class ObstacleModel extends EntityModel
	{
		public function ObstacleModel(position:Point, dimentions:Dimentions)
		{
			super(position, dimentions);
		}
	}
}