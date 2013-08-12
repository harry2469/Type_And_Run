package kris
{
	import flash.geom.Rectangle;
	
	/**
	 * Handles collision between two rectangles.
	 * @author Kristian Welsh
	 */
	public class RectangleCollision {
		static public function collide(rectangle1:Rectangle, rectangle2:Rectangle):Rectangle {
			if (detect(rectangle1, rectangle2)) return resolve(rectangle1, rectangle2);
			return rectangle1;
		}
		
		static public function detect(rectangle1:Rectangle, rectangle2:Rectangle):Boolean {
			if (areSame(rectangle1, rectangle2)) throw new Error("you cannot detect collision between a rectangle and itself");
			if (areAtSamePoint(rectangle1, rectangle2)) return true;
			return rectangle1.intersects(rectangle2);
		}
		
		static public function resolve(reactionary:Rectangle, stationary:Rectangle):Rectangle {
			// currently only works with rectangles that are rougly the same size and have shallow collisions
			if (reactionary == stationary) throw new Error("you cannot resolve collision between a rectangle and itself");
			return findNewValue(reactionary, stationary);
		}
		
		static private function findNewValue(reactionary:Rectangle, stationary:Rectangle):Rectangle
		{
			var rectangleToReturn:Rectangle = reactionary.clone();
			if (xIsLargestDifferance(overlapArea(reactionary, stationary))) {
				rectangleToReturn.x = resolveAxis(reactionary.x, stationary.x, overlapArea(reactionary, stationary).width);
			} else {
				rectangleToReturn.y = resolveAxis(reactionary.y, stationary.y, overlapArea(reactionary, stationary).height);
			}
			return rectangleToReturn;
		}
		
		static private function overlapArea(reactionary:Rectangle, stationary:Rectangle):Rectangle
		{
			return reactionary.intersection(stationary)
		}
		
		static private function resolveAxis(reactionaryPos:Number, stationaryPos:Number, collisionSize:Number):Number {
			if (reactionaryPos > stationaryPos) {
				return reactionaryPos + collisionSize;
			} else {
				return reactionaryPos - collisionSize;
			}
		}
		
		static private function xIsLargestDifferance(collisionRect:Rectangle):Boolean {
			return collisionRect.width <= collisionRect.height;
		}
		
		static private function areAtSamePoint(rectangle1:Rectangle, rectangle2:Rectangle):Boolean
		{
			return rectangle1.x == rectangle2.x && rectangle1.y == rectangle2.y;
		}
		
		static private function areSame(rectangle1:Rectangle, rectangle2:Rectangle):Boolean
		{
			return rectangle1 == rectangle2;
		}
	}
}