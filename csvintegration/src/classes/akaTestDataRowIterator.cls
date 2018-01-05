/**
 * Created by George Mandala on 1/5/2018.
 */

public without sharing class akaTestDataRowIterator extends akaDataRowIterator implements Iterator<akaTestDataRow>, Iterable<akaTestDataRow> {

	public akaTestDataRowIterator(string fileData, TEXT_FORMAT textFormat, String fileName) {
		super(fileData, textFormat, fileName);
	}

	public akaTestDataRow next() {
		string rowText = this.fileData.substringBefore('\n');
		this.fileData = this.filedata.substringAfter('\n');

		rowNumber++;
		return new akaTestDataRow(this.headerRow, rowText, fileName, rowNumber);

	}

	public Iterator<akaTestDataRow> Iterator() {
		return this;
	}

}