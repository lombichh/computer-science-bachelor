<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- import di classi Java -->
<%@ page import="java.util.*"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		
		<title>App name</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
	</head>
	<body onload="">
		<%
		String nomefile = (String) request.getAttribute("nomefile");
		
		// conteggio caratteri alfabetici su file
		File file = new File(nomefile);
		if (file.exists()) {
			// lettura
			BufferedReader bufferedReader = new BufferedReader(new FileReader(file));
			String fileLine;
			
			int numConteggi = 0;
			boolean fileDaContare = true;
			
            while (fileDaContare && (fileLine = bufferedReader.readLine()) != null) {
				if (fileLine.startWith("Il numero di caratteri numerici del file è uguale a")) {
					numConteggi++;
					if (numConteggi == 3) fileDaContare = false;
				} else break;
            }
            
            if (fileDaContare) {
            	char car;
    			int numCar = 0;
                while ((car = bufferedReader.read()) != null) {
                	if (Character.isDigit(car)) numCar++;
                }
                // conteggio finito -> stampa
        %>
        		Numero di caratteri contenuti nel file: <%=	loginInfo %>
        <%
        		FileWriter fileWriter = new FileWriter(file);
        		fileWriter.write("Il numero di caratteri numerici del file è uguale a " + loginInfo);
        	} else {
        %>
        		Ci sono già 3 conteggi di caratteri alfabetici del file.
        <%
        	}
        %>
	</body>
</html>

