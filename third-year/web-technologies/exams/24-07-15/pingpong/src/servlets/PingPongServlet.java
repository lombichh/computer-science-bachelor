package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import beans.Prenotazione;
import beans.Prenotazioni;

// 1 istanza condivisa da tutte le richieste (thread), variabili di istanza per lo stato di applicazione
public class PingPongServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private Gson gson;

	@Override
	public void init() throws ServletException {
		// richiamato 1 sola volta, no concorrenza
		gson = new Gson();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		int ora = Integer.parseInt(req.getParameter("ora"));
		int minuti = Integer.parseInt(req.getParameter("minuti"));
		
		String addInfo = "";
		Prenotazioni prenotazioni = (Prenotazioni) getServletContext().getAttribute("prenotazioni");
		
		if (prenotazioni == null) {
			prenotazioni = new Prenotazioni();

			Prenotazione prenotazione = new Prenotazione();
			prenotazione.setOra(ora);
			prenotazione.setMinuti(minuti);
			prenotazione.setValid(false);
			
			List<Prenotazione> prenotazioni1 = new ArrayList<>();
			prenotazioni1.add(prenotazione);
			
			prenotazioni.setPrenotazioni1(prenotazioni1);
			getServletContext().setAttribute("prenotazioni", prenotazioni);
		} else {
			// cerca nelle prenotazioni del primo tavolo
			List<Prenotazione> prenotazioni1 = prenotazioni.getPrenotazioni1();
			
			boolean found = false;
			int i = 0;
			while (!found && i < prenotazioni1.size()) {
				Prenotazione prenotazione = prenotazioni1.get(i);
				if (prenotazione.getOra() == ora && minuti - prenotazione.getMinuti() < 30) {
					found = true;
					if (prenotazione.isValid() == false) {
						prenotazione.setValid(true);
						
						prenotazioni1.set(i, prenotazione);
						prenotazioni.setPrenotazioni1(prenotazioni1);
						getServletContext().setAttribute("prenotazioni", prenotazioni);
						
						addInfo = "Prenotato come secondo giocatore nel primo tavolo";
					} else addInfo = "C'è già una prenotazione in questo orario";
				}
				i++;
			}
			
			if (!found) {
				if (i < 5) {
					// prenotazione non c'è -> inserisci nel primo tavolo
					Prenotazione prenotazione = new Prenotazione();
					prenotazione.setOra(ora);
					prenotazione.setMinuti(minuti);
					prenotazione.setValid(false);
					
					prenotazioni1.add(prenotazione);
					prenotazioni.setPrenotazioni1(prenotazioni1);
					getServletContext().setAttribute("prenotazioni", prenotazioni);

					addInfo = "Prenotato come primo giocatore nel primo tavolo";
				} else {
					// primo tavolo pieno -> cerca nel secondo tavolo
					List<Prenotazione> prenotazioni2 = prenotazioni.getPrenotazioni2();
					
					i = 0;
					while (!found && i < prenotazioni2.size()) {
						Prenotazione prenotazione = prenotazioni2.get(i);
						if (prenotazione.getOra() == ora && minuti - prenotazione.getMinuti() < 30) {
							found = true;
							if (prenotazione.isValid() == false) {
								prenotazione.setValid(true);
								
								prenotazioni2.set(i, prenotazione);
								prenotazioni.setPrenotazioni2(prenotazioni2);
								getServletContext().setAttribute("prenotazioni", prenotazioni);
								
								addInfo = "Prenotato come secondo giocatore nel secondo tavolo";
							} else addInfo = "C'è già una prenotazione in questo orario";
						}
						i++;
					}
					
					if (!found) {
						// prenotazione non c'è -> inserisci nel secondo tavolo
						Prenotazione prenotazione = new Prenotazione();
						prenotazione.setOra(ora);
						prenotazione.setMinuti(minuti);
						prenotazione.setValid(false);
						
						prenotazioni2.add(prenotazione);
						prenotazioni.setPrenotazioni2(prenotazioni2);
						getServletContext().setAttribute("prenotazioni", prenotazioni);

						addInfo = "Prenotato come primo giocatore nel secondo tavolo";
					}
				}
			}

			RequestDispatcher dispatcher =
				getServletContext().getRequestDispatcher("add.jsp");
			dispatcher.forward(req, resp);
		}
	}
	
}