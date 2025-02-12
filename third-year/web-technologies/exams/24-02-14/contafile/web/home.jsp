<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Conta file</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
		
		<script type="text/javascript" src="scripts/utils.js"></script>
		<script type="text/javascript" src="scripts/request.js"></script>
	</head>
	<body>
		<h1>Home</h1>
		
		<form action="servletS1" method="POST" id="conteggioform" enctype="application/json">
			<input type="radio" name="tipoconteggio" value="Caratteri alfabetici"/><br/>
			<input type="radio" name="tipoconteggio" value="Caratteri numerici"/><br/>
			<label>Nome file: <input id="nomefile" type="text" name="nomefile" value="" onkeyup="conteggio()"/><br/></label>
		</form>
	
	</body>
</html>