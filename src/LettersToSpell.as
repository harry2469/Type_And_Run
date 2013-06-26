package  
{
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Display of the portion of letters that the player has left
	 * to type and handle the removal of letters from the display.
	 * @author 
	 */
	public class LettersToSpell extends TextField 
	{
		static private const FONTSIZE:Number = 20;
		private var _format:TextFormat = new TextFormat();
		
		/** Initialise the object. */
		public function LettersToSpell(stage:Stage, position:Point, startingWord:String):void
		{
			super();
			this.x = position.x;
			this.y = position.y;
			stage.addChild(this);
			
			adjustParameters(startingWord); // Ten spaces
		}
		
		public function set wordToSpell(input:String):void
		{
			adjustParameters(input);
		}
		/** Remove the first letter. */
		public function advanceWord():void 
		{
			setText(text.substr(1));
		}
		/** Reset the TextField's settings to initial settings. */
		private function adjustParameters(startingWord:String):void 
		{
			text = startingWord;
			// TODO decide on a standard text field size so i dont have to pass the starting word to this.
			// TODO seperate the assignment of startingWord.
			
			_format.size = FONTSIZE;
			_format.align = "right";
			setTextFormat(_format);
			
			width = textWidth + 5;
			height = textHeight + 5;
			// The property assignment order is important.
		}
		/** Return the first letter. */
		public function get firstLetter():String { return text.substr(0, 1); }
		
		public function setText(input:String):void
		{
			text = input;
			setTextFormat(_format);
		}
		
		public function changeWord(wordToSpell:String):void 
		{
			adjustParameters(wordToSpell);
		}
	}

}