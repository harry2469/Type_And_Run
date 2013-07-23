package com.mvc.view.words
{
	// Flash imports
	import flash.display.Stage;
	import flash.geom.Point;
	
	// My imports
	import com.mvc.model.words.IWordSlotModel;
	
	/**
	 * Interface for the WordSlotView class.
	 * @author Kristian Welsh
	 */
	public interface IWordSlotView
	{
		function init(stage:Stage, model:IWordSlotModel):void;
	}
}