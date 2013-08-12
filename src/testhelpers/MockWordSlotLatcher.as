package testhelpers
{
	import com.mvc.model.words.IWordSlotLatcher;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class MockWordSlotLatcher extends EventDispatcher implements IWordSlotLatcher
	{
		public function acceptInput(charCode:int):void
		{
			dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, charCode));
		}
	}
}