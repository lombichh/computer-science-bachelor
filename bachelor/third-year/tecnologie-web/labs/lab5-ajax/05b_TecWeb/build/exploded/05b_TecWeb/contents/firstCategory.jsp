<%@ page errorPage="../errors/failure.jsp"%>

<%@ page session="false"%>

<%@ page import="it.unibo.tw.web.beans.Feed"%>
<%@ page import="it.unibo.tw.web.beans.FeedDb"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<jsp:useBean id="feedDb" class="it.unibo.tw.web.beans.FeedDb"  scope = "application"/>

<%

	// recupero il tipo di categoria cercata dai parametri della richiesta
	String category = request.getParameter("category");
	
	// recupero i feed corrispondenti da database
	List<String> matchingCategories = feedDb.getCategories(category);
	
	if (matchingCategories.size() > 0) {
%>

<%=		matchingCategories.get(0) %>

<% } else { %>
<%= 	"" %>
<% } %>