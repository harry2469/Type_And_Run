package kris {
	import flash.geom.Point;
	/** @author Kristian Welsh */
	public class Dimentions {
		public var width:Number;
		public var height:Number;
		
		public function Dimentions(width:Number, height:Number) {
			this.width = width;
			this.height = height;
		}
		
		public function toPoint():Point {
			return new Point(width, height);
		}
	}
}