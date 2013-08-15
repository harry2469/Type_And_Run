package com.mvc.view {
	import com.mvc.model.EntityModel;
	import flash.display.Stage;
	
	/** @author Kristian Welsh */
	public class GroundView extends EntityView {
		[Embed(source="../../../../lib/images/simple/Ground.png")]
		private var _image:Class;
		
		public function GroundView(stage:Stage, model:EntityModel) {
			super(stage, model, _image);
		}
	}
}