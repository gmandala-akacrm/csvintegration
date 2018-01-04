/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 *
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class akaCSVParserTest {


	static testMethod void myUnitTest() {
		akaCSVParser parser = new akaCSVParser();
		String content;
		List<List<String>> result;

		parser.escapeMode = akaCSVParser.ESCAPE_MODE_DOUBLED;
		content = 'a,b\n'
				+ '"a","b"\n'
				+ 'a,"b,c"\r'
				+ '"a","b,c"\n'
				+ 'a,"b,""c"\r\n'
				+ 'a,"""b",c\n\n\n'
				+ 'a,"""""""""b",c\r'
				+ 'a,"b""""""""",c';
		result = parser.parse(content);
		/*
		System.assertEquals(result[0][0], 'a');
		System.assertEquals(result[0][1], 'b');
		System.assertEquals(result[1][0], 'a');
		System.assertEquals(result[1][1], 'b');
		System.assertEquals(result[2][0], 'a');
		System.assertEquals(result[2][1], 'b,c');
		System.assertEquals(result[3][0], 'a');
		System.assertEquals(result[3][1], 'b,c');
		System.assertEquals(result[4][0], 'a');
		System.assertEquals(result[4][1], 'b,"c');
		System.assertEquals(result[5][0], 'a');
		System.assertEquals(result[5][1], '"b');
		System.assertEquals(result[5][2], 'c');
		System.assertEquals(result[6][0], 'a');
		System.assertEquals(result[6][1], '""""b');
		System.assertEquals(result[6][2], 'c');
		System.assertEquals(result[7][0], 'a');
		System.assertEquals(result[7][1], 'b""""');
		System.assertEquals(result[7][2], 'c');
		*/
		parser.escapeMode = akaCSVParser.ESCAPE_MODE_BACKSLASH;
		content = 'a,"b,\\"c"\n'
				+ 'a,"\\"\\"\\"\\"b",c\n\r'
				+ 'a,"b\\"\\"\\"\\"",c';
		result = parser.parse(content);
		/*
		System.assertEquals(result[0][0], 'a');
		System.assertEquals(result[0][1], 'b,"c');
		System.assertEquals(result[1][0], 'a');
		System.assertEquals(result[1][1], '""""b');
		System.assertEquals(result[1][2], 'c');
		System.assertEquals(result[2][0], 'a');
		System.assertEquals(result[2][1], 'b""""');
		System.assertEquals(result[2][2], 'c');*/
	}


	static testMethod void CVSParserTSVCols_Test() {
		string [] testString = new List<String>{
				'this', 'is', 'my', 'first', 'test'
		};

		string [] retVals = akaCSVParser.getTSVCols(String.join(testString, '\t'));

		System.assert(testString.size() == retVals.size());
	}
}