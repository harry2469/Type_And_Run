package kris {
	
	/**
	 * A collection of utility functions
	 * @author Kristian Welsh
	 */
	public class Util {
		
		public static function stringLetterAt(index:int, input:String):String {
			return input.slice(index, index + 1);
		}
		
		public static function toCharcode(input:String):int {
			if (input.length > 1)
				throw new Error("Input much be a single character string.");
			return input.charCodeAt(0);
		}
		
		// it is impossible to dynamically cast a vector to a different type of vector, so i can't condense these down to scrambleVector()
		public static function scrambleStringVector(list:Vector.<String>):Vector.<String> {
			var array:Array = toArray(list)
			var scrambledArray:Array = scrambleArray(array)
			var vector:Vector.<String> = Vector.<String>(scrambledArray);
			return vector;
		}
		
		public static function scrambleNumberVector(list:Vector.<Number>):Vector.<Number> {
			var array:Array = toArray(list)
			var scrambledArray:Array = scrambleArray(array)
			var vector:Vector.<Number> = Vector.<Number>(scrambledArray);
			return vector;
		}
		
		public static function toArray(list:*):Array {
			var returnMe:Array = [];
			for each (var item:*in list)
				returnMe.push(item);
			return returnMe;
		}
		
		public static function scrambleArray(list:Array):Array {
			var arrayToScramble:Array = cloneArray(list);
			var returnMe:Array = [];
			var randomNum:int = 0;
			
			for (var i:int = 0; i < list.length; ++i) {
				randomNum = randomIntBetweenBounds(0, arrayToScramble.length - 1);
				returnMe.push(arrayToScramble.splice(randomNum, 1)[0]);
			}
			return returnMe;
		}
		
		public static function cloneArray(arrayToClone:Array):Array {
			return arrayToClone.slice();
		}
		
		public static function randomIntBetweenBounds(lowerBound:int, upperBound:int):int {
			var differanceBetweenBounds:Number = (upperBound - lowerBound) + 1;
			// +1 to include upperbound making it "upper >= n >= lower" instead of "upper > n >= lower"
			return Math.floor(Math.random() * differanceBetweenBounds + lowerBound);
		}
		
		/**
		 * return the input array without the input index
		 * non-destructive version of array.splice(index, 1);
		 */
		public static function arrayWithoutIndex(array:Array, index:uint):Array {
			var section1:Array = array.slice(0, index);
			var section2:Array = array.slice(index + 1);
			return section1.concat(section2);
		}
	}

}