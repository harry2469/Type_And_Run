package  
{
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Display of the portion of letters that the player has left
	 * to type and handle the removal of letters from the display.
	 * @author 
	 */
	public class LettersToType extends TextField 
	{
		static private const FONTSIZE:Number = 20;
		private var _format:TextFormat;
		
		public function LettersToType(stage:Stage, startingWord:String, newY:Number) 
		{
			super();
			// TODO seperate the assignment of startingWord
			this.y = newY;
			_format = new TextFormat();
			_format.size = FONTSIZE;
			_format.align = "right";
			
			text = startingWord;
			setTextFormat(_format);
			width = textWidth + 5;
			height = textHeight + 5;
			stage.addChild(this);
			// the property assignment order is important
		}
		
		public function advanceWord():void 
		{
			text = text.substr(1);
			setTextFormat(_format);
		}
		
		public function getFirstLetter():String
		{
			return text.substr(0, 1);
		}
		
		public function get firstLetter():String { return text.substr(0, 1); }
	}

}