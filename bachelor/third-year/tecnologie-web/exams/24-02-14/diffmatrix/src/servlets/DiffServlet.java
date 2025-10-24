package servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.temporal.ChronoField;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import beans.Request;
import beans.Response;

// 1 istanza condivisa da tutte le richieste (thread), variabili di istanza per lo stato di applicazione
public class DiffServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private Gson gson;

	@Override
	public void init() throws ServletException {
		// richiamato 1 sola volta, no concorrenza
		gson = new Gson();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		LocalDate now = LocalDate.now();
		long startMillis = now.getLong(ChronoField.MILLI_OF_DAY);
		
		// lettura del body della richiesta
		String body = "";
		String line;
        BufferedReader reader = req.getReader();
        while ((line = reader.readLine()) != null) {
        	body += line;
        }
        
        Request request = gson.fromJson(body, Request.class);

        int[] row = new int[4];
        
        for (int i = 0; i < 4; i++) {
        	row[i] = request.getRow1()[i] - request.getRow2()[i];
        }
        
        Response response = new Response();
        response.setRowIndex(request.getRowIndex());
        response.setRow(row);

		long endMillis = now.getLong(ChronoField.MILLI_OF_DAY);
		long diffMillis = now.getLong(ChronoField.MILLI_OF_DAY);
		
		response.setMillis(diffMillis);
		
		PrintWriter out = resp.getWriter();
		out.println(gson.toJson(response)); // scrive nel body della risposta
	}
	
}