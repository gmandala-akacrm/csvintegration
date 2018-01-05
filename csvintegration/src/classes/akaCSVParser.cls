/**
 * Created by akaCRM George Mandala on 1/4/2018.
 */

public without sharing class akaCSVParser {

	public static String ESCAPE_MODE_DOUBLED = 'doubled';
	public static String ESCAPE_MODE_BACKSLASH = 'backslash';

	public String textQualifier { get; set; }
	public String delimiter { get; set; }
	public String escapeMode { get; set; }

	public akaCSVParser() {
		textQualifier = '"';
		delimiter = ',';
		escapeMode = ESCAPE_MODE_DOUBLED;
	}


	public List<List<String>> parse(String contents) {

		List<List<String>> allFields = new List<List<String>>();

		List<String> lines = contents.split('[\n\r]+');

		for (String line : lines) {


			List<String> lineFields = getCSVCols(line);

			if (!lineFields.isEmpty()) {
				allFields.add(lineFields);
			}

		}

		return allFields;
	}


	public static List<string> getTSVCols(string line) {
		List<string> ret_vals = new List<string>();

		for (String s : safeSplit(line.trim(), '\t'))
			ret_vals.add(s.unescapeCsv());

		return ret_vals;


	}


	public static List<String> getCSVCols(string line) {
		string delimiter = ',';
		string textQualifier = '"';
		string escapeMode = ESCAPE_MODE_DOUBLED;
		line = line.trim();

		Integer length = line.length();

		Integer i;
		Boolean isQualifying = false;
		Boolean isEscaping = false;
		String currentField = '';
		Boolean isBeginningOfField = false;

		List<String> lineFields = new List<String>();

		for (i = 0; i < length; i++) {
			String achar = line.substring(i, i + 1);

			if (achar.equals(delimiter)) {
				// the delimiter
				if (isQualifying) {
					currentField = currentField + delimiter;
					isBeginningOfField = false;
				}
				else {
					lineFields.add(currentField);
					currentField = '';
					isQualifying = false;
					isEscaping = false;
					isBeginningOfField = true;
				}

			}
			else if (escapeMode.equals(ESCAPE_MODE_BACKSLASH) && achar.equals('\\')) {
				// the escape char
				if (isEscaping) {
					isEscaping = false;
					currentField = currentField + '\\';
				}
				else {
					isEscaping = true;
				}

			}
			else if (achar.equals(textQualifier)) {
				// the qualifier
				if (isEscaping) {
					isEscaping = false;
					currentField = currentField + textQualifier;
				}
				else {
					String nextchar = 'NEVEREQUAL';
					if (i < length - 1) {
						nextchar = line.substring(i + 1, i + 2);
					}
					if (escapeMode.equals(ESCAPE_MODE_DOUBLED) && nextchar.equals(textQualifier) && (!isBeginningOfField)) {
						isEscaping = true;

					}
					else {
						if (isQualifying) {
							isQualifying = false;
						}
						else {
							isQualifying = true;
						}

					}
				}

			}
			else {
				// general char
				currentField = currentField + achar;

			}

			if (!achar.equals(delimiter)) {
				isBeginningOfField = false;
			}

		}

		if (currentField.length() > 0) {
			// the last field
			lineFields.add(currentField);
		}

		return lineFields;

	}

	public static List<String> safeSplit(String inStr, String delim) {
		Integer regexFindLimit = 50;
		Integer regexFindCount = 0;

		List<String> output = new List<String>();

		Matcher m = Pattern.compile(delim).matcher(inStr);

		Integer lastEnd = 0;

		while (!m.hitEnd()) {
			while (regexFindCount < regexFindLimit && !m.hitEnd()) {
				if (m.find()) {
					output.add(inStr.substring(lastEnd, m.start()));
					lastEnd = m.end();
				}
				else {
					output.add(inStr.substring(lastEnd));
					lastEnd = inStr.length();
				}

				regexFindCount++;
			}

			// Note: Using region() to advance instead of substring() saves
			// drastically on heap size. Nonetheless, we still must reset the
			// (unmodified) input sequence to avoid a 'Regex too complicated'
			// error.
			m.reset(inStr);
			m.region(lastEnd, m.regionEnd());

			regexFindCount = 0;
		}

		return output;
	}


}