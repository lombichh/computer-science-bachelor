<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Ping pong</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
	</head>
	<body>
		<h1>Aggiungi prenotazione</h1>
		
		<form action="pingPongServlet" method="GET">
			<label>Ora: <input type="text" name="ora" value=""/><br/></label>
			<label>Minuti: <input type="text" name="minuti" value=""/><br/></label>
			<input type="submit" value="Aggiungi prenotazione"/>
		</form>
		
		<!-- info -->
		<p>
		<%
		String addInfo = (String) request.getAttribute("addInfo");
		if (addInfo != null) {
		%>
		<%=	addInfo %>
		<%
		}
		%>
		</p>
	
	</body>
</html>