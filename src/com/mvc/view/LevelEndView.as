package com.mvc.view {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class LevelEndView extends Sprite {
		private var message:TextField;
		static public const FAILURE_MESSAGE:String = "You have failed the level";
		static public const SUCCESS_MESSAGE:String = "You have compleated the level";
		static public const FONTSIZE:Number = 20;
		
		public function LevelEndView(container:DisplayObjectContainer) {
			visible = false;
			container.addChild(this);
			message = new TextField();
			message.selectable = false;
			message.x = 200;
			message.y = 200;
			message.width = 200;
			addChild(message);
		}
		
		public function succeedLevel():void {
			visible = true;
			message.text = SUCCESS_MESSAGE;
		}
		
		public function failLevel():void {
			visible = true;
			message.text = FAILURE_MESSAGE;
		}
	}
}