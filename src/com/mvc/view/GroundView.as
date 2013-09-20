package com.mvc.view {
	import com.mvc.model.entities.EntityModel;
	import flash.display.DisplayObjectContainer;
	
	/** @author Kristian Welsh */
	public class GroundView extends EntityView {
		[Embed(source="../../../../lib/images/simple/Ground.png")]
		private var _image:Class;
		
		public function GroundView(container:DisplayObjectContainer, model:EntityModel) {
			super(container, model, _image);
		}
	}
}