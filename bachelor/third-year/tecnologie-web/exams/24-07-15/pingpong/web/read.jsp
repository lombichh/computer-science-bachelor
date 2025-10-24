<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- import di classi Java -->
<%@ page import="beans.Prenotazioni"%>
<%@ page import="beans.Prenotazione"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Ping pong</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
		
		 <meta http-equiv="Refresh" content= "3; URL=read.jsp"/>
	</head>
	<body>
		<h1>Lista prenotazioni</h1>
		
		<jsp:useBean id="prenotazioni" class="beans.Prenotazioni" scope="application"/>

		<p>Tavolo 1: </p><br/>
		<ul>
		<%
		if (prenotazioni != null) {
			for (Prenotazione prenotazione : prenotazioni.getPrenotazioni1()) {
				if (prenotazione.isValid() == true) {
		%>
					<li> Orario inizio: <%= prenotazione.getOra() %>:<%= prenotazione.getMinuti() %> </li>
		<%
				}
			}
		}
		%>
		</ul>
		
		<p>Tavolo 2: </p><br/>
		<ul>
		<%
		if (prenotazioni != null) {
			for (Prenotazione prenotazione : prenotazioni.getPrenotazioni2()) {
				if (prenotazione.isValid() == true) {
		%>
					<li> Orario inizio: <%= prenotazione.getOra() %>:<%= prenotazione.getMinuti() %> </li>
		<%
				}
			}
		}
		%>
		</ul>
	
	</body>
</html>