package tests {
	import asunitsrc.asunit.textui.TestRunner;
	import flash.display.Stage;
	
	public class MyTestRunner extends TestRunner {
		public function MyTestRunner(stage:Stage) {
			super();
			stage.addChild(this)
			start(AllTests);
		}
	}
}