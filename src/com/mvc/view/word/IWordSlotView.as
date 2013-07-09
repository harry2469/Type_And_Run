package com.mvc.view.word
{
	import com.mvc.model.IWordSlotModel;
	import flash.display.Stage;
	import flash.geom.Point;
	/**
	 * Interface for the WordSlotView class.
	 * @author Kristian Welsh
	 */
	public interface IWordSlotView
	{
		function init(stage:Stage, model:IWordSlotModel):void;
	}
}