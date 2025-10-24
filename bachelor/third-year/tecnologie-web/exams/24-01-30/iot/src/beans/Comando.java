package beans;

public class Comando {
	private String sessionId;
	private String comandoText;
	
	public Comando() {
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public String getComandoText() {
		return comandoText;
	}

	public void setComandoText(String comandoText) {
		this.comandoText = comandoText;
	}
	
}