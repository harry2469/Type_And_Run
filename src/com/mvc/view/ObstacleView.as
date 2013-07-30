package com.mvc.view
{
	// FlashDevelop Imports
	import com.events.EntityModelEvent;
	import com.mvc.model.ObstacleModel;
	import com.mvc.model.PlayerModel;
	
	// Flash Imports
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class ObstacleView
	{
		private var _art:Shape;
		private var _model:ObstacleModel;
		private var _stage:Stage;
		
		// PUBLIC
		
		public function ObstacleView(stage:Stage, model:ObstacleModel)
		{
			_model = model;
			_stage = stage;
			initArt();
			_model.addEventListener(EntityModelEvent.POSITION_CHANGE, updatePosition);
		}
		
		/** Returns the object's x position */
		public function get x():Number { return _art.x; }
		
		/** Returns the object's y position */
		public function get y():Number { return _art.y; }
		
		/** Removes the obstacleview completely */
		public function destroy():void
		{
			_stage.removeChild(_art);
		}
		
		// PRIVATE
		
		/** Returns the garphics of the PlayerView */
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
			_art.graphics.beginFill(0xFF0000, 1);
			_art.graphics.drawRect(0, 0, 40, 40);
		}
		
		private function updatePosition(e:EntityModelEvent):void
		{
			_art.x = e.position.x
			_art.y = e.position.y
		}
	}

}