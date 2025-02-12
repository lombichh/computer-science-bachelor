<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- import di classi Java -->
<%@ page import="java.util.*"%>
<%@ page import="beans.User"%>
<%@ page import="beans.PrintRequest"%>
<%@ page import="com.google.gson.Gson"%>

<%@ page session="true"%>
<html>
	<head>
		<meta charset="UTF-8" />
		
		<title>Stampa</title>
		<link type="text/css" href="styles/default.css" rel="stylesheet"></link>
		
		<!-- Dichiarazione. Le variabili e i metodi definiti qui sono condivisi da tutte le richieste per questa JSP. -->
		<%!
			Gson gson = new Gson();
		%>
	</head>
	<body>
		<!-- scriptlet. Le variabili e i metodi definiti qui sono specifici dell'attuale richiesta e non sono condivisi. -->
		<%
		String body = "";
		String line;
        BufferedReader reader = request.getReader();
        while ((line = reader.readLine()) != null) {
        	body += line;
        }
       	PrintRequest printRequest = gson.fromJson(body, PrintRequest.class);
       	
       	int numNomiFile = Integer.parseInt(printRequest.getNumNomiFile());
       	for (int i = 1; i <= numNomiFile; i++) {
       		String nomeFile;
       		if (i == 1) nomeFile = printRequest.getNomeFile1();
       		else if (i == 2) nomeFile = printRequest.getNomeFile2();
       		else if (i == 3) nomeFile = printRequest.getNomeFile3();
       		else if (i == 4) nomeFile = printRequest.getNomeFile4();
       		
       		int giornoUltimaStampa = (int) application.getAttribute("giornoUltimaStampa");
       		
       		Map<String, Integer> usersGroup = (Map<String, Integer>) application.getAttribute("usersGroup");
       		User currentUser = (User) session.getAttribute("currentUser");
       		int group = usersGroup.get(currentUser.getUsername());
       		if (group == 1) {
       			// professore
       			if (giornoUltimaStampa != LocalDate.now().getDayOfMonth()) {
       				application.setAttribute("pagStampateProfessori", 0);
       				int nuovoMaxPag = (int) application.getAttribute("nuovoMaxPagProfessori");
					if (nuovoMaxPag != -1) {
						application.setAttribute("maxPagProfessori", nuovoMaxPag);
					}
       			}
       			
       			int pagStampate = (int) application.getAttribute("pagStampateProfessori");
       			int maxPag = (int) application.getAttribute("maxPagProfessori");
       			
       			File file = new File(nomeFile);
           		int filePag = file.length()/100;
           		
           		if (pagStampate + filePag < maxPag) {
           			application.setAttribute("pagStampateProfessori", pagStampate + filePag);
           			
           			request.setAttribute("nomeFile", nomeFile);

               		RequestDispatcher dispatcher;
               		if (file.length()/100 > 10) dispatcher = application.getRequestDispatcher("s2Servlet");
               		else dispatcher = application.getRequestDispatcher("s1Servlet");
               		dispatcher.include(request, response);
           		}
       		} else if (group == 2) {
       			// dottorando
       			if (giornoUltimaStampa != LocalDate.now().getDayOfMonth()) {
       				application.setAttribute("pagStampateDottorandi", 0);
       				int nuovoMaxPag = (int) application.getAttribute("nuovoMaxPagProfessori");
					if (nuovoMaxPag != -1) {
						application.setAttribute("maxPagDottorandi", nuovoMaxPag);
					}
       			}
       			
       			int pagStampate = (int) application.getAttribute("pagStampateDottorandi");
       			int maxPag = (int) application.getAttribute("maxPagDottorandi");
       			
       			File file = new File(nomeFile);
           		int filePag = file.length()/100;
           		
           		if (pagStampate + filePag < maxPag) {
           			application.setAttribute("pagStampateDottorandi", pagStampate + filePag);
           			
           			request.setAttribute("nomeFile", nomeFile);

               		RequestDispatcher dispatcher;
               		if (file.length()/100 > 10) dispatcher = application.getRequestDispatcher("s2Servlet");
               		else dispatcher = application.getRequestDispatcher("s1Servlet");
               		dispatcher.include(request, response);
           		}
       		}
       	}
		%>
	</body>
</html>