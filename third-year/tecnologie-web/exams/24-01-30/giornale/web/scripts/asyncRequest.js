function parseJSON(jsonText) {
	var newslist = JSON.parse(jsonText);

	result = "<ul>";

	for(var i = 0; i < newslist.newslist.length; i++) {
		result += '<li> Giornalista: ' + newslist.newslist[i].giornalista + '; Notizia: ' + newslist.newslist[i].notizia + '</li>';
	};

	result += "</ul>";

 	return result;
}


function asyncRequestCallback(xhr, outputElement) {
	if (xhr.readyState === 2) {
	    outputElement.innerHTML = "Richiesta inviata...";
	} else if (xhr.readyState === 3) {
    	outputElement.innerHTML = "Ricezione della risposta...";
	} else if (xhr.readyState === 4) {
		if (xhr.status === 200 && xhr.responseText && xhr.responseText !== "") {
			outputElement.innerHTML = parseJSON(xhr.responseText);
			asyncRequest('giornaleServlet', 2, myGetElementById("outputNews")); // richiesta aggiornamento news
		} else {
			outputElement.innerHTML = "Impossibile effettuare l'operazione richiesta.<br />";
			outputElement.innerHTML += "Errore riscontrato: " + xhr.statusText;
		}
	}
}



function asyncRequestIFrame(uri, outputElement) {
	outputElement.innerHTML = '<iframe src="' + uri + '" width="50%" height="50px">Il tuo browser non supporta gli iframe</iframe>';
}



function asyncRequestAJAX(xhr, uri, type, outputElement) {
	xhr.onreadystatechange = function() { asyncRequestCallback(xhr, outputElement); };

	try {
		xhr.open("post", uri, true);
	} catch(e) { alert(e); }

	xhr.setRequestHeader("Content-Type", "application/json"); // specifica tipo dati JSON nel body

	var request = {type: type, giornalista: "", notizia: ""};
	
	xhr.send(JSON.stringify(request)); // inserimento nel body per POST
}



function asyncRequest(uri, type, outputElement) {
	var xhr = myGetXmlHttpRequest();

	if (xhr) asyncRequestAJAX(xhr, uri, type, outputElement); 
	else asyncRequestIFrame(uri, outputElement);
}

asyncRequest('giornaleServlet', 1, myGetElementById("outputNews")); // richiesta news