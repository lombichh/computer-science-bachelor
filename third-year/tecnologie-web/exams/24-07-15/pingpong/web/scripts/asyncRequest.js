function parseJSON(jsonText) {
	var items = JSON.parse(jsonText);

	result = "<ul>";

	for(var i = 0; i < items.length; i++) {
		result += '<li>'+items[i].value+'</li>';
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
		} else {
			outputElement.innerHTML = "Impossibile effettuare l'operazione richiesta.<br />";
			outputElement.innerHTML += "Errore riscontrato: " + xhr.statusText;
		}
	}
}



function asyncRequestIFrame(uri, outputElement) {
	outputElement.innerHTML = '<iframe src="' + uri + '" width="50%" height="50px">Il tuo browser non supporta gli iframe</iframe>';
}



function asyncRequestAJAX(xhr, uri, inputElement, outputElement) {
	xhr.onreadystatechange = function() { asyncRequestCallback(xhr, outputElement); };

	try {
		xhr.open("get", uri+"?inputText="+inputElement.value, true); // inserimento nella query per GET
		xhr.open("post", uri, true);
	} catch(e) { alert(e); }

	xhr.setRequestHeader("Content-Type", "application/json"); // specifica tipo dati JSON nel body
	xhr.setRequestHeader("Content-Type", "application/xml"); // specifica tipo dati XML nel body
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); // specifica tipo dati par1=value1&par2=value2 nel body
	
	xhr.send("inputText="+inputElement.value); // inserimento nel body per POST
}



function asyncRequest(uri, inputElement, outputElement) {
	var xhr = myGetXmlHttpRequest();

	if (xhr) asyncRequestAJAX(xhr, uri, inputElement, outputElement); 
	else asyncRequestIFrame(uri, outputElement);
}