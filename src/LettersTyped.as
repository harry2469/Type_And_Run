package  
{
	import flash.display.Stage;
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
		private var _format:TextFormat;
		
		public function LettersTyped(stage:Stage, newY:Number) 
		{
			super();
			this.y = newY;
			
			_format = new TextFormat();
			_format.size = FONTSIZE;
			
			textColor = COLOUR;
			setTextFormat(_format);
			stage.addChild(this);
		}
		
		public function advanceWord(lettersToType:LettersToType):void 
		{
			appendText(lettersToType.getFirstLetter());
			setTextFormat(_format);
		}
	}
}