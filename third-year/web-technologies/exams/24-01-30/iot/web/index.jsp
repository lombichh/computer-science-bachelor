<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- import di classi Java -->
<%@ page import="beans.User"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>App name</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
		
		<script type="text/javascript" src="scripts/utils.js"></script>
		<script type="text/javascript" src="scripts/websocket.js"></script>
	</head>
	<body>
		<h1>Interazione IoT</h1>
		
		<button onclick="startIoT()">Inizia interazione IoT</button>
    	<p id="iotOutput"></p>
		
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
		<%=	loginInfo %>
		<%
		}
		%>
		</p>
	
	</body>
</html>