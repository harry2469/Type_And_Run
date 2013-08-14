package com.mvc.view {
	import com.events.EntityModelEvent;
	import com.mvc.model.EntityModel;
	import flash.display.*;
	
	/** @author Kristian Welsh */
	public class EntityView {
		private var _stage:Stage;
		private var _art:Bitmap;
		
		public function EntityView(stage:Stage, model:EntityModel, image:Class) {
			_stage = stage;
			initArt(image, model.x, model.y);
			listenForPositionChanges(model);
		}
		
		private function initArt(image:Class, x:Number, y:Number):void {
			_art = new image();
			_art.x = x;
			_art.y = y;
			_stage.addChild(_art);
		}
		
		private function listenForPositionChanges(model:EntityModel):void {
			model.addEventListener(EntityModelEvent.POSITION_CHANGE, updatePosition);
		}
		
		private function updatePosition(event:EntityModelEvent):void {
			_art.x = event.x
			_art.y = event.y
		}
		
		public function destroy():void {
			_stage.removeChild(_art);
		}
	}
}