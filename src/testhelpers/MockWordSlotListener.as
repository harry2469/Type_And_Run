package testhelpers {
	import com.mvc.model.words.IWordSlotListener;
	import flash.events.EventDispatcher;
	
	/** @author Kristian Welsh */
	public class MockWordSlotListener extends EventDispatcher implements IWordSlotListener {
		public function listen():void {}
		public function destroy():void {}
	}
}