package com.mvc.view
{
	import com.events.EntityModelEvent;
	import com.mvc.model.EntityModel;
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Stage;
	
	/**
	 * @author Kristian Welsh
	 */
	public class EntityView
	{
		protected var _model:EntityModel;
		protected var _stage:Stage;
		private var _art:Bitmap;
		
		// PUBLIC
		
		public function EntityView(stage:Stage, model:EntityModel, image:Class)
		{
			_model = model;
			_stage = stage;
			initArt(image, _model.x, _model.y);
			
			_model.addEventListener(EntityModelEvent.POSITION_CHANGE, updatePosition);
		}
		
		public function destroy():void
		{
			_stage.removeChild(_art);
		}
		
		// PRIVATE
		
		private function initArt(image:Class, x:Number, y:Number):void
		{
			_art = new image();
			_art.x = x;
			_art.y = y;
			_stage.addChild(_art);
		}
		
		private function updatePosition(e:EntityModelEvent):void
		{
			_art.x = e.x
			_art.y = e.y
		}
	}
}