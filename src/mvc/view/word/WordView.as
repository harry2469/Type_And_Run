package mvc.view.word
{
	// Flash Imports
	import flash.display.Stage;
	import flash.geom.Point;
	
	// My Imports
	import events.WordEvent;
	import events.WordHandlerEvent;
	import mvc.model.WordModel;
	
	/**
	 * Manage the display and word progression of a word form the list.
	 * @author 
	 */
	public class WordView
	{
		private var _model:WordModel;
		private var _lettersToSpell:LettersToSpell;
		private var _lettersSpelt:LettersSpelt;
		
		/** Initialise both text boxes. */
		public function WordView(stage:Stage, position:Point, model:WordModel) 
		{
			_model = model
			_lettersToSpell = new LettersToSpell(stage, position, model.wordToSpell);
			_lettersSpelt = new LettersSpelt(stage, position);
			
			_model.addEventListener(WordEvent.ADVANCE, handleAdvance);
			_model.addEventListener(WordEvent.CHANGE, handleChange);
		}
		
		// START EVENT HANDLERS
		
		/// Exchange letters between text boxes in correct curcumstances then adjust the current position.
		public function handleAdvance(e:WordEvent):void
		{
			_lettersSpelt.advanceWord(_lettersToSpell);
			_lettersToSpell.advanceWord();
		}
		
		/// Changes the viewavle word to the new word in model.
		public function handleChange(e:WordEvent = null):void
		{
			_lettersToSpell.changeWord(_model.wordToSpell);
			_lettersSpelt.reset();
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