<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- import di classi Java -->
<%@ page import="beans.User"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Ping pong</title>
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
		User currentUser = (User) session.getAttribute("currentUser");
		if (currentUser == null) {
			String loginInfo = (String) request.getAttribute("loginInfo");
			if (loginInfo != null) {
		%>
		<%=		loginInfo %>
		<%
			}
		} else {
			response.sendRedirect("home.html");
		}
		%>
		</p>
	
	</body>
</html>