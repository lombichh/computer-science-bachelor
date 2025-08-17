package it.unibo.tw.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.*;

public class Servlet2b extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        PrintWriter out = response.getWriter();
        
        out.println("<html>");
        out.println("<head>");
        	out.println("<title>2b</title>");
        out.println("</head>");
        out.println("<body>");
        	out.println("<form onsubmit='/' method='POST'>");
        		out.println("<textarea name='text'>");
        
        // print previousText if exists
        HttpSession session = request.getSession(false);
        if (session != null) {
    				out.println(session.getAttribute("previousText"));
        }
        
        		out.println("</textarea>");
        		out.println("<br>");
        		out.println("<input type='submit' value='Invia POST'>");
    		out.println("</form>");
        out.println("</body>");
        out.println("</html>");

    }
    
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String previousText = request.getParameter("text");
		
		PrintWriter out = response.getWriter();
        
        out.println("<html>");
        out.println("<head>");
        	out.println("<title>2b</title>");
        out.println("</head>");
        out.println("<body>");
        	out.println("<form onsubmit='/' method='POST'>");
        		out.println("<textarea name='text'>" + previousText + "</textarea>");
        		out.println("<br>");
        		out.println("<input type='submit' value='Invia POST'>");
    		out.println("</form>");
        out.println("</body>");
        out.println("</html>");

		// store previousText
		HttpSession session = request.getSession(true);
		session.setAttribute("previousText", previousText);
    }

}