function asyncRequestAJAX(xhr, uri, giornalista, notizia) {
	try {
		xhr.open("post", uri, true);
	} catch(e) { alert(e); }

	xhr.setRequestHeader("Content-Type", "application/json"); // specifica tipo dati JSON nel body
	
	var request = {type: 3, giornalista: giornalista, notizia: notizia};
	
	xhr.send(JSON.stringify(request)); // inserimento nel body per POST
}



function asyncRequest(uri, giornalista, notizia) {
	var xhr = myGetXmlHttpRequest();

	if (xhr) asyncRequestAJAX(xhr, uri, giornalista, notizia);
}