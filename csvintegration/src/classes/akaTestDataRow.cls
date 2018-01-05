/**
 * Created by akaCRM George Mandala on 1/4/2018.
 */

public class akaTestDataRow extends akaDataRow {

	public akaTestDataRow(List<String> headerFields, String rowText, String fileName, Integer rowNumber) {
		super(headerFields, rowText, fileName, rowNumber);
	}

	public override Decimal parseDecimal(String valueToParse) {
		return Decimal.valueOf(valueToParse);
	}

	public override Datetime parseDatetime(String valueToParse) {
		return Datetime.valueOf(valueToParse);
	}
	public override Date parseDate(String valueToParse) {
		return Date.valueOf(valueToParse);
	}

}