/**
 * Created by akaCRM George Mandala on 1/4/2018.
 */

@IsTest
private class akaTestDataRowTest {

	static final String DATE_STRING = '2017-01-15';
	static String DATE_TIME_STRING {
		get {
			string year = '2017';
			string month = '10';
			string day = '5';
			string hour = '12';
			string minute = '20';
			string second = '20';
			return year + '-' + month + '-' + day + ' ' + hour + ':'
					+ minute + ':' + second;
		}
	}
	static final String DECIMAL_STRING = '123';
	static final String STRING_STRING = 'a';

	static final String STRING_FIELD = '1';
	static final String DATE_FIELD = '2';
	static final String DATE_TIME_FIELD = '3';
	static final String DECIMAL_FIELD = '4';


	static List<String> header {
		get {
			return new List<String>{
					STRING_FIELD, DATE_FIELD, DATE_TIME_FIELD, DECIMAL_FIELD
			};
		}
	}


	static List<String> rowVals {
		get {
			return new List<String>{
					STRING_STRING,
					DATE_STRING,
					DATE_TIME_STRING,
					DECIMAL_STRING
			};
		}
	}

	static String csvRowText {
		get {
			return String.join(rowVals, ',');
		}
	}

	static String tsvRowText {
		get {
			return String.join(rowVals, '\t');
		}
	}

	@IsTest
	static void testCsvDataRow() {
		akaTestDataRow testRow = new akaTestDataRow(header, csvRowText, 'abc.txt', 1);
		Date testDate = testRow.parseDate(DATE_STRING);
		Datetime testDatetime = testRow.parseDatetime(DATE_TIME_STRING);
		Decimal testDecimal = testRow.parseDecimal(DECIMAL_STRING);
		testRow.populateCsvFields();

		System.assertEquals(testDatetime, testRow.getDateTimeVal(DATE_TIME_FIELD));
		System.assertEquals(null, testRow.getDateTimeVal(DECIMAL_FIELD));

		System.assertEquals(testDate, testRow.getDateVal(DATE_FIELD));
		System.assertEquals(null, testRow.getDateVal(DECIMAL_FIELD));

		System.assertEquals(testDecimal, testRow.getDecimalVal(DECIMAL_FIELD));
		System.assertEquals(null, testRow.getDecimalVal(DATE_TIME_FIELD));

		System.assertEquals(STRING_STRING, testRow.getStringVal(STRING_FIELD));
		System.assertEquals(true, testRow.isValid());
		List<akaTestDataRow> rowsToTest = new List<akaTestDataRow>{
				testRow
		};

		System.assertEquals('1,2,3,4', testRow.getCsvHeaderString());


	}


	@IsTest
	static void testTsvDataRow() {
		akaTestDataRow testRow = new akaTestDataRow(header, tsvRowText, 'abc.txt', 1);
		Date testDate = testRow.parseDate(DATE_STRING);
		Datetime testDatetime = testRow.parseDatetime(DATE_TIME_STRING);
		Decimal testDecimal = testRow.parseDecimal(DECIMAL_STRING);
		testRow.populateTsvFields();
		System.assertEquals(testDatetime, testRow.getDateTimeVal(DATE_TIME_FIELD));
		System.assertEquals(testDate, testRow.getDateVal(DATE_FIELD));
		System.assertEquals(testDecimal, testRow.getDecimalVal(DECIMAL_FIELD));
		System.assertEquals(STRING_STRING, testRow.getStringVal(STRING_FIELD));
		System.assertEquals('1\t2\t3\t4', testRow.getTsvHeaderString());


	}
}