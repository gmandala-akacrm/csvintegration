/**
 * Created by akaCRM George Mandala on 1/4/2018.
 * This class has the base methods for creating a data row.  The full implementation of the data row class
 * requires that implementation of parseDate,parseDateTime, and parseDecimal
 */

public abstract class akaDataRow {

	protected List<string> headerFields;
	protected List<string> dataRow;
	protected Map<string, Object> valMap;

	protected string rowText { get; set; }
	protected string fileName { get; set; }
	protected integer rowNumber { get; set; }

	public akaDataRow(List<String> headerFields, String rowText, String fileName, Integer rowNumber) {
		this.headerFields = headerFields;
		this.rowText = rowText;
		this.fileName = fileName;
		this.rowNumber = rowNumber;

	}

	public virtual void populateCsvFields() {
		dataRow = akaCSVParser.getCSVCols(rowText);
		populateDataFields();
	}

	public virtual void populateTsvFields() {
		dataRow = akaCSVParser.getTSVCols(rowText);
		populateDataFields();
	}


	protected virtual void populateDataFields() {
		valMap = new Map<string, Object>();


		//if(this.header.size()==this.dataRow.size())
		for (Integer i = 0; i < headerFields.size(); i++) {

			string headerVal;
			string dataVal;


			headerVal = formatHeader(headerFields[i]);


			try {

				dataVal = String.IsNotBlank(this.dataRow[i]) &&
						this.dataRow[i].startsWith('\"') &&
						this.dataRow[i].endsWith('\"') ? this.dataRow[i].removeEnd('\"').removeStart('\"') : this.dataRow[i] ;

				dataVal = dataVal != null ? dataVal.trim() : dataVal;
				//dataVal = dataRow[i];
			} catch (Exception e) {
				dataVal = null;
			}

			if (String.isNotBlank(headerVal) && String.isNotBlank(dataVal))
				valMap.put(headerVal, dataVal);


		}

	}


	public virtual String formatHeader(String s) {
		return s != null ? s.replaceAll('[^\\w]', '').toLowerCase().trim() : null;
	}

	public virtual Boolean isValid() {
		return String.isNotBlank(rowText);

	}

	public String getStringVal(string fieldName) {

		String retVal = String.valueOf(valMap.get(formatHeader(fieldName)));
		return this.parseString(retVal);

	}

	public Decimal getDecimalVal(string fieldName) {

		try {
			String sVal = String.valueOf(valMap.get(formatHeader(fieldName)));
			return this.parseDecimal(sVal);

		} catch (Exception e) {
			return null;
		}

	}

	public Date getDateVal(string fieldName) {
		try {
			String s1 = String.valueOf(valMap.get(formatHeader(fieldName)));
			return this.parseDate(s1);

		} catch (Exception e) {
			return null;
		}
	}


	public Datetime getDateTimeVal(string fieldName) {
		try {
			String s1 = String.valueOf(valMap.get(formatHeader(fieldName)));
			return this.parseDateTime(s1);

		} catch (Exception e) {
			return null;
		}
	}


	public virtual String parseString(String valueToParse) {
		return valueToParse != null ? valueToParse.trim() : valueToParse;
	}


	/**
	 * Reimplement these 3 methods as necessary to convert text into different data types
	 *
	 */

	public abstract Decimal parseDecimal(String valueToParse);

	public abstract Date parseDate(String valueToParse);

	public abstract DateTime parseDateTime(String valueToParse);


}