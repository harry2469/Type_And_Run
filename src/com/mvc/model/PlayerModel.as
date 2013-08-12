package com.mvc.model {
	import com.events.WordCompleteEvent;
	import com.mvc.model.words.IWordSlotHandlerModel;
	
	public class PlayerModel extends EntityModel {
		static private const JUMP_BOOST_SIZE:Number = -5;
		
		private var _falling:Boolean = false;
		private var _gravity:Number = 0.2;
		private var _yVelocity:Number = 0;
		
		public function PlayerModel(x:Number, y:Number, width:Number, height:Number, handler:IWordSlotHandlerModel) {
			super(x, y, width, height);
			handler.addEventListener(WordCompleteEvent.JUMP, jumpIfNotFalling);
		}
		
		private function jumpIfNotFalling(e:WordCompleteEvent):void {
			if (!_falling)
				jump();
		}
		
		private function jump():void {
			_yVelocity = JUMP_BOOST_SIZE;
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
	}
}