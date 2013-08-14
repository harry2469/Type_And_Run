package kris {
	import flash.display.*;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	/**
	 * Generates an output following the pattern of a sinewave that satisfies specified input parameters.
	 * @author Kristian Welsh
	 */
	public class SineGen {
		private static const DEBUG_DOT_COLOUR:uint = 0x000000; // black
		private static const DEBUG_DOT_POSITION = new Point(400, 400);
		private static const DEBUG_DOT_SIZE = 10;
		private static const LOOPING_POINT:Number = 6.28;
		
		private var _debugDot:Shape = new Shape();
		private var _timer:Timer = null;
		private var _scalar:Number = 0;
		private var _speed:Number = 0;
		private var _seed:Number = 0;
		private var _output:Number = 0;
		
		public function SineGen(scalar:Number, timeStep:Number, speed:Number, container:DisplayObjectContainer = null) {
			if (container != null)
				initDebugDot(container);
			
			_scalar = scalar;
			_speed = speed;
			
			_timer = new Timer(timeStep);
			_timer.addEventListener(TimerEvent.TIMER, adjustOutput);
			_timer.start();
		}
		
		private function initDebugDot(container:DisplayObjectContainer):void {
			drawDebugDot();
			container.addChild(_debugDot);
		}
		
		private function drawDebugDot():void {
			_debugDot.graphics.beginFill(DEBUG_DOT_COLOUR);
			_debugDot.graphics.drawCircle(DEBUG_DOT_POSITION.x, DEBUG_DOT_POSITION.y, DEBUG_DOT_SIZE);
		}
		
		private function adjustOutput(e:TimerEvent):void {
			incrementOrLoopSeed();
			positionDebugDot();
		}
		
		private function incrementOrLoopSeed():void {
			if (shouldLoopThisIteration())
				resetSeed();
			else
				incrementSeed();
		}
		
		private function shouldLoopThisIteration():Boolean {
			return _seed < LOOPING_POINT && _seed + _speed > LOOPING_POINT;
		}
		
		private function resetSeed():void {
			_seed = 0;
		}
		
		private function incrementSeed():void {
			_seed += _speed;
		}
		
		private function positionDebugDot():void {
			_debugDot.y = currentOutput;
		}
		
		public function get currentOutput():Number {
			return Math.sin(_seed) * _scalar
		}
	}
}