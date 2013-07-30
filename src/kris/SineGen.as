package kris
{
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class SineGen
	{
		private var _debugDot:Shape = null;
		private var _scalar:Number = 0;
		private var _speed:Number = 0;
		
		private var _seed:Number = 0;
		private var _output:Number = 0;
		private var _timer:Timer = null;
		
		public function SineGen(scalar:Number, speed:Number, stage:Stage = null)
		{
			if (stage != null) {
				_debugDot = new Shape();
				_debugDot.graphics.beginFill(0x000000);
				_debugDot.graphics.drawCircle(stage.stageWidth / 2, stage.stageHeight / 2, 10);
				stage.addChild(_debugDot);
			}
			
			_scalar = scalar;
			_speed = speed;
			_seed = 0;
			_output = 0;
			
			_timer = new Timer(1);
			_timer.addEventListener(TimerEvent.TIMER, adjust);
			_timer.start();
		}
		
		private function adjust(e:TimerEvent):void
		{
			if (_seed < 6.28 && _seed + _speed > 6.28) {
				_seed = 0;
			} else {
				_seed += _speed;
			}
			
			_output = Math.sin(_seed) * _scalar;
			
			_debugDot.y = _output;
		}
		
	}

}