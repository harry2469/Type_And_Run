package com.mvc.view.entities {
	import com.events.EntityModelEvent;
	import com.mvc.model.entities.EntityModel;
	import com.mvc.model.entities.IEntityModel;
	import flash.display.*;

	/** @author Kristian Welsh */
	public class EntityView {
		private var _container:DisplayObjectContainer;
		private var _art:DisplayObject;

		public function EntityView(container:DisplayObjectContainer, model:IEntityModel, image:Class) {
			_container = container;
			initArt(image, model.x, model.y);
			listenForPositionChanges(model);
		}

		private function initArt(image:Class, x:Number, y:Number):void {
			_art = new image();
			_art.x = x;
			_art.y = y;
			_container.addChild(_art);
		}

		private function listenForPositionChanges(model:IEntityModel):void {
			model.addEventListener(EntityModelEvent.POSITION_CHANGE, updatePosition);
		}

		private function updatePosition(event:EntityModelEvent):void {
			_art.x = event.x
			_art.y = event.y
		}

		public function destroy():void {
			_container.removeChild(_art);
		}
	}
}