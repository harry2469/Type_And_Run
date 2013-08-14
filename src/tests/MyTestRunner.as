package tests
{
	import asunitsrc.asunit.textui.TestRunner;
	import flash.display.Stage;
	
	/**
	 * Runs the unit tests
	 * @author Kristian Welsh
	 */
	public class MyTestRunner extends TestRunner
	{
		public function MyTestRunner(stage:Stage)
		{
			super();
			stage.addChild(this)
			start(AllTests, null, false);
		}
	}
}