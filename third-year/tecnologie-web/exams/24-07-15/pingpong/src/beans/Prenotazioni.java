package beans;

import java.util.ArrayList;
import java.util.List;

public class Prenotazioni {
	private List<Prenotazione> prenotazioni1 = new ArrayList<>();
	private List<Prenotazione> prenotazioni2 = new ArrayList<>();
	
	public Prenotazioni() {
		
	}

	public List<Prenotazione> getPrenotazioni1() {
		return prenotazioni1;
	}

	public void setPrenotazioni1(List<Prenotazione> prenotazioni1) {
		this.prenotazioni1 = prenotazioni1;
	}

	public List<Prenotazione> getPrenotazioni2() {
		return prenotazioni2;
	}

	public void setPrenotazioni2(List<Prenotazione> prenotazioni2) {
		this.prenotazioni2 = prenotazioni2;
	}
}