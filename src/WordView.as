package  
{
	import events.WordEvent;
	import events.WordHandlerEvent;
	import flash.display.Stage;
	import flash.geom.Point;
	/**
	 * Manage the display and word progression of a word form the list.
	 * @author 
	 */
	public class WordView
	{
		private var _model:WordModel;
		private var _lettersToType:LettersToType;
		private var _lettersTyped:LettersTyped;
		
		/** Initialise both text boxes. */
		public function WordView(stage:Stage, position:Point, model:WordModel) 
		{
			_model = model
			_lettersToType = new LettersToType(stage, position, model.wordToSpell);
			_lettersTyped = new LettersTyped(stage, position);
			
			_model.addEventListener(WordEvent.ADVANCE, handleAdvance);
			_model.addEventListener(WordEvent.CHANGE, handleChange);
		}
		
		// START EVENT HANDLERS
		
		/// Exchange letters between text boxes in correct curcumstances then adjust the current position.
		public function handleAdvance(e:WordEvent):void
		{
			_lettersTyped.advanceWord(_lettersToType);
			_lettersToType.advanceWord();
		}
		
		/// Changes the viewavle word to the new word in model.
		public function handleChange(e:WordEvent = null):void
		{
			_lettersToType.changeWord(_model.wordToSpell);
			_lettersTyped.reset();
		}
		
		// END EVENT HANDLERS
		
		/** Returns a string representation of the object
		 * @example [Word "cat"]
		 */
		public function toString():String
		{
			return "[Word View \"" + _model.wordToSpell + "\"]";
		}
	}
}