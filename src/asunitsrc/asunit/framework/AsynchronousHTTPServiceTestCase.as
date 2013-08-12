package asunitsrc.asunit.framework {
		import flash.events.*;
		import flash.events.IOErrorEvent;
		import mx.rpc.AsyncToken;
		import mx.rpc.events.FaultEvent;
		import mx.rpc.Responder;

    /**
     * Extend this class if you have a TestCase that requires the
     * asynchronous load of external data.
     */
    public class AsynchronousHTTPServiceTestCase extends TestCase implements Test {

        public function AsynchronousHTTPServiceTestCase(testMethod:String = null) {
            super(testMethod);
        }

        // use this method in overriding run() if you are using an HTTPService:
        protected function configureResponder(token:AsyncToken):void {
            token.addResponder(new Responder(resultFunc, faultFunc));
        }

        protected function resultFunc(event:Object):void {
           // completeHandler(event as Event);
        }

        protected function faultFunc(event:Object):void {
            var faultEvent:FaultEvent = event as FaultEvent;
            if (faultEvent == null) {
                return;
            }
            var cause:Object = faultEvent.fault.rootCause;
            var ioErrorEvent:IOErrorEvent = cause as IOErrorEvent;
            if (ioErrorEvent) {
               // ioErrorHandler(ioErrorEvent);
                return;
            }
            var securityErrorEvent:SecurityErrorEvent = cause as SecurityErrorEvent;
            if (securityErrorEvent) {
                //securityErrorHandler(securityErrorEvent);
            }
        }

    }

}
