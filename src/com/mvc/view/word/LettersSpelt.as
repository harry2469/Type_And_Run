package com.mvc.view.word
{
	//Flash Imports
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Stage;
	import flash.geom.Point;
	
	/**
	 * Shows the letters you have yet to spell.
	 * @author Kristian Welsh
	 */
	public class LettersSpelt extends TextField
	{
		/** The size of the font that this should be displayed in */
		static private const FONTSIZE:Number = 20;
		
		/** The colour to display this text in. */
		static private const COLOUR:uint = 0x00CC00; // Med-Dark Green
		
		/** TextFormat object to format the text */
		private var _format:TextFormat;
		
		// PUBLIC FUNCTIONS
		
		/**
		 * Initialise the object.
		 * @param	stage
		 * @param	position
		 */
		public function init(stage:Stage, position:Point, format:TextFormat):void
		{
			_format = format;
			initPositionals(stage, position);
			reset();
		}
		
		/**
		 * Add the first letter from a LettersToSpell object and append it to the end of this object.
		 * @param	lettersToSpell:LettersToSpell
		 */
		public function advanceWord(lettersToSpell:LettersToSpell):void
		{
			this.appendText(lettersToSpell.firstLetter);
			this.setTextFormat(_format);
		}
		
		/**
		 * Re-applys the TextFormat whenever you set the text to ensure the style remains consistent.
		 * Not a language integrated "set" function because i can't override the existing one from the superclass "TextField".
		 * @param	input:String
		 */
		public function setText(input:String):void
		{
			this.text = input;
			this.setTextFormat(_format);
		}
		
		/**
		 * Reset the TextField to initial settings.
		 */
		public function reset():void
		{
			this.textColor = COLOUR;
			_format.size = FONTSIZE;
			this.text = "";
			this.setTextFormat(_format);
		}
		
		// PRIVATE FUNCTIONS
		
		/**
		 * Position the object to the specified position on the stage.
		 * @param	stage
		 * @param	position
		 */
		private function initPositionals(stage:Stage, position:Point):void
		{
			this.x = position.x;
			this.y = position.y;
			stage.addChild(this);
		}
	}
}