package com.mvc.controller
{
	import com.mvc.model.words.IWordSlotLatcher;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	/**
	 * Manage Keyboard Input From The User.
	 * @author KristianWelsh
	 */
	public class InputOpperator
	{
		private var _stage:Stage = null;
		private var _wordLatcher:IWordSlotLatcher = null;
		
		public function InputOpperator(stage:Stage, wordLatcher:IWordSlotLatcher)
		{
			_stage = stage;
			_wordLatcher = wordLatcher;
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			_wordLatcher.acceptInput(e.charCode);
		}
	}
}