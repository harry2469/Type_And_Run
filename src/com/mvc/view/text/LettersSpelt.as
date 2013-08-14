package com.mvc.view.text {
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	/** @author Kristian Welsh */
	public class LettersSpelt extends ActionTextField {
		private static const COLOUR:uint = 0x00CC00; // Medium-Dark Green
		
		public function LettersSpelt(position:Point, format:TextFormat = null) {
			super(position, format);
			this.textColor = COLOUR;
		}
	}
}