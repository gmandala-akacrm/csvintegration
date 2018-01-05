/**
 * Created by George Mandala on 1/5/2018.
 */

@IsTest
private class akaTestDataRowIteratorTest {

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

	static String csvHeaderText {
		get {
			return String.join(header, ',');
		}
	}

	static String tsvHeaderText {
		get {
			return String.join(header, '\t');
		}
	}

	static String csvFileData {
		get {
			return String.join(new List<String>{
					csvHeaderText, csvRowText
			}, '\n');
		}
	}


	static String tsvFileData {
		get {
			return String.join(new List<String>{
					tsvHeaderText, tsvRowText
			}, '\n');
		}
	}


	@IsTest
	static void testCSVIteratorTest() {
		Iterator<akaTestDataRow> iterator = new akaTestDataRowIterator(csvFileData, akaDataRowIterator.TEXT_FORMAT.csv, 'test.csv').Iterator();
		while (iterator.hasNext()) {
			akaTestDataRow testDataRow = iterator.next();
		}

	}


	@IsTest
	static void testTSVIteratorTest() {
		Iterator<akaTestDataRow> iterator = new akaTestDataRowIterator(tsvFileData, akaDataRowIterator.TEXT_FORMAT.tab, 'test.txt').Iterator();
		while (iterator.hasNext()) {
			akaTestDataRow testDataRow = iterator.next();
		}

	}
}