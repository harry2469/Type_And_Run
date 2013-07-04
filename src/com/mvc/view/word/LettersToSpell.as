package com.mvc.view.word
{
	// Flash Imports
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Stage;
	import flash.geom.Point;
	
	/**
	 * Display of the portion of letters that the player has left
	 * to type and handle the removal of letters from the display.
	 * @author Kristian Welsh
	 */
	public class LettersToSpell extends TextField
	{
		/** Size of the font to display the word in. */
		static private const FONTSIZE:Number = 20;
		
		/** TextFormat object save in global scope to re-apply after text change */
		private var _format:TextFormat = new TextFormat();
		
		/**
		 * Initialise the object.
		 * @param	stage
		 * @param	position
		 * @param	startingWord
		 */
		public function init(stage:Stage, position:Point, startingWord:String):void
		{
			initPositionals(stage, position);
			adjustParameters(startingWord);
		}
		
		// PUBLIC FUNCTIONS
		
		/**
		 * Re-applys the TextFormat whenever you set the text to ensure the style remains consistent.
		 * Not a language integrated "set" function because i can't override the existing one from the superclass "TextField".
		 * @param	input
		 */
		public function setText(input:String):void
		{
			text = input;
			setTextFormat(_format);
		}
		
		/**
		 * Return the first letter of the TextField's text.
		 * @return	First letter.
		 */
		public function get firstLetter():String
		{
			return text.substr(0, 1);
		}
		
		/** Remove the first letter from this TextField. */
		public function advanceWord():void
		{
			setText(text.substr(1));
		}
		
		/**
		 * Public wrapper for the adjustParameters function with a different name to make it more user friendly.
		 * @param	wordToSpell
		 * @see		adjustParameters()
		 */
		public function changeWord(wordToSpell:String):void
		{
			adjustParameters(wordToSpell);
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
		
		/**
		 * Reset the TextField's display settings to object defaults.
		 * @param	startingWord
		 */
		private function adjustParameters(newSpelling:String):void
		{
			text = newSpelling;
			// TODO decide on a standard text field size so i dont have to pass the starting word to this.
			// TODO seperate the assignment of startingWord.
			resetFormat();
			adjustDimensions();
			// Operation order is important.
		}
		
		/** return the format object to object defaults */
		private function resetFormat():void
		{
			_format.size = FONTSIZE;
			_format.align = "right";
			setTextFormat(_format);
		}
		
		/** Resize the textbox to fit correctly arround the current text. */
		private function adjustDimensions():void
		{
			width = textWidth + 5;
			height = textHeight + 5;
		}
	}

}