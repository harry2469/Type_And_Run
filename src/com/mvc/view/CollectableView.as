package com.mvc.view {
	import com.mvc.model.entities.EntityModel;
	import flash.display.DisplayObjectContainer;
	
	/** @author Kristian Welsh */
	public class CollectableView extends EntityView {
		[Embed(source = "../../../../lib/images/simple/Collectable.png")]
		private var _image:Class;
		
		public function CollectableView(container:DisplayObjectContainer, model:EntityModel) {
			super(container, model, _image);
		}
	}
}