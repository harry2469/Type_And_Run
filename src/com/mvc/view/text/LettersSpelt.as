package com.mvc.view.text
{
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	/**
	 * Displays the letters you have yet to spell.
	 * @author Kristian Welsh
	 */
	public class LettersSpelt extends ActionTextField
	{
		/** The colour to display this text in. */
		static private const COLOUR:uint = 0x00CC00; // Med-Dark Green
		
		public function LettersSpelt(position:Point, format:TextFormat = null)
		{
			super(position, format);
			this.textColor = COLOUR;
		}
	}
}