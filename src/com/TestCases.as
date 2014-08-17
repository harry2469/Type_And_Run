package com {
	import asunit.framework.TestSuite;
	import com.mvc.controller.InputOpperatorTest;
	import com.mvc.model.EntityModelTest;
	import com.mvc.model.GameLoopTest;
	import com.mvc.model.words.WordSlotLatcherTest;
	import com.mvc.model.words.WordSlotListenerTest;
	import com.mvc.model.words.WordSlotModelTest;
	import kris.RectangleCollisionTest;

	/**
	 * Requires the asunit source in your global classpaths.
	 */
	public class TestCases extends TestSuite {
		public function TestCases() {
			addTest(new EntityModelTest());

			addTest(new WordSlotModelTest());
			addTest(new WordSlotLatcherTest());
			addTest(new WordSlotListenerTest());

			addTest(new InputOpperatorTest());
			addTest(new RectangleCollisionTest());

			addTest(new GameLoopTest());
		}
	}
}