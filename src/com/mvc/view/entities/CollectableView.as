package com.mvc.view.entities {
	import com.mvc.model.entities.EntityModel;
	import com.mvc.model.entities.ICollectable;
	import flash.display.DisplayObjectContainer;

	/** @author Kristian Welsh */
	public class CollectableView extends EntityView {
		[Embed(source = "../../../../../lib/images/simple/Collectable.png")]
		private var _image:Class;

		public function CollectableView(container:DisplayObjectContainer, model:ICollectable) {
			super(container, model, _image);
		}
	}
}