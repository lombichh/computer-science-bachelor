package servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import beans.MaxminResponse;

// 1 istanza condivisa da tutte le richieste (thread), variabili di istanza per lo stato di applicazione
public class MaxminServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private Gson gson;

	@Override
	public void init() throws ServletException {
		// richiamato 1 sola volta, no concorrenza
		gson = new Gson();
		
        getServletContext().setAttribute("numTotProcessati", 0);
		LocalDate today = LocalDate.now();
        getServletContext().setAttribute("giornoAttuale", today.getDayOfMonth()+"/"+today.getMonthValue()+"/"+today.getYear());
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String getProcessati = (String) req.getAttribute("getProcessati");
		
		if (getProcessati != null) {
			// -> numTotProcessati
			LocalDate today = LocalDate.now();
			PrintWriter out = resp.getWriter();
			if (getServletContext().getAttribute("giornoAttuale").equals(today.getDayOfMonth()+"/"+today.getMonthValue()+"/"+today.getYear())) {
				// giorno corretto -> restituisci conteggio
				out.println("Numero reali processati oggi: " + getServletContext().getAttribute("numTotProcessati")); // scrive nel body della risposta
			} else {
				// giorno sbagliato -> azzera conteggio e giorno
				getServletContext().setAttribute("numTotProcessati", 0);
				getServletContext().setAttribute("giornoAttuale", today.getDayOfMonth()+"/"+today.getMonthValue()+"/"+today.getYear());
				out.println("Numero reali processati oggi: 0");
			}
		} else {
			// matr -> max e min
			
			// lettura del body della richiesta
			String body = "";
			String line;
	        BufferedReader reader = req.getReader();
	        while ((line = reader.readLine()) != null) {
	        	body += line;
	        }

			int[][] matr = gson.fromJson(body, int[][].class);
			
			MaxminResponse response = new MaxminResponse();
			response.setMax(matr[0][0]);
			response.setMin(matr[0][0]);
			for (int row = 0; row < matr.length; row++) {
				for (int col = 0; col < matr[0].length; col++) {
					if (matr[row][col] > response.getMax()) response.setMax(matr[row][col]);
					if (matr[row][col] < response.getMin()) response.setMin(matr[row][col]);
				}
			}
			
			// aggiorna num tot processati
			LocalDate today = LocalDate.now();
			if (getServletContext().getAttribute("giornoAttuale").equals(today.getDayOfMonth()+"/"+today.getMonthValue()+"/"+today.getYear())) {
				// giorno corretto -> aggiungi processati
				getServletContext().setAttribute("numTotProcessati", ((int)getServletContext().getAttribute("numTotProcessati")) + matr.length*matr[0].length);
			} else {
				// giorno sbagliato -> azzera e aggiungi
				getServletContext().setAttribute("numTotProcessati", matr.length*matr[0].length);
			}
			
			PrintWriter out = resp.getWriter();
			out.println(gson.toJson(response)); // scrive nel body della risposta
		}
	}
	
}