package com.mvc.model.words {
	import com.events.WordSlotEvent;
	import flash.events.EventDispatcher;
	
	/** @author Kristian Welsh */
	public class WordSlotListener extends EventDispatcher {
		private var _handler:IWordSlotHandlerModel;
		private var _slots:Vector.<IWordSlotModel>;
		
		public function WordSlotListener(handler:IWordSlotHandlerModel, wordSlotModels:Vector.<IWordSlotModel>) {
			_handler = handler;
			_slots = wordSlotModels;
		}
		
		public function listen():void {
			for (var i:int = 0; i < _slots.length; i++)
				_slots[i].addEventListener(WordSlotEvent.FINISH, onWordFinish);
		}
		
		public function destroy():void {
			for (var i:int = 0; i < _slots.length; ++i)
				_slots[i].removeEventListener(WordSlotEvent.FINISH, onWordFinish);
		}
		
		private function onWordFinish(e:WordSlotEvent):void {
			_handler.giveWordNewSpelling(e.target as IWordSlotModel);
			dispatchEvent(new WordCompleteEvent(WordCompleteEvent.JUMP));
		}
	}
}