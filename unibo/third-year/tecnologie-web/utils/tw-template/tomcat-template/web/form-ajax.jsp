<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- import di classi Java -->
<%@ page import="java.util.*"%>
<%@ page import="beans.MyBean"%>
<%@ page import="com.google.gson.Gson"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		
		<!-- redirect lato client (req e resp cambiano) -->
		<!--  <meta http-equiv="Refresh" content= "numSeconds; URL=otherPage"/> -->
		
		<!-- non memorizzare le pagine nella cache del browser -->
		<!-- <meta http-equiv="Pragma" content="no-cache"/> -->
		<!-- <meta http-equiv="Expires" content="-1"/> -->
		
		<title>App name</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
		
		<script type="text/javascript" src="scripts/utils.js"></script>
		<script type="text/javascript" src="scripts/asyncRequest.js"></script>
		
		<!-- Dichiarazione. Le variabili e i metodi definiti qui sono condivisi da tutte le richieste per questa JSP. -->
		<%!
			Gson gson = new Gson();
		%>
	</head>
	<body onload="">
		<!-- Azioni: -->
		<jsp:forward page="url">
			<jsp:param name="par1" value="val1"/>
			<jsp:param name="par2" value="val2"/>
		</jsp:forward> <!-- forward della richiesta a un'altra servlet, jsp o html -->
		<jsp:include page="url" flush="true/false">
			<jsp:param name="par1" value="val1"/>
			<jsp:param name="par2" value="val2"/>
		</jsp:include> <!-- includere un'altra servlet, jsp o html nella risposta -->
		
		<jsp:useBean id="myBean" class="beans.MyBean" scope="page/request/session/application"/>
		<jsp:setProperty name="myBean" property="value" param="nameParam"/>
		<jsp:setProperty name="myBean" property="value" value="value"/>
		<jsp:getProperty name="myBean" property="value"/>
		
		
		<!-- Includere un'altra servlet, jsp o html nella risposta -->
		<%@ include file="url" %>
	
	
		<!-- scriptlet. Le variabili e i metodi definiti qui sono specifici dell'attuale richiesta e non sono condivisi. -->
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

