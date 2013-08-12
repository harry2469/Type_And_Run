package tests.kris
{
	import asunitsrc.asunit.framework.TestCase;
	import flash.geom.Rectangle;
	import kris.RectangleCollision;
	
	public class RectangleCollisionTest extends TestCase
	{
		public function RectangleCollisionTest(testMethod:String):void {
			super(testMethod);
		}
		// TODO: these big tests should be split into smaller more explicitly named tests
		public function should_detect_correctly():void {
			var callOn:Rectangle = newRectangle();
			var callWith:Rectangle = newRectangle();
			assertTrue("Calling isCollidingWith on itself should throw an error", functionThrowsError(RectangleCollision.detect, callOn, callOn));
			
			callOn = newRectangle();
			callWith = newRectangle();
			assertTrue("Calling isCollidingWith on entities at the same position should return true", areColliding(callOn, callWith));
			
			callOn = newRectangle();
			callWith = newRectangle(1, 1);
			assertFalse("Calling isCollidingWith on two points at the different positions should return false", areColliding(callOn, callWith));
			
			callOn = newRectangle(1, 1, 5, 5);
			callWith = newRectangle(2, 2, 5, 5);
			assertTrue("Calling isCollidingWith on two intersecting non-point entities should return true", areColliding(callOn, callWith));
			
			callOn = newRectangle(1, 1, 5, 5);
			callWith = newRectangle(6, 6, 5, 5);
			assertFalse("Calling isCollidingWith on two entities with corners at the same position should return false", areColliding(callOn, callWith));
			
			callOn = newRectangle(0, 0, 5, 5);
			callWith = newRectangle(5, 0, 5, 5);
			assertFalse("Calling isCollidingWith on two entities with a touching side should return false", areColliding(callOn, callWith));
			
		}
		
		public function should_resolve_correctly():void {
			// Currently only works with rectangles that are rougly the same size and have shallow collisions
			var reactionary:Rectangle;
			var stationary:Rectangle;
			
			// SAME OBJECT ERROR
			{
				reactionary = newRectangle(0, 0, 100, 100);
				stationary = newRectangle(200, 200, 100, 100);
				
				assertTrue(functionThrowsError(RectangleCollision.resolve, reactionary, reactionary));
			}
			
			// NOT COLLIDING
			{
				reactionary = newRectangle(0, 0, 100, 100);
				stationary = newRectangle(200, 200, 100, 100);
				
				reactionary = RectangleCollision.resolve(reactionary, stationary);
				
				assertEquals(0, reactionary.x);
				assertEquals(0, reactionary.y);
				assertEquals(200, stationary.x);
				assertEquals(200, stationary.y);
			}
			
			// SIMPLE
			{
						// left-side
						{
							reactionary = newRectangle(0, 0, 100, 100);
							stationary = newRectangle(100, 0, 100, 100);
							
							reactionary = RectangleCollision.resolve(reactionary, stationary);
							
							assertEquals(0, reactionary.x);
							assertEquals(0, reactionary.y);
							assertEquals(100, stationary.x);
							assertEquals(0, stationary.y);
						}
						// right-side
						{
							reactionary = newRectangle(100, 0, 100, 100);
							stationary = newRectangle(0, 0, 100, 100);
							
							reactionary = RectangleCollision.resolve(reactionary, stationary);
							
							assertEquals(100, reactionary.x);
							assertEquals(0, reactionary.y);
							assertEquals(0, stationary.x);
							assertEquals(0, stationary.y);
						}
						// top-side
						{
							reactionary = newRectangle(0, 0, 100, 100);
							stationary = newRectangle(0, 100, 100, 100);
							
							reactionary = RectangleCollision.resolve(reactionary, stationary);
							
							assertEquals(0, reactionary.x);
							assertEquals(0, reactionary.y);
							assertEquals(0, stationary.x);
							assertEquals(100, stationary.y);
						}
						// bottom-side
						{
							reactionary = newRectangle(0, 100, 100, 100);
							stationary = newRectangle(0, 0, 100, 100);
							
							reactionary = RectangleCollision.resolve(reactionary, stationary);
							
							assertEquals(0, reactionary.x);
							assertEquals(100, reactionary.y);
							assertEquals(0, stationary.x);
							assertEquals(0, stationary.y);
						}
				}
				
			// OFF-SET
			{
					// left-side 1
					{
						reactionary = newRectangle(2, 1, 100, 100);
						stationary = newRectangle(100, 0, 100, 100);
						
						reactionary = RectangleCollision.resolve(reactionary, stationary);
						
						assertEquals(0, reactionary.x);
						assertEquals(1, reactionary.y);
						assertEquals(100, stationary.x);
						assertEquals(0, stationary.y);
					}
					// left-side 2
					{
						reactionary = newRectangle(2, -1, 100, 100);
						stationary = newRectangle(100, 0, 100, 100);
						
						reactionary = RectangleCollision.resolve(reactionary, stationary);
						
						assertEquals(0, reactionary.x);
						assertEquals(-1, reactionary.y);
						assertEquals(100, stationary.x);
						assertEquals(0, stationary.y);
					}
					// right-side 1
					{
						reactionary = newRectangle(98, 1, 100, 100);
						stationary = newRectangle(0, 0, 100, 100);
						
						reactionary = RectangleCollision.resolve(reactionary, stationary);
						
						assertEquals(100, reactionary.x);
						assertEquals(1, reactionary.y);
						assertEquals(0, stationary.x);
						assertEquals(0, stationary.y);
					}
					// right-side 2
					{
						reactionary = newRectangle(98, -1, 100, 100);
						stationary = newRectangle(0, 0, 100, 100);
						
						reactionary = RectangleCollision.resolve(reactionary, stationary);
						
						assertEquals(100, reactionary.x);
						assertEquals(-1, reactionary.y);
						assertEquals(0, stationary.x);
						assertEquals(0, stationary.y);
					}
					// top-side 1
					{
						reactionary = newRectangle(1, 2, 100, 100);
						stationary = newRectangle(0, 100, 100, 100);
						
						reactionary = RectangleCollision.resolve(reactionary, stationary);
						
						assertEquals(1, reactionary.x);
						assertEquals(0, reactionary.y);
						assertEquals(0, stationary.x);
						assertEquals(100, stationary.y);
					}
					// top-side 2
					{
						reactionary = newRectangle(-1, 2, 100, 100);
						stationary = newRectangle(0, 100, 100, 100);
						
						reactionary = RectangleCollision.resolve(reactionary, stationary);
						
						assertEquals(-1, reactionary.x);
						assertEquals(0, reactionary.y);
						assertEquals(0, stationary.x);
						assertEquals(100, stationary.y);
					}
			}
		}
		
		private function newRectangle(x:Number = 0, y:Number = 0, w:Number = 0, h:Number = 0):Rectangle {
			return new Rectangle(x, y, w, h);
		}
		
		private function areColliding(rectangle1:Rectangle, rectangle2:Rectangle):Boolean {
			return RectangleCollision.detect(rectangle1, rectangle2);
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
	}
}