
package it.unibo.tw.es1.servlets;

import java.io.IOException;
import java.util.Vector;

import it.unibo.tw.es1.beans.InsiemeDiArticoli;
import it.unibo.tw.es1.beans.Articolo;

import javax.servlet.*;
import javax.servlet.http.*;


public class StatisticheServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String id = req.getParameter("id");
		int firstDay = Integer.parseInt(req.getParameter("firstDay"));
		int lastDay = Integer.parseInt(req.getParameter("lastDay"));
		
		float guadagno = 0;
		
		InsiemeDiArticoli merceVenduta = (InsiemeDiArticoli) this.getServletContext().getAttribute("merceVenduta");
		for (Articolo art : merceVenduta.getMerce()) {
			if ((id.equals("") || art.getId().equals(id)) && firstDay <= art.getDay() && lastDay >= art.getDay())
				guadagno += art.getPrice() * art.getAmount();
		}
		
		// save guadagno in cookies
		Cookie cookie1 = new Cookie("id", id);
		Cookie cookie2 = new Cookie("firstDay", ""+firstDay);
		Cookie cookie3 = new Cookie("lastDay", ""+lastDay);
		Cookie cookie4 = new Cookie("guadagno", ""+guadagno);
		resp.addCookie(cookie1);
		resp.addCookie(cookie2);
		resp.addCookie(cookie3);
		resp.addCookie(cookie4);
		
		// set guadagno in response
		req.setAttribute("guadagnoRichiestaAttuale", guadagno);
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/statistiche.jsp");
		dispatcher.forward(req, resp);
	}
	
}
