<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		
		<title>Stampa</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
		
		<script type="text/javascript" src="scripts/utils.js"></script>
		<script type="text/javascript" src="scripts/printRequest.js"></script>
	</head>
	<body>
		
		<!-- form -->
		<form id="printForm" action="J1.jsp" method="POST" enctype="application/json">
			<label>Numero di nomi file:
				<select name="numNomiFile" onchange="numNomiFileChange()">
					<option value="1" selected="selected">1</option>
					<option value="2" selected="selected">2</option>
					<option value="3" selected="selected">3</option>
					<option value="4" selected="selected">4</option>
				</select>
			</label>
			
			<label>Nome file 1: <input type="text" name="nomeFile1" value="" onKeyUp="printRequest()"/><br/></label>
			<label>Nome file 2: <input type="text" name="nomeFile2" value="" onKeyUp="printRequest()"/><br/></label>
			<label>Nome file 3: <input type="text" name="nomeFile3" value="" onKeyUp="printRequest()"/><br/></label>
			<label>Nome file 4: <input type="text" name="nomeFile4" value="" onKeyUp="printRequest()"/><br/></label>
		</form>
	
	</body>
</html>

