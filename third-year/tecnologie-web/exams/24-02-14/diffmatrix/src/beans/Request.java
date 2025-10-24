package beans;

public class Request {
	private int rowIndex;
	private int[] row1;
	private int[] row2;
	
	public Request() {
		
	}

	public int getRowIndex() {
		return rowIndex;
	}

	public void setRowIndex(int rowIndex) {
		this.rowIndex = rowIndex;
	}

	public int[] getRow1() {
		return row1;
	}

	public void setRow1(int[] row1) {
		this.row1 = row1;
	}

	public int[] getRow2() {
		return row2;
	}

	public void setRow2(int[] row2) {
		this.row2 = row2;
	}
	
}