<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		
		<title>Diff matrix</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
	</head>
	<body>
		<%
		
		
		MyBean[] myBeansArray = gson.fromJson("JSONStr", MyBean[].class); // da JSON a bean array
		List<MyBean> myBeans = Arrays.asList(myBeansArray); // da array a lista
		
		request.getAttribute("attributeName"); // oggetto attributo di un forward o include
		request.getParameter("parameterName"); // parametro di un form, della query string o del body della richiesta AJAX
		application.getAttribute("attributeName"); // oggetto attributo globale
		session.getAttribute("attributeName"); // oggetto attributo di sessione
		
		request.getHeader("headerName"); // header impostato solitamente con AJAX
		
		for (Cookie cookie : request.getCookies()) {
			if (cookie.getName().equals("cookieName")) {
				// lavorare con un cookie salvato sul client precedentemente
				break;
			}
		}
		
		
		// lettura e scrittura da file
		
		
		gson.toJson(myBeans.toArray(new MyBean[0])); // da bean list a JSON
		
		Cookie cookie = new Cookie("cookieName", "value");
        response.addCookie(cookie); // inviare un cookie al client

        application.setAttribute("attributeName", "value"); // oggetto attributo globale
        
        session.setAttribute("attributeName", "value"); // oggetto attributo di sessione
        
        request.setAttribute("attributeName", "value"); // oggetto attributo da inviare a un'altra servlet o jsp tramite forward o include
		RequestDispatcher dispatcher =
			application.getRequestDispatcher("servlet/jsp");
		dispatcher.forward(request, response); // forward della richiesta a un'altra servlet, jsp o html
		dispatcher.include(request, response); // includere un'altra servlet, jsp o html nella risposta
			
		response.sendRedirect("url/par1=val1&par2=val2"); // redirect a un'altra servlet o jsp, req e resp vengono rigenerate
		
		out.println("output"); // scrivere nel body della risposta
		%>
		
		<%= // espressione %>
		
		
		<!-- form -->
		<form action="myServlet" method="GET">
			<input type="hidden" name="par1" value="val1"/>
			<input type="hidden" name="par2" value="val2"/> <!-- parametri hidden da aggiungere alla richiesta -->
			
			<input id="textInput" type="text" name="textInput" value=""/>
			<input type="submit" value="Send"/>
		</form>
		
		
		<!-- richiesta ajax -->
		<button onclick="asyncRequest('myServlet', myGetElementById('textInput'), myGetElementById('asyncOutput'))">Async request</button>
		<span id="asyncOutput"></span>
	
	</body>
</html>

