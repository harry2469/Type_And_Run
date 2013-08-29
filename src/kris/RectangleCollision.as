package kris {
	import flash.geom.Rectangle;
	
	/** @author Kristian Welsh */
	public class RectangleCollision {
		
		public static function applyFunctionIfColliding(rectangle1:Rectangle, rectangle2:Rectangle, functionToApply:Function, functionArguments:Array = null):void {
			if (RectangleCollision.detect(rectangle1, rectangle2))
				functionToApply.apply(null, functionArguments);
		}
		
		public static function collide(reactionary:Rectangle, stationary:Rectangle):Rectangle {
			if (detect(reactionary, stationary))
				return resolve(reactionary, stationary);
			return reactionary;
		}
		
		public static function detect(rectangle1:Rectangle, rectangle2:Rectangle):Boolean {
			if (areSame(rectangle1, rectangle2))
				throw new Error("you cannot detect collision between a rectangle and itself");
			return rectangle1.intersects(rectangle2);
		}
		
		/**
		 * Currently only works with rectangles that are roughly the same size and shape and have shallow collisions.
		 * Could improve by using the center points of the rectangles for direction decisions.
		 */
		public static function resolve(reactionary:Rectangle, stationary:Rectangle):Rectangle {
			if (areSame(reactionary, stationary))
				throw new Error("you cannot resolve collision between a rectangle and itself");
			return findNewValue(reactionary, stationary);
		}
		
		private static function areSame(rectangle1:Rectangle, rectangle2:Rectangle):Boolean {
			return rectangle1 == rectangle2;
		}
		
		private static function findNewValue(reactionary:Rectangle, stationary:Rectangle):Rectangle {
			var rectangleToReturn:Rectangle = reactionary.clone();
			if (shouldResolveX(reactionary, stationary))
				rectangleToReturn.x = resolveAxis(reactionary.x, stationary.x, overlapArea(reactionary, stationary).width);
			else
				rectangleToReturn.y = resolveAxis(reactionary.y, stationary.y, overlapArea(reactionary, stationary).height);
			return rectangleToReturn;
		}
		
		static private function shouldResolveX(reactionary:Rectangle, stationary:Rectangle):Boolean {
			return xIsLargestDifferance(overlapArea(reactionary, stationary))
		}
		
		private static function overlapArea(reactionary:Rectangle, stationary:Rectangle):Rectangle {
			return reactionary.intersection(stationary)
		}
		
		private static function resolveAxis(reactionaryPos:Number, stationaryPos:Number, collisionSize:Number):Number {
			if (reactionaryPos > stationaryPos)
				return reactionaryPos + collisionSize;
			else
				return reactionaryPos - collisionSize;
		}
		
		private static function xIsLargestDifferance(collisionRect:Rectangle):Boolean {
			return collisionRect.width <= collisionRect.height;
		}
		
		private static function areAtSamePoint(rectangle1:Rectangle, rectangle2:Rectangle):Boolean {
			return rectangle1.x == rectangle2.x && rectangle1.y == rectangle2.y;
		}
	}
}