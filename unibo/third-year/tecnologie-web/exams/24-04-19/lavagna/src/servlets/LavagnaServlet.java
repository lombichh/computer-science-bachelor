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

import beans.User;

// 1 istanza condivisa da tutte le richieste (thread), variabili di istanza per lo stato di applicazione
public class LavagnaServlet extends HttpServlet {
	
private static final long serialVersionUID = 1L;
	
	private Gson gson;

	@Override
	public void init() throws ServletException {
		// richiamato 1 sola volta, no concorrenza
		gson = new Gson();
		
		// lavagne
		String lavagna1 = "";
		String lavagna2 = "";
		
		this.getServletContext().setAttribute("lavagna1", lavagna1);
		this.getServletContext().setAttribute("lavagna2", lavagna2);
		
		// user: lavagna
		Map<String, Integer> usersLavagna = new HashMap<>();
		this.getServletContext().setAttribute("usersLavagna", usersLavagna);
		
		// lavagne libere
		boolean lavagna1Libera = true;
		boolean lavagna2Libera = true;

		this.getServletContext().setAttribute("lavagna1Libera", lavagna1Libera);
		this.getServletContext().setAttribute("lavagna2Libera", lavagna2Libera);
	}
	
	private void assegnaLavagna(User currentUser, Map<String, Integer> usersLavagna) {
		// assegna una lavagna all'utente
		if (usersLavagna.size() + 1 < 50) usersLavagna.put(currentUser.getUsername(), 1);
		else if (usersLavagna.size() + 1 == 50) {
			usersLavagna.put(currentUser.getUsername(), 1);
			 
			// sposta 25 users nella seconda lavagna
			int numUsersSpostati = 0;
			for (String username : usersLavagna.keySet()) {
				if (numUsersSpostati < 25) {
					usersLavagna.put(username, 2);
				} else break;
				numUsersSpostati++;
			}
	
			// aggiorna lavagna 2
			String lavagna1 = (String) this.getServletContext().getAttribute("lavagna1");
			String lavagna2 = lavagna1;
			this.getServletContext().setAttribute("lavagna2", lavagna2);
		} else usersLavagna.put(currentUser.getUsername(), 2);
	
		this.getServletContext().setAttribute("usersLavagna", usersLavagna);
	}

	@Override
	protected synchronized void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// check assegna lavagna
		User currentUser = (User) this.getServletContext().getAttribute("currentUser");
		Map<String, Integer> usersLavagna = (Map<String, Integer>) this.getServletContext().getAttribute("usersLavagna");
		
		if (!usersLavagna.containsKey(currentUser.getUsername())) assegnaLavagna(currentUser, usersLavagna);
		
		// restituisci lavagna
		PrintWriter out = resp.getWriter();
		if (usersLavagna.get(currentUser.getUsername()) == 1) {
			String lavagna1 = (String) this.getServletContext().getAttribute("lavagna1");
			out.print(lavagna1);
		} else {
			String lavagna2 = (String) this.getServletContext().getAttribute("lavagna2");
			out.print(lavagna2);
		}
	}

	@Override
	protected synchronized void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		User currentUser = (User) this.getServletContext().getAttribute("currentUser");
		Map<String, Integer> usersLavagna = (Map<String, Integer>) this.getServletContext().getAttribute("usersLavagna");
        
        String lavagna = req.getParameter("lavagna");
        if (lavagna == null) {
        	// rihiesta scrittura
        	
        	// check assegna lavagna
        	if (!usersLavagna.containsKey(currentUser.getUsername())) assegnaLavagna(currentUser, usersLavagna);
        	
        	// check lavagna libera
        	if (usersLavagna.get(currentUser.getUsername()) == 1) {
        		boolean lavagna1Libera = (boolean) this.getServletContext().getAttribute("lavagna1Libera");
        		if (lavagna1Libera) {
        			lavagna1Libera = false;
        			this.getServletContext().setAttribute("lavagna1Libera", lavagna1Libera);
        			resp.sendRedirect("scrittore.jsp");
        		} else {
        			PrintWriter out = resp.getWriter();
        			out.println("Un altro utente stà già scrivendo nella lavagna");
        		}
        	} else {
        		boolean lavagna2Libera = (boolean) this.getServletContext().getAttribute("lavagna2Libera");
        		if (lavagna2Libera) {
        			lavagna2Libera = false;
        			this.getServletContext().setAttribute("lavagna2Libera", lavagna2Libera);
        			resp.sendRedirect("scrittore.jsp");
        		} else {
        			PrintWriter out = resp.getWriter();
        			out.println("Un altro utente stà già scrivendo nella lavagna");
        		}
        	}
        } else {
        	// scrittura
        	if (usersLavagna.get(currentUser.getUsername()) == 1) {
        		this.getServletContext().setAttribute("lavagna1", lavagna);
    			this.getServletContext().setAttribute("lavagna1Libera", true);
        	} else {
        		this.getServletContext().setAttribute("lavagna2", lavagna);
    			this.getServletContext().setAttribute("lavagna2Libera", true);
        	}
        	
        	resp.sendRedirect("home.html");
        }
	}
	
}