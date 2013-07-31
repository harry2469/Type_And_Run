package com.mvc.view.text
{
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * TextField for displaying a spellable word.
	 * @author Kristian Welsh
	 */
	public class ActionTextField extends TextField
	{
		/** Size of the font to display the word in. */
		static private const FONTSIZE:Number = 20;
		
		/** standard width of ActionTextFields */
		static private const WIDTH:Number = 101;
		
		/** standard height of ActionTextFields */
		static private const HEIGHT:Number = 25;
		
		/** TextFormat object save in global scope to re-apply after text change */
		protected var _format:TextFormat;
		
		// PUBLIC
		
		public function ActionTextField(position:Point, format:TextFormat)
		{
			super();
			initPosition(position);
			initFormat(format);
		}
		
		/**
		 * Re-applys the TextFormat whenever you set the text to ensure the style doesn't revert to default.
		 * @param	input
		 */
		override public function set text(input:String):void
		{
			super.text = input;
			setTextFormat(_format);
		}
		
		// PRIVATE
		
		/**
		 * Adds the text field to the stage at the right place with the right dimentions.
		 * @param	stage
		 * @param	position
		 */
		private function initPosition(position:Point):void
		{
			this.x = position.x;
			this.y = position.y;
			width = WIDTH;
			height = HEIGHT;
		}
		
		/**
		 * Applys initial formating to the TextField.
		 * @param	format
		 */
		private function initFormat(format:TextFormat):void
		{
			_format = format || new TextFormat();
			_format.size = FONTSIZE
			_format.font = "Courier New"; // Currently only works correctly with monospce fonts
			_format.bold = true;
		}
	}
}