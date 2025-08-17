package beans;

public class OperationResp {
	private boolean valid;
	private double result;
	
	public OperationResp() {
		this.valid = false;
		this.result = -1;
	}

	public boolean isValid() {
		return valid;
	}

	public void setValid(boolean valid) {
		this.valid = valid;
	}

	public double getResult() {
		return result;
	}

	public void setResult(double result) {
		this.result = result;
	}
}