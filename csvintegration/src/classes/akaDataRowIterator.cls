/**
 * Created by George Mandala on 1/5/2018.
 */

public virtual class akaDataRowIterator {

	protected String fileData;
	protected List<string> headerRow;
	public enum TEXT_FORMAT {
		csv, tab
	}
	protected TEXT_FORMAT textFormat;
	protected string fileName { get; set; }
	protected Integer rowNumber { get; set; }


	public akaDataRowIterator(string fileData, TEXT_FORMAT textFormat, String fileName) {
		this.textFormat = textFormat;
		this.fileName = fileName;
		this.rowNumber = 0;


		if (fileData != null && String.isNotBlank(fileData)) {
			if (textFormat == TEXT_FORMAT.CSV) {
				String rowContents = fileData.substringBefore('\n');
				System.debug('raw row contents=' + rowContents);
				this.headerRow = akaCSVParser.getCSVCols(rowContents);
			}

			else {
				this.headerRow = akaCSVParser.getTSVCols(fileData.substringBefore('\n'));
			}

			this.fileData = fileData.substringAfter('\n');

			System.debug('Created akaDataRow instance');
		}

	}

	public boolean hasNext() {
		return String.isNotBlank(this.fileData);

	}

}