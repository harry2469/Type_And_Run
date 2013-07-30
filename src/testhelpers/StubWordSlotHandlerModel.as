package testhelpers
{
	// Flash imports
	import flash.events.EventDispatcher;
	
	// My imports
	import com.mvc.model.words.IWordSlotHandlerModel;
	
	public class StubWordSlotHandlerModel extends EventDispatcher implements IWordSlotHandlerModel
	{
		public function acceptInput(charCode:int):void { }
		public function initWordSlots():void { }
	}

}