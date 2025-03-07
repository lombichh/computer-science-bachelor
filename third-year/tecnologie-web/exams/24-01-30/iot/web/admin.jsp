<DOCTYPE! html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>IoT</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
		
		<script type="text/javascript" src="scripts/utils.js"></script>
		<script type="text/javascript" src="scripts/websocket.js"></script>
	</head>
	<body>
		Session id: <input id="sessionId" type="text"></input><br/>
		Comando: <input id="comandoText" type="text"></input><br/>
		
		<button onclick="inviaComando()">Invia comando</button>
	
	</body>
</html>