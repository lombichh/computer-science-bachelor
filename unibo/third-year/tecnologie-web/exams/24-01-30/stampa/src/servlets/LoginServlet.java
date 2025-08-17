package servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
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

// 1 istanza condivisa da tutte le richieste (thread)
public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		// inizializza variabili globali
		
		// utenti e gruppi
		Map<String, User> users = new HashMap<>();
		Map<String, Integer> usersGroup = new HashMap<>(); // 1 -> professori, 2 -> dottorandi
		
		User admin = new User();
		admin.setUsername("admin");
		admin.setPassword("admin");
		
		User user1 = new User();
		user1.setUsername("user1");
		user1.setPassword("pass1");
		
		User user2 = new User();
		user2.setUsername("user2");
		user2.setPassword("pass2");
		
		User user3 = new User();
		user3.setUsername("user3");
		user3.setPassword("pass3");
		
		User user4 = new User();
		user4.setUsername("user4");
		user4.setPassword("pass4");

		users.put(admin.getUsername(), admin);
		users.put(user1.getUsername(), user1);
		users.put(user2.getUsername(), user2);
		users.put(user3.getUsername(), user3);
		users.put(user4.getUsername(), user4);
		
		usersGroup.put(user1.getUsername(), 1);
		usersGroup.put(user2.getUsername(), 2);
		usersGroup.put(user3.getUsername(), 2);
		usersGroup.put(user4.getUsername(), 1);
		
		this.getServletContext().setAttribute("users", users);
		this.getServletContext().setAttribute("usersGroup", usersGroup);
		
		// numero e max pagine stampate
		this.getServletContext().setAttribute("maxPagProfessori", 1000);
		this.getServletContext().setAttribute("maxPagDottorandi", 100);
		this.getServletContext().setAttribute("pagStampateProfessori", 0);
		this.getServletContext().setAttribute("pagStampateDottorandi", 0);
		this.getServletContext().setAttribute("nuovoMaxPagProfessori", -1);
		this.getServletContext().setAttribute("nuovoMaxPagDottorandi", -1);
		
		LocalDate today = LocalDate.now();
		int day = today.getDayOfMonth();
		this.getServletContext().setAttribute("giornoUltimaStampa", day);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		
		Map<String, User> users = (Map<String, User>) this.getServletContext().getAttribute("users");
		
		// check username
		User user = users.get(username);
		if (user == null) {
			req.setAttribute("loginInfo", "Username errato");
			RequestDispatcher dispatcher =
				getServletContext().getRequestDispatcher("/index.jsp");
			dispatcher.forward(req, resp);
		} else {
			// check password
			if (!user.getPassword().equals(password)) {
				req.setAttribute("loginInfo", "Password errata");
				RequestDispatcher dispatcher =
					getServletContext().getRequestDispatcher("/index.jsp");
				dispatcher.forward(req, resp);
			} else {
				// accesso andato a buon fine
				HttpSession session = req.getSession();
				session.setAttribute("currentUser", user);
				if (user.getUsername().equals("admin")) resp.sendRedirect("admin.jsp");
				else resp.sendRedirect("home.jsp");
			}
		}
	}
	
}