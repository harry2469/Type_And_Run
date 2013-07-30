package testhelpers
{
	// Flash import
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	// My imports
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.view.words.IWordSlotView;
	
	public class MockWordSlotView extends EventDispatcher implements IWordSlotView
	{
		public function init(stage:Stage, model:IWordSlotModel):void
		{
			dispatchEvent(new Event(Event.ACTIVATE));
		}
	}

}