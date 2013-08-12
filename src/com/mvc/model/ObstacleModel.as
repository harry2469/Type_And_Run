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
		public function ObstacleModel(x:Number, y:Number, width:Number, height:Number)
		{
			super(x, y, width, height);
		}
	}
}