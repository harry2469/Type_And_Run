package com.mvc.model {
	import com.events.PointsCounterEvent;
	import flash.events.EventDispatcher;

	public class PointsCounterModel extends EventDispatcher implements IPointsCounter {
		private var _points:uint = 0;
		public function addPoint():void {
			_points++;
			dispatchEvent(new PointsCounterEvent(PointsCounterEvent.UPDATE_AMOUNT, _points));
		}
	}
}