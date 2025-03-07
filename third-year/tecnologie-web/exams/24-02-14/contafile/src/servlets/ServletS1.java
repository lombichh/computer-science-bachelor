package servlets;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import beans.Request;
import beans.User;

// 1 istanza condivisa da tutte le richieste (thread), variabili di istanza per lo stato di applicazione
public class ServletS1 extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private Gson gson;

	@Override
	public void init() throws ServletException {
		// richiamato 1 sola volta, no concorrenza
		gson = new Gson();
		
		// inizializza struttura conteggi utenti
		Map<String, Integer> numConteggi = new HashMap<>();
		
		Map<String, User> users = (Map<String, User>) this.getServletContext().getAttribute("users");
		for (String userName : users.keySet()) {
			numConteggi.put(userName, 0);
		}
		
		this.getServletContext().setAttribute("numConteggi", numConteggi);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		Map<String, Integer> numConteggi = (Map<String, Integer>) this.getServletContext().getAttribute("numConteggi");
		User currentUser = (User) req.getSession().getAttribute("currentUser");
		
		if (numConteggi.get(currentUser.getUsername()) < 100) {
			// numConteggi < 100 -> effettua conteggio
			
			numConteggi.put(currentUser.getUsername(), numConteggi.get(currentUser.getUsername()) + 1);
			
			// lettura parametro tipoconteggio
			String body = "";
			String line;
	        BufferedReader reader = req.getReader();
	        while ((line = reader.readLine()) != null) {
	        	body += line;
	        }
	        Request request = gson.fromJson(body, Request.class);
	        
			String tipoconteggio = request.getTipoconteggio();
			String nomefile = request.getNomefile();
			
			req.setAttribute("nomefile", nomefile);
			if (tipoconteggio.equals("Caratteri alfabetici")) {
				// car alfa -> J1.jsp
				RequestDispatcher dispatcher =
						getServletContext().getRequestDispatcher("J1.jsp");
				dispatcher.forward(req, resp);
			} else if (tipoconteggio.equals("Caratteri numerici")) {
				// car num -> Jn.jsp
				RequestDispatcher dispatcher =
						getServletContext().getRequestDispatcher("Jn.jsp");
				dispatcher.forward(req, resp);
			}
		}
	}
	
}