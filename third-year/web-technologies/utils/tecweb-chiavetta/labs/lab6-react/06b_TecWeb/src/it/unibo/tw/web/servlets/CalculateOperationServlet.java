package it.unibo.tw.web.servlets;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;

public class CalculateOperationServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		double num = Double.parseDouble(req.getParameter("num"));
		String op = req.getParameter("op");
		
		double result = -1;
		if (op.equals("log_e")) result = Math.log(num);
		else if (op.equals("sqrt")) result = Math.sqrt(num);
		else if (op.equals("e_x")) result = Math.exp(num);
		else if (op.equals("1/x")) result = 1/num;
		
		resp.getWriter().print(result);
	}
}