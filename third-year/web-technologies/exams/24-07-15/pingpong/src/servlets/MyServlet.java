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

import beans.MyBean;

// 1 istanza condivisa da tutte le richieste (thread), variabili di istanza per lo stato di applicazione
public class MyServlet extends HttpServlet {
	
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
		// request
		// lettura del body della richiesta
		String body = "";
		String line;
        BufferedReader reader = req.getReader();
        while ((line = reader.readLine()) != null) {
        	body += line;
        }
		
		MyBean[] myBeansArray = gson.fromJson("JSONStr", MyBean[].class); // da JSON a bean array
		List<MyBean> myBeans = Arrays.asList(myBeansArray); // da array a lista
		
		req.getAttribute("attributeName"); // oggetto attributo di un forward o include
		req.getParameter("parameterName"); // stringa parametro di un form o della query string
        getServletContext().getAttribute("attributeName"); // oggetto attributo globale
		
        HttpSession session = req.getSession(true);
        session.getAttribute("attributeName"); // oggetto attributo di sessione
        
        req.getHeader("headerName"); // header impostato solitamente con AJAX
        
		for (Cookie cookie : req.getCookies()) {
			if (cookie.getName().equals("cookieName")) {
				// lavorare con un cookie salvato sul client precedentemente
				break;
			}
		}
		
		
		// lettura e scrittura su file
		File file = new File("file.txt");
		if (file.exists()) { // serve anche per verificare che una directory esista, in quel caso file.list() per resistuire un array di fileName contenuti in tale dir
			// lettura
			BufferedReader bufferedReader = new BufferedReader(new FileReader(file));
			String fileLine;
            while ((fileLine = bufferedReader.readLine()) != null) {
                // lavora con la linea del file
            }
            bufferedReader.close();
            
            // scrittura
            BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(file));
            bufferedWriter.write("line");
            bufferedWriter.close();
		}
		
		
		// response
		resp.setHeader("Content-Type", "type"); // specificare il tipo di contenuto del body della risposta
		
		gson.toJson(myBeans.toArray(new MyBean[0])); // da bean list a JSON
		
		Cookie cookie = new Cookie("cookieName", "value");
        resp.addCookie(cookie); // inviare un cookie al client

        getServletContext().setAttribute("attributeName", "value"); // oggetto attributo globale
        
        session.setAttribute("attributeName", "value"); // oggetto attributo di sessione
        
        req.setAttribute("attributeName", "value"); // oggetto attributo da inviare a un'altra servlet o jsp tramite forward o include
		RequestDispatcher dispatcher =
			getServletContext().getRequestDispatcher("servlet/jsp");
		dispatcher.forward(req, resp); // forward della richiesta a un'altra servlet, jsp o html
		dispatcher.include(req, resp); // includere un'altra servlet, jsp o html nella risposta
			
		resp.sendRedirect("url/par1=val1&par2=val2"); // redirect a un'altra servlet o jsp, req e resp vengono rigenerate
        
		PrintWriter out = resp.getWriter();
		out.println("output"); // scrivere nel body della risposta
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// request
		// lettura del body della richiesta
		String body = "";
		String line;
        BufferedReader reader = req.getReader();
        while ((line = reader.readLine()) != null) {
        	body += line;
        }
		
		MyBean[] myBeansArray = gson.fromJson("JSONStr", MyBean[].class); // da JSON a bean array
		List<MyBean> myBeans = Arrays.asList(myBeansArray); // da array a lista
		
		req.getAttribute("attributeName"); // oggetto attributo di un forward o include
		req.getParameter("parameterName"); // stringa parametro di un form o del body della richiesta AJAX
        getServletContext().getAttribute("attributeName"); // oggetto attributo globale
		
        HttpSession session = req.getSession(true);
        session.getAttribute("attributeName"); // oggetto attributo di sessione
        
        req.getHeader("headerName"); // header impostato solitamente con AJAX
        
		for (Cookie cookie : req.getCookies()) {
			if (cookie.getName().equals("cookieName")) {
				// lavorare con un cookie salvato sul client precedentemente
				break;
			}
		}
		
		
		// lettura e scrittura su file
		

		// response
		gson.toJson(myBeans.toArray(new MyBean[0])); // da bean list a JSON
		
		Cookie cookie = new Cookie("cookieName", "value");
        resp.addCookie(cookie); // inviare un cookie al client

        getServletContext().setAttribute("attributeName", "value"); // oggetto attributo globale
        
        session.setAttribute("attributeName", "value"); // oggetto attributo di sessione
        
        req.setAttribute("attributeName", "value"); // oggetto attributo da inviare a un'altra servlet o jsp tramite forward o include
		RequestDispatcher dispatcher =
			getServletContext().getRequestDispatcher("servlet/jsp");
		dispatcher.forward(req, resp); // forward della richiesta a un'altra servlet, jsp o html
		dispatcher.include(req, resp); // includere un'altra servlet, jsp o html nella risposta
			
			
		resp.sendRedirect("url"); // redirect a un'altra servlet o jsp, req e resp vengono rigenerate
        
		PrintWriter out = resp.getWriter();
		out.println("output"); // scrivere nel body della risposta
	}
	
}