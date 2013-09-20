package com.mvc.view {
	import com.events.PointsCounterEvent;
	import com.mvc.model.PointsCounterModel;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	/** @author Kristian Welsh */
	public class PointsCounterView {
		private var _text:TextField = new TextField();
		
		public function PointsCounterView(container:DisplayObjectContainer, model:PointsCounterModel) {
			container.addChild(_text);
			model.addEventListener(PointsCounterEvent.UPDATE_AMOUNT, updateCounter);
		}
		
		private function updateCounter(event:PointsCounterEvent):void {
			_text.text = ""+event.amount;
		}
	}
}