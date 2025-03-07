<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- import di classi Java -->
<%@ page import="beans.User"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Stampa</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
	</head>
	<body>
		<h1>Login</h1>
		
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
		<%= loginInfo %>
		<%
		}
		%>
		</p>
	
	</body>
</html>