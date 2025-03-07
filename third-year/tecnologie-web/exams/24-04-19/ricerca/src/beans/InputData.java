package beans;

public class InputData {
	private int sessionId;
	private int num; // [1, 3]
	private Person[] personsList;
	
	public InputData() {
	}

	public int getSessionId() {
		return sessionId;
	}

	public void setSessionId(int sessionId) {
		this.sessionId = sessionId;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public Person[] getPersonsList() {
		return personsList;
	}

	public void setPersonsList(Person[] personsList) {
		this.personsList = personsList;
	}
}