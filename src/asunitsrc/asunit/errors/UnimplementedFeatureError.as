package asunitsrc.asunit.errors {

    public class UnimplementedFeatureError extends Error {

        public function UnimplementedFeatureError(message:String) {
            super(message);
            name = "UnimplementedFeatureError";
        }
    }
}