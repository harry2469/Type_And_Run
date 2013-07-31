package com.mvc.view.words
{
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	/**
	 * Display of the portion of letters that the player has left.
	 * @author Kristian Welsh
	 */
	public class LettersToSpell extends ActionTextField
	{
		public function LettersToSpell(stage:Stage, position:Point, format:TextFormat = null)
		{
			super(stage, position, format);
			_format.align = "right";
		}
		
		/**
		 * Works like an array's shift function.
		 * @see <a href="http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Array.html#shift()">Adobe Array Page</a>
		 */
		public function shift():String
		{
			var firstLetter:String = text.substr(0, 1);
			text = text.substr(1);
			return firstLetter;
		}
	}

}