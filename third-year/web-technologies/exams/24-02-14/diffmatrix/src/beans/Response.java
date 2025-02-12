package beans;

public class Response {
	private int rowIndex;
	private int[] row;
	private long millis;
	
	public Response() {
		
	}

	public int getRowIndex() {
		return rowIndex;
	}

	public void setRowIndex(int rowIndex) {
		this.rowIndex = rowIndex;
	}

	public int[] getRow() {
		return row;
	}

	public void setRow(int[] row) {
		this.row = row;
	}

	public long getMillis() {
		return millis;
	}

	public void setMillis(long millis) {
		this.millis = millis;
	}
	
}