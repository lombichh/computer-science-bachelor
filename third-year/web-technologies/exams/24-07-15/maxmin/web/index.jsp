<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Max Min</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
		
		<script type="text/javascript" src="scripts/utils.js"></script>
		<script type="text/javascript" src="scripts/maxminRequest.js"></script>
	</head>
	<body>
		<h1>Calcolo massimo e minimo</h1>
		
		<form>
			<label>N: <input type="text" id="n" name="n" value=""/><br/></label>
			<label>Matrice (formato JSON): <input type="text" id="matrice" name="matrice" value=""/><br/></label>
		</form>
		
		<button onclick="asyncRequest('maxminServlet', myGetElementById('n'), myGetElementById('matrice'), myGetElementById('maxminOutput'))">Calcola</button>
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