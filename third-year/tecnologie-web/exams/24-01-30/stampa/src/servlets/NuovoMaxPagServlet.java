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
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

// 1 istanza condivisa da tutte le richieste (thread), variabili di istanza per lo stato di applicazione
public class NuovoMaxPagServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.getServletContext().setAttribute("nuovoMaxPagProfessori", req.getParameter("nuovoMaxPagProfessori"));
		this.getServletContext().setAttribute("nuovoMaxPagDottorandi", req.getParameter("nuovoMaxPagDottorandi"));
		
		PrintWriter out = resp.getWriter();
		out.println("Numero di pagine massimo aggiornato");
	}
	
}