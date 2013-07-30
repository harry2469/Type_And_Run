package com.mvc.view
{
	// FlashDevelop Imports
	import com.events.PlayerModelEvent;
	import com.mvc.model.IPlayerModel;
	import com.mvc.model.PlayerModel;
	
	// Flash Imports
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Kristian Welsh
	 */
	public class PlayerView
	{
		private var _art:Shape;
		private var _model:IPlayerModel;
		private var _stage:Stage;
		
		// PUBLIC
		
		public function PlayerView(stage:Stage, model:IPlayerModel)
		{
			_model = model;
			_stage = stage;
			initArt();
			_model.addEventListener(PlayerModelEvent.CHANGE_POSITION, updatePosition);
		}
		
		/** Returns the object's x position */
		public function get x():Number { return _art.x; }
		
		/** Returns the object's y position */
		public function get y():Number { return _art.y; }
		
		/** Removes the playerview completely */
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
			_art.graphics.beginFill(0, 1);
			_art.graphics.drawRect(0, 0, 40, 70);
		}
		
		private function updatePosition(e:PlayerModelEvent):void
		{
			_art.x = e.position.x
			_art.y = e.position.y
		}
	}

}