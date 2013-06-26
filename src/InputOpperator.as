package
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	/**
	 * Manage Input From The User And Advance Word Progress.
	 * @author 
	 */
	public class InputOpperator 
	{
		private var _stage:Stage = null;
		private var _wordHandlerModel:WordHandlerModel = null;
		
		/** readys the class for opperation. */
		public function InputOpperator(stage:Stage, wordHandlerModel:WordHandlerModel) 
		{
			_stage = stage;
			_wordHandlerModel = wordHandlerModel
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		/** manage events that occur on key down. */
		private function keyDown(e:KeyboardEvent):void 
		{
			_wordHandlerModel.acceptInput(e.charCode);
		}
		
		/** Stop Listening For Keypresses (For Pause Menus And The Like). */
		public function stopListening():void
		{
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
	}

}