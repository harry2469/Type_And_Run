package  
{
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author 
	 */
	public class LettersTyped extends TextField 
	{
		static private const FONTSIZE:Number = 20;
		static private const COLOUR:uint = 0X33FF33;
		private var _format:TextFormat = new TextFormat();
		/** Initialise the object. */
		public function LettersTyped(stage:Stage, position:Point) 
		{
			super();
			this.x = position.x;
			this.y = position.y;
			resetToDefaultSettings();
			stage.addChild(this);
		}
		/** Add the first letter from the letters left to type and append it to the end of this object. */
		public function advanceWord(lettersToType:LettersToType):void 
		{
			appendText(lettersToType.firstLetter);
			setTextFormat(_format);
		}
		/** Reset the TextField's settings to initial settings. */
		private function resetToDefaultSettings():void 
		{
			textColor = COLOUR;
			_format.size = FONTSIZE;
			text = "";
			setTextFormat(_format);
		}
		
		public function setText(input:String):void
		{
			text = input;
			setTextFormat(_format);
		}
		
		public function reset():void 
		{
			resetToDefaultSettings();
		}
	}
}