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

// 1 istanza condivisa da tutte le richieste (thread), variabili di istanza per lo stato di applicazione
public class RemoveServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private Gson gson;

	@Override
	public void init() throws ServletException {
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String nomeFile = (String) req.getAttribute("nomefile");
		int numRiga = (Integer) req.getAttribute("numriga");
		
		File file = new File(nomeFile);
		File newFile = new File(nomeFile + "temp.txt");
		BufferedReader fileReader = new BufferedReader(new FileReader(file));
		FileWriter newFileWriter = new FileWriter(newFile);
		if (file.exists()) {
			int numRigaCorrente = 0;
			String line;
			while ((line = fileReader.readLine()) != null) {
				if (numRigaCorrente != numRiga) newFileWriter.write(line);
				numRigaCorrente++;
	        }
			file.delete();
			newFile.renameTo(file);
		}
		
		PrintWriter out = resp.getWriter();
		out.println("Riga eliminata"); // scrivere nel body della risposta
	}
	
}