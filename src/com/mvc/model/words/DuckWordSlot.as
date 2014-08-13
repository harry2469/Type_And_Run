package com.mvc.model.words {
	import com.events.WordCompleteEvent;

	public class DuckWordSlot extends WordSlotModel {
		override public function get action():String {
			return WordCompleteEvent.DUCK;
		}
	}
}