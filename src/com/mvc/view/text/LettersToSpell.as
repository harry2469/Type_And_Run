package com.mvc.view.text
{
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * Display of the portion of letters that the player has left.
	 * @author Kristian Welsh
	 */
	public class LettersToSpell extends ActionTextField
	{
		/** The colour to display this text in. */
		static private const COLOUR:uint = 0xB98762; // light brown
		private var _pos:uint = 0;
		
		public function LettersToSpell(position:Point, format:TextFormat = null)
		{
			super(position, format);
			_format.align = TextFormatAlign.LEFT;
			this.textColor = COLOUR;
		}
		
		/**
		 * Works like an array's shift function.
		 * @see <a href="http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Array.html#shift()">Array Adobe Docs</a>
		 */
		public function shift():String
		{
			var firstLetter:String = text.substr(_pos, 1);
			super.text = setCharAt(text, " ", _pos++);
			return firstLetter;
		}
		
		/**
		 * Re-applys the TextFormat whenever you set the text to ensure the style doesn't revert to default.
		 * @param	input
		 */
		override public function set text(input:String):void
		{
			super.text = input;
			_pos = 0;
		}
		
		// PRIVATE
		
		private function setCharAt(string:String, char:String, index:int):String
		{
			return string.substr(0,index) + char + string.substr(index + 1);
		}
		
	}

}