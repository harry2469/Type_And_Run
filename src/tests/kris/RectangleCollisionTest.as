package tests.kris {
	import asunitsrc.asunit.framework.TestCase;
	import flash.geom.Rectangle;
	import kris.RectangleCollision;
	public class RectangleCollisionTest extends TestCase {
		public function RectangleCollisionTest(testMethod:String):void {
			super(testMethod);
		}
		
		// detect
		public function detect_should_throw_error_when_both_arguments_are_the_same_object():void {
			var callOn:Rectangle = new Rectangle(0, 0, 0, 0);
			assertThrowsError(RectangleCollision.detect, callOn, callOn);
		}
		
		public function calling_detect_on_intersecting_rectangles_should_return_true():void {
			var callOn:Rectangle = new Rectangle(1, 1, 5, 5);
			var callWith:Rectangle = new Rectangle(2, 2, 5, 5);
			assertTrue(areColliding(callOn, callWith));
		}
		
		public function calling_detect_on_rectangles_with_a_touching_side_should_return_false():void {
			var callOn:Rectangle = new Rectangle(0, 0, 5, 5);
			var callWith:Rectangle = new Rectangle(5, 0, 5, 5);
			assertFalse(areColliding(callOn, callWith));
		}
		
		// Currently only works with rectangles that are rougly the same size and have shallow collisions
		
		// resolve
		public function calling_resolve_should_throw_error_when_both_arguments_are_the_same_object():void {
			var reactionary:Rectangle = newRectangle(0, 0, 0, 0);
			assertThrowsError(RectangleCollision.resolve, reactionary, reactionary);
		}
		
		public function calling_reslove_on_not_colliding_rectangles_returns_reactionary():void {
			var reactionary:Rectangle = new Rectangle(0, 0, 100, 100);
			var stationary:Rectangle = new Rectangle(200, 200, 100, 100);
			var result:Rectangle = RectangleCollision.resolve(reactionary, stationary);
			assertPosition(reactionary, 0, 0);
			assertPosition(stationary, 200, 200);
			assertPosition(result, 0, 0);
		}
		
		public function should_reslove_to_left_correctly_1():void {
			var reactionary:Rectangle = new Rectangle(2, 1, 100, 100);
			var stationary:Rectangle = new Rectangle(100, 0, 100, 100);
			var result:Rectangle = RectangleCollision.resolve(reactionary, stationary);
			assertPosition(reactionary, 2, 1);
			assertPosition(stationary, 100, 0);
			assertPosition(result, 0, 1);
		}
		
		public function should_reslove_to_left_correctly_2():void {
			var reactionary:Rectangle = new Rectangle(2, -1, 100, 100);
			var stationary:Rectangle = new Rectangle(100, 0, 100, 100);
			var result:Rectangle = RectangleCollision.resolve(reactionary, stationary);
			assertPosition(reactionary, 2, -1);
			assertPosition(stationary, 100, 0);
			assertPosition(result, 0, -1);
		}
		
		public function should_reslove_to_right_correctly_1():void {
			var reactionary:Rectangle = new Rectangle(98, 1, 100, 100);
			var stationary:Rectangle = new Rectangle(0, 0, 100, 100);
			var result:Rectangle = RectangleCollision.resolve(reactionary, stationary);
			assertPosition(reactionary, 98, 1);
			assertPosition(stationary, 0, 0);
			assertPosition(result, 100, 1);
		}
		
		public function should_reslove_to_right_correctly_2():void {
			var reactionary:Rectangle = new Rectangle(98, -1, 100, 100);
			var stationary:Rectangle = new Rectangle(0, 0, 100, 100);
			var result:Rectangle = RectangleCollision.resolve(reactionary, stationary);
			assertPosition(reactionary, 98, -1);
			assertPosition(stationary, 0, 0);
			assertPosition(result, 100, -1);
		}
		
		public function should_reslove_to_top_correctly_1():void {
			var reactionary:Rectangle = new Rectangle(1, 2, 100, 100);
			var stationary:Rectangle = new Rectangle(0, 100, 100, 100);
			var result:Rectangle = RectangleCollision.resolve(reactionary, stationary);
			assertPosition(reactionary, 1, 2);
			assertPosition(stationary, 0, 100);
			assertPosition(result, 1, 0);
		}
		
		public function should_reslove_to_top_correctly_2():void {
			var reactionary:Rectangle = new Rectangle(-1, 2, 100, 100);
			var stationary:Rectangle = new Rectangle(0, 100, 100, 100);
			var result:Rectangle = RectangleCollision.resolve(reactionary, stationary);
			assertPosition(reactionary, -1, 2);
			assertPosition(stationary, 0, 100);
			assertPosition(result, -1, 0);
		}
		
		public function should_reslove_to_bottom_correctly_1():void {
			var reactionary:Rectangle = new Rectangle(1, 98, 100, 100);
			var stationary:Rectangle = new Rectangle(0, 0, 100, 100);
			var result:Rectangle = RectangleCollision.resolve(reactionary, stationary);
			assertPosition(reactionary, 1, 98);
			assertPosition(stationary, 0, 0);
			assertPosition(result, 1, 100);
		}
		
		public function should_reslove_to_bottom_correctly_2():void {
			var reactionary:Rectangle = new Rectangle(-1, 98, 100, 100);
			var stationary:Rectangle = new Rectangle(0, 0, 100, 100);
			var result:Rectangle = RectangleCollision.resolve(reactionary, stationary);
			assertPosition(reactionary, -1, 98);
			assertPosition(stationary, 0, 0);
			assertPosition(result, -1, 100);
		}
		
		private function assertPosition(rect:Rectangle, x:Number, y:Number):void {
			assertEquals(x, rect.x);
			assertEquals(y, rect.y);
		}
		
		private function assertThrowsError(... args):void {
			assertTrue(functionThrowsError.apply(null, args));
		}
		
		private function functionThrowsError(functionToCall:Function, ... args):Boolean {
			try {
				functionToCall.apply(null, args);
				return false;
			} catch (error:Error) {
				return true;
			}
			throw new Error("Should not reach this point");
		}
		
		private function newRectangle(x:Number = 0, y:Number = 0, w:Number = 0, h:Number = 0):Rectangle {
			return new Rectangle(x, y, w, h);
		}
		
		private function areColliding(rectangle1:Rectangle, rectangle2:Rectangle):Boolean {
			return RectangleCollision.detect(rectangle1, rectangle2);
		}
	}
}