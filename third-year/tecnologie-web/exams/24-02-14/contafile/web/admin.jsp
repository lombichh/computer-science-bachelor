<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Conta file</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
	</head>
	<body>
		<h1>Admin</h1>
		
		<form action="removeServlet" method="POST">
			<label>Nome file: <input id="nomefile" type="text" name="nomefile" value=""/><br/></label>
			<label>Numero riga: <input id="numriga" type="text" name="numriga" value=""/><br/></label>
			<input type="submit" value="Elimina riga"/>
		</form>
	
	</body>
</html>