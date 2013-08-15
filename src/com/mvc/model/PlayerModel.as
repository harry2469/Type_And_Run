package com.mvc.model {
	import com.events.WordCompleteEvent;
	import com.mvc.model.words.WordSlotListener;
	import org.flashdevelop.utils.FlashConnect;
	
	public class PlayerModel extends EntityModel {
		private static const JUMP_BOOST_SIZE:Number = 3;
		static public const WALK_SPEED:Number = 0.5;
		
		private var _falling:Boolean = false;
		private var _gravity:Number = 0.05;
		private var _yVelocity:Number = 0;
		
		public function PlayerModel(x:Number, y:Number, width:Number, height:Number, wordSlotListener:WordSlotListener) {
			super(x, y, width, height);
			wordSlotListener.addEventListener(WordCompleteEvent.JUMP, jumpIfNotFalling);
		}
		
		private function jumpIfNotFalling(e:WordCompleteEvent):void {
			if (!_falling)
				jump();
		}
		
		private function jump():void {
			_yVelocity = -JUMP_BOOST_SIZE;
			_falling = true;
		}
		
		public function fallIfFalling():void {
			if (_falling)
				fall();
		}
		
		private function fall():void {
			accelerate();
			moveBy(0, _yVelocity);
		}
		
		private function accelerate():void {
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