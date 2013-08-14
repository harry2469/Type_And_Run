package com.mvc.view.text {
	import flash.geom.Point;
	import flash.text.*;
	
	/** @author Kristian Welsh */
	public class LettersToSpell extends ActionTextField {
		private static const COLOUR:uint = 0xB98762; // light brown
		private var _pos:uint = 0;
		
		public function LettersToSpell(position:Point, format:TextFormat = null) {
			super(position, format);
			_format.align = TextFormatAlign.LEFT;
			this.textColor = COLOUR;
		}
		
		/** returns the first letter and replaces it with a space. */
		public function shift():String {
			var firstLetter:String = text.substr(_pos, 1);
			super.text = setCharAt(text, " ", _pos);
			_pos++;
			return firstLetter;
		}
		
		private function setCharAt(string:String, char:String, index:int):String {
			return string.substr(0, index) + char + string.substr(index + 1);
		}
		
		override public function set text(input:String):void {
			super.text = input;
			_pos = 0;
		}
	}
}