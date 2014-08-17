package com.mvc.model.entities {

	public class ObstacleModel extends EntityModel implements IObstacle {
		static public const SPEED:Number = 1;
		public function ObstacleModel(x:Number, y:Number, width:Number, height:Number) {
			super(x, y, width, height);
		}
	}
}