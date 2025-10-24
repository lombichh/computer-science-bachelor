<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Diff matrix</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
		
		<script type="text/javascript" src="scripts/utils.js"></script>
		<script type="text/javascript" src="scripts/diffRequest.js"></script>
	</head>
	<body>
		<h1>Calcolo differenza matrici</h1>
		
		<form>
			<fieldset>
			<legend>>Matrice 1</legend>
				<label>Riga 1 (separa con ,): <input type="text" id="1-1" name="1-1" value=""/><br/></label>
				<label>Riga 2 (separa con ,): <input type="text" id="1-2" name="1-2" value=""/><br/></label>
				<label>Riga 3 (separa con ,): <input type="text" id="1-3" name="1-3" value=""/><br/></label>
				<label>Riga 4 (separa con ,): <input type="text" id="1-4" name="1-4" value=""/><br/></label>
			</fieldset>
			<fieldset>
			<legend>>Matrice 2</legend>
				<label>Riga 1 (separa con ,): <input type="text" id="2-1" name="2-1" value=""/><br/></label>
				<label>Riga 2 (separa con ,): <input type="text" id="2-2" name="2-2" value=""/><br/></label>
				<label>Riga 3 (separa con ,): <input type="text" id="2-3" name="2-3" value=""/><br/></label>
				<label>Riga 4 (separa con ,): <input type="text" id="2-4" name="2-4" value=""/><br/></label>
			</fieldset>
		</form>
		
		<button onclick="asyncRequest('diffServlet', myGetElementById('maxminOutput'))">Calcola differenza</button>
		<span id="maxminOutput"></span>
		
		<h1>Accesso amministratore</h1>
		
		<form action="loginServlet" method="POST">
			<label>Username: <input type="text" name="username" value=""/><br/></label>
			<label>Password: <input type="password" name="password" value=""/><br/></label>
			<input type="submit" value="Login"/>
		</form>
		
		<!-- login info -->
		<p>
		<%
		String loginInfo = (String) request.getAttribute("loginInfo");
		if (loginInfo != null) {
		%>
		<%=	loginInfo %>
		<%
		}
		%>
		</p>
	
	</body>
</html>