package beans;

public class Request {
	private int type; // 1 -> richiesta news, 2 -> richiesta aggiornamento news, 3 -> aggiungi notizia, 4 -> elimina ultima notizia
	private String giornalista;
	private String notizia;
	
	public Request() {
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getGiornalista() {
		return giornalista;
	}

	public void setGiornalista(String giornalista) {
		this.giornalista = giornalista;
	}

	public String getNotizia() {
		return notizia;
	}

	public void setNotizia(String notizia) {
		this.notizia = notizia;
	}
	
}