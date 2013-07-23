package asunitsrc{
    import asunitsrc.asunit.errors.AssertionFailedError;
    import asunitsrc.asunit.errors.ClassNotFoundError;
    import asunitsrc.asunit.errors.InstanceNotFoundError;
    import asunitsrc.asunit.errors.UnimplementedFeatureError;
    import asunitsrc.asunit.framework.Assert;
    import asunitsrc.asunit.framework.AsynchronousTestCase;
    import asunitsrc.asunit.framework.AsynchronousTestCaseExample;
    import asunitsrc.asunit.framework.AsyncOperation;
    import asunitsrc.asunit.framework.RemotingTestCase;
    import asunitsrc.asunit.framework.Test;
    import asunitsrc.asunit.framework.TestCase;
    import asunitsrc.asunit.framework.TestCaseExample;
    import asunitsrc.asunit.framework.TestFailure;
    import asunitsrc.asunit.framework.TestListener;
    import asunitsrc.asunit.framework.TestMethod;
    import asunitsrc.asunit.framework.TestResult;
    import asunitsrc.asunit.framework.TestSuite;
    import asunitsrc.asunit.runner.BaseTestRunner;
    import asunitsrc.asunit.runner.TestSuiteLoader;
    import asunitsrc.asunit.runner.Version;
    import asunitsrc.asunit.textui.ResultPrinter;
    import asunitsrc.asunit.textui.TestRunner;
    import asunitsrc.asunit.textui.XMLResultPrinter;
    import asunitsrc.asunit.util.ArrayIterator;
    import asunitsrc.asunit.util.Iterator;
    import asunitsrc.asunit.util.Properties;

    public class AsUnit {
        private var assertionFailedError:AssertionFailedError;
        private var classNotFoundError:ClassNotFoundError;
        private var instanceNotFoundError:InstanceNotFoundError;
        private var unimplementedFeatureError:UnimplementedFeatureError;
        private var assert:Assert;
        private var asynchronousTestCase:AsynchronousTestCase;
        private var asynchronousTestCaseExample:AsynchronousTestCaseExample;
        private var asyncOperation:AsyncOperation;
        private var remotingTestCase:RemotingTestCase;
        private var test:Test;
        private var testCase:TestCase;
        private var testCaseExample:TestCaseExample;
        private var testFailure:TestFailure;
        private var testListener:TestListener;
        private var testMethod:TestMethod;
        private var testResult:TestResult;
        private var testSuite:TestSuite;
        private var baseTestRunner:BaseTestRunner;
        private var testSuiteLoader:TestSuiteLoader;
        private var version:Version;
        private var resultPrinter:ResultPrinter;
        private var testRunner:TestRunner;
        private var xMLResultPrinter:XMLResultPrinter;
        private var arrayIterator:ArrayIterator;
        private var iterator:Iterator;
        private var properties:Properties;
        private var asUnit:AsUnit;
    }
}