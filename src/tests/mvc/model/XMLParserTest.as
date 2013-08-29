package tests.mvc.model {
	import asunitsrc.asunit.framework.TestCase;
	import com.mvc.model.XMLParser;
	
	/** @author Kristian Welsh */
	public class XMLParserTest extends TestCase {
		private var _instanceUnderTest:XMLParser;
		
		public function XMLParserTest(testMethod:String):void {
			super(testMethod);
		}
		
		protected override function setUp():void {
			_instanceUnderTest = new XMLParser();
		}
		
		public function tag_contents_as_array_should_return_empty_array_if_no_tag_available():void {
			_instanceUnderTest.xmlContent =
				<CONTENT>
				
				</CONTENT>;
			assertEqualsArrays([], _instanceUnderTest.tagContentsAsArray("TEST"));
		}
		
		public function tag_contents_as_array_should_return_empty_array_if_only_empty_tag_available():void {
			_instanceUnderTest.xmlContent =
				<CONTENT>
					<TEST></TEST>
				</CONTENT>;
			assertEqualsArrays([], _instanceUnderTest.tagContentsAsArray("TEST"));
		}
		
		public function tag_contents_as_array_should_return_string_in_array_if_valid_tag_and_data_found():void {
			_instanceUnderTest.xmlContent =
				<CONTENT>
					<TEST>result1</TEST>
				</CONTENT>;
			assertEqualsArrays(["result1"], _instanceUnderTest.tagContentsAsArray("TEST"));
		}
		
		public function tag_contents_as_array_should_return_all_strings_in_array_if_valid_tag_and_data_found():void {
			_instanceUnderTest.xmlContent =
				<CONTENT>
					<TEST>result1</TEST>
					<TEST>result2</TEST>
				</CONTENT>;
			assertEqualsArrays(["result1", "result2"], _instanceUnderTest.tagContentsAsArray("TEST"));
		}
		
		public function tag_contents_as_array_should_return_empty_array_if_valid_tag_contains_xml():void {
			_instanceUnderTest.xmlContent =
				<CONTENT>
					<TEST><RESULT>result</RESULT></TEST>
				</CONTENT>;
			assertEqualsArrays([], _instanceUnderTest.tagContentsAsArray("TEST"));
		}
	}
}