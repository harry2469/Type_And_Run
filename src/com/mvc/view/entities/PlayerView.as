package com.mvc.view.entities {
	import com.mvc.model.entities.EntityModel;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;

	/** @author Kristian Welsh */
	public class PlayerView extends EntityView {
		[Embed(source="../../../../../lib/images/simple/Player.png")]
		private var _image:Class;

		public static const WIDTH:int = 53;

		public function PlayerView(container:DisplayObjectContainer, model:EntityModel) {
			super(container, model, PlayerAnimation);
		}
	}
}