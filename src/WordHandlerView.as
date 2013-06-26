package  
{
	import events.WordHandlerEvent;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * Handle the display of spellable words.
	 * @author 
	 */
	public class WordHandlerView
	{
		private var _stage:Stage;
		private var _model:WordHandlerModel;
		
		private var _wordObjects:Vector.<WordView> = new Vector.<WordView>();
		
		public function WordHandlerView(stage:Stage, model:WordHandlerModel):void
		{
			_stage = stage;
			_model = model;
			_model.addEventListener(WordHandlerEvent.CREATE, wordCreated);
		}
		
		private function wordCreated(e:WordHandlerEvent):void
		{
			_wordObjects.push(new WordView(_stage, e.position, e.newWord));
		}
		
		/** Return the current number of active word slots. */
		public function get length():uint { return _wordObjects.length }
		/** Return all current active word slots. */
		public function get wordObjects():Vector.<WordView> { return _wordObjects; }
	}

}