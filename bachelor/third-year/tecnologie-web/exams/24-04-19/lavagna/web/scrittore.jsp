<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- import di classi Java -->
<%@ page import="java.util.*"%>
<%@ page import="beans.User"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		
		<title>Lavagna</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
	</head>
	<body>
		<!-- scriptlet. Le variabili e i metodi definiti qui sono specifici dell'attuale richiesta e non sono condivisi. -->
		<%
		User currentUser = (User) application.getAttribute("currentUser");
		Map<String, Integer> usersLavagna = (Map<String, Integer>) application.getAttribute("usersLavagna");
		
		String lavagna;
		
		if (usersLavagna.get(currentUser.getUsername()) == 1) lavagna = (String) application.getAttribute("lavagna1");
		else lavagna = (String) application.getAttribute("lavagna2");
		%>
		
		<form action="lavagnaServlet" method="POST">
			<input type="text" name="lavagna" value="<%= lavagna %>"/>
			<input type="submit" value="Invia"/>
		</form>
	
	</body>
</html>