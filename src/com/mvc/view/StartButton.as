package com.mvc.view {
	import com.mvc.model.GameModel;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	

	public class StartButton extends Sprite{
		private var sprite:Sprite = new Sprite();
		private var model:GameModel;
		
		public function StartButton(container:DisplayObjectContainer, model:GameModel) {
			this.model = model;
			sprite.graphics.beginFill(0);
			sprite.graphics.drawRect(100, 100, 300, 300);
			container.addChild(sprite);
			sprite.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		private function startGame(e:MouseEvent):void {
			sprite.visible = false;
			model.startGame();
		}
	}
}