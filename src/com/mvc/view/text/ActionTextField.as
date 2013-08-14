package com.mvc.view.text {
	import flash.geom.Point;
	import flash.text.*;
	
	/** @author Kristian Welsh */
	public class ActionTextField extends TextField {
		private static const FONTSIZE:Number = 20;
		private static const WIDTH:Number = 101;
		private static const HEIGHT:Number = 25;
		
		protected var _format:TextFormat;
		
		public function ActionTextField(position:Point, format:TextFormat = null) {
			super();
			initPosition(position);
			initFormat(format);
		}
		
		private function initPosition(position:Point):void {
			this.x = position.x;
			this.y = position.y;
			width = WIDTH;
			height = HEIGHT;
		}
		
		private function initFormat(format:TextFormat):void {
			_format = format || new TextFormat();
			_format.size = FONTSIZE
			_format.font = "Courier New"; // Currently only works correctly with monospce fonts
			_format.bold = true;
		}
		
		/** you need to re-apply the format each time the text is changed or it reverts to defaults */
		override public function set text(input:String):void {
			super.text = input;
			setTextFormat(_format);
		}
	}
}