package com.mvc.model.entities {
	import com.events.WordCompleteEvent;
	import com.mvc.model.words.WordSlotListener;
	import com.SoundManager;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.flashdevelop.utils.FlashConnect;

	public class PlayerModel extends EntityModel {
		private static const JUMP_BOOST_SIZE:Number = 3;
		static public const WALK_SPEED:Number = 0.5;

		private var _falling:Boolean = false;
		private var _gravity:Number = 0.05;
		private var _yVelocity:Number = 0;
		private var _soundManager:SoundManager;
		private var _previousHeight:Number;

		private var _duckTimer:Timer = new Timer(5000);
		private var _ducking:Boolean = false;

		public function PlayerModel(x:Number, y:Number, width:Number, height:Number, wordSlotListener:WordSlotListener, soundManager:SoundManager) {
			super(x, y, width, height);
			_soundManager = soundManager;
			wordSlotListener.addEventListener(WordCompleteEvent.JUMP, jumpIfPossible);
			wordSlotListener.addEventListener(WordCompleteEvent.DUCK, duckIfPossible);
			_duckTimer.addEventListener(TimerEvent.TIMER, stopDucking);
		}

		private function duckIfPossible(e:WordCompleteEvent):void {
			if (canPerformMove())
				duck();
		}

		private function jumpIfPossible(e:WordCompleteEvent):void {
			if (canPerformMove())
				jump();
		}

		private function canPerformMove():Boolean {
			return !(_falling || _ducking);
		}

		private function duck():void {
			_previousHeight = _rectangle.height;
			_rectangle.height = 0;

			_duckTimer.start();
		}

		private function stopDucking(e:TimerEvent):void {
			_rectangle.height = _previousHeight;
			_duckTimer.stop();
		}

		private function jump():void {
			_soundManager.playJump();
			_yVelocity = -JUMP_BOOST_SIZE;
			_falling = true;
		}

		public function fallIfFalling():void {
			if (_falling)
				fall();
		}

		private function fall():void {
			accelerateDownward();
			moveBy(0, _yVelocity);
		}

		private function accelerateDownward():void {
			_yVelocity += _gravity;
		}

		public function stopFalling():void {
			_falling = false;
			_yVelocity = 0;
		}

		public function get falling():Boolean {
			return _falling;
		}

		public function advanceIfLeftOf(xTarget:Number):void {
			if (x < xTarget)
				moveBy(WALK_SPEED, 0);
		}
	}
}