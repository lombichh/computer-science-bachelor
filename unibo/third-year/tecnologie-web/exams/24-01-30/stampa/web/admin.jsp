<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Stampa</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
	</head>
	<body>
		<form action="nuovoMaxPagServlet" method="POST">
			<label>Nuovo massimo di pagine per professori: <input type="text" name="nuovoMaxPagProfessori" value=""/><br/></label>
			<label>Nuovo massimo di pagine per dottorandi: <input type="text" name="nuovoMaxPagDottorandi" value=""/><br/></label>
			<input type="submit" value="Aggiorna"/>
		</form>
	</body>
</html>