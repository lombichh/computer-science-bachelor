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
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import beans.InputData;
import beans.Person;
import beans.Result;

// 1 istanza condivisa da tutte le richieste (thread), variabili di istanza per lo stato di applicazione
public class RicercaServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private Gson gson;

	@Override
	public void init() throws ServletException {
		// richiamato 1 sola volta, no concorrenza
		gson = new Gson();
		
		Map<Integer, Integer> numRichieste = new ConcurrentHashMap<Integer, Integer>(); // sessionId: num
		this.getServletContext().setAttribute("numRichieste", numRichieste);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// ricerca
		String body = "";
		String line;
        BufferedReader reader = req.getReader();
        while ((line = reader.readLine()) != null) {
        	body += line;
        }
        
        InputData inputData = gson.fromJson(body, InputData.class);
        
        Map<Integer, Integer> numRichieste = (Map<Integer, Integer>) this.getServletContext().getAttribute("numRichieste");
        Integer num = numRichieste.get(inputData.getSessionId());
        if (num == null) numRichieste.put(inputData.getSessionId(), 0);
        else  numRichieste.put(inputData.getSessionId(), num+1);
        
        int occ = 0;
        for (Person person : inputData.getPersonsList()) {
        	if (person.getSurname().equals("Di Modica")) occ++;
        }
        
        Result result = new Result();
        result.setNum(inputData.getNum());
        result.setValue(occ);
        
        PrintWriter out = resp.getWriter();
		out.println(gson.toJson(result));
	}
	
}