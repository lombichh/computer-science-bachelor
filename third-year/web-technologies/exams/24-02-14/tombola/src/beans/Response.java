package beans;

public class Response {
	private int type; // 1 -> richiesta partecipazione, 2 -> numero tombola, 3 -> messaggio admin
	private String value;
	
	public Response() {
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}