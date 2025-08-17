<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- import di classi Java -->
<%@ page import="beans.User"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Ricerca</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
		
		<script type="text/javascript" src="scripts/utils.js"></script>
		<script type="text/javascript" src="scripts/ricerca.js"></script>
	</head>
	<body>
		<h1>Ricerca</h1>
		
		<label>File JSON: <input id="ricercaInput" type="text" name="ricercaInput" value=""/><br/></label>
		<button onclick="ricerca('ricercaServlet', <% session.getId() %>, myGetElementById('ricercaInput'), myGetElementById('ricercaOutput'))">Ricerca</button>
		<p id="ricercaOutput"></p>
	
		<h1>Login amministratore</h1>
		
		<!-- login form -->
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