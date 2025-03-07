package beans;

public class Request {
	private int type; // 1 -> richiesta partecipazione, 2 -> segnalazione tombola, 3 -> ritiro, 4 -> messaggio admin
	
	public Request() {
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

}