package kris
{
	
	/**
	 * A collection of utility functions
	 * @author Kristian Welsh
	 */
	public class Util
	{
		public static function toCharcode(input:String):int
		{
			if (input.length > 1) throw new Error ("Input much be a single character string.", 1001);
			return input.charCodeAt(0);
		}
		
		public static function scrambleArray(list:Array):Array
		{
			var tempHolder:*;
			var randomNum:int = 0;
			var length:int = list.length - 1
			
			for (var i:int = 0; i < length; ++i) {
				randomNum = randomIntBetweenBounds(i + 1, length);
				tempHolder = list[randomNum];
				list[randomNum] = list[i];
				list[i] = tempHolder;
			}
			return list;
		}
		
		public static function scrambleStringVector(list:Vector.<String>):Vector.<String>
		{
			if (!list is Vector.<String>) throw new Error("Input must be a Vector of Strings", 1002) ;
			
			var tempHolder:String;
			var randomNum:int = 0;
			var length:int = list.length - 1
			
			for (var i:int = 0; i < length; ++i) {
				randomNum = randomIntBetweenBounds(i + 1, length);
				tempHolder = list[randomNum];
				list[randomNum] = list[i];
				list[i] = tempHolder;
			}
			return list;
		}
		
		public static function scrambleNumberVector(list:Vector.<Number>):Vector.<Number>
		{
			if (!(list is Vector.<Number>)) throw new Error("Input must be a Vector of Numbers") ;
			
			var tempHolder:Number;
			var randomNum:int = 0;
			var length:int = list.length - 1
			
			for (var i:int = 0; i < length; ++i) {
				randomNum = randomIntBetweenBounds(i + 1, length);
				tempHolder = list[randomNum];
				list[randomNum] = list[i];
				list[i] = tempHolder;
			}
			return list;
		}
		
		/**
		 * Return a random integer between bounds.
		 * @param	lowerBound
		 * @param	upperBound
		 * @return	random int between the lower and upper bounds.
		 */
		public static function randomIntBetweenBounds(lowerBound:int, upperBound:int):int {
			return Math.floor(Math.random() * (upperBound - lowerBound + 1) + lowerBound);
		}
	}

}