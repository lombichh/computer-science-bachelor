<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- import di classi Java -->
<%@ page import="java.util.*"%>
<%@ page import="com.google.gson.Gson"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		
		<title>Ricerca</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
	</head>
	<body>
		<%
		Map<Integer, Integer> numRichieste = (Map<Integer, Integer>) application.getAttribute("numRichieste");
		
		int numRichiesteInCorso = 0;
		int numRichiesteCompletate = 0;
		for (Map.Entry<Integer, Integer> richiesta : numRichieste.entrySet()) {
			if (richiesta.getKey() == 3) numRichiesteCompletate++;
			else numRichiesteInCorso++;
		}
		%>
		
		<p>Numero richieste in corso: <%= numRichiesteInCorso %></p>
		<p>Numero richieste completate: <%= numRichiesteCompletate %></p>
	
	</body>
</html>

