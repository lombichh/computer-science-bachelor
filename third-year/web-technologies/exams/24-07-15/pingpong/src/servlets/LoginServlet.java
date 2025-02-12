package servlets;

import java.io.BufferedReader;
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

import beans.MyBean;
import beans.User;

// 1 istanza condivisa da tutte le richieste (thread)
public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		// inizializza lista di utenti
		Map<String, User> users = new HashMap<>();
		
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
		
		users.put(user1.getUsername(), user1);
		users.put(user2.getUsername(), user2);
		users.put(user3.getUsername(), user3);
		users.put(user4.getUsername(), user4);
		
		this.getServletContext().setAttribute("users", users);
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
				resp.sendRedirect("home.jsp");
			}
		}
	}
	
}