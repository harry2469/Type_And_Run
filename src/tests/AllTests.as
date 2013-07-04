package tests
{
	// Asunit imports
	import asunit.framework.TestSuite;
	
	// My importss
	import tests.events.WordSlotHandlerEventTest;
	
	// TODO: make failed tests show a stack trace.
	
	/**
	 * Executes all unit tests for the aplication.
	 * @author Kristian Welsh
	 */
	public class AllTests extends TestSuite
	{
		/** Runs all unit tests. */
		public function AllTests()
		{
			super();
			
			addTest(new WordSlotHandlerEventTest("testDataRetention"));
			addTest(new WordSlotHandlerEventTest("testClone"));
			addTest(new WordSlotHandlerEventTest("testToString"));
		}
	}
}