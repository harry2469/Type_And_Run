package com.mvc.view
{
	import com.events.EntityModelEvent;
	import com.mvc.model.EntityModel;
	import flash.display.Shape;
	import flash.display.Stage;
	
	/**
	 * @author Kristian Welsh
	 */
	public class EntityView
	{
		protected var _art:Shape;
		protected var _model:EntityModel;
		protected var _stage:Stage;
		private var _colour:uint;
		
		// PUBLIC
		
		public function EntityView(stage:Stage, model:EntityModel, colour:uint)
		{
			_model = model;
			_stage = stage;
			_colour = colour;
			initArt();
			_model.addEventListener(EntityModelEvent.POSITION_CHANGE, updatePosition);
		}
		
		public function destroy():void
		{
			_stage.removeChild(_art);
		}
		
		// PRIVATE
		
		private function get art():Shape { return _art; }
		
		private function initArt():void
		{
			_art = new Shape();
			initGraphics();
			_art.x = _model.x;
			_art.y = _model.y;
			_stage.addChild(_art);
		}
		
		private function initGraphics():void
		{
			_art.graphics.beginFill(_colour, 1);
			_art.graphics.drawRect(0, 0, _model.width, _model.height);
		}
		
		private function updatePosition(e:EntityModelEvent):void
		{
			_art.x = e.x
			_art.y = e.y
		}
	}
}