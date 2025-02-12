<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Tombola</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
		
		<script type="text/javascript" src="scripts/utils.js"></script>
		<script type="text/javascript" src="scripts/websocket.js"></script>
	</head>
	<body>
		<h1>Invia messaggio push</h1>
		
		<input type="text" name="inputMessaggioAdmin" id="inputMessaggioAdmin" value="">
		
		<button onclick="messaggioPush()">Invia messaggio push</button>
	
	</body>
</html>