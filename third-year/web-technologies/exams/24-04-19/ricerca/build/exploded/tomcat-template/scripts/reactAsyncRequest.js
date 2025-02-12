function reactAsyncRequestCallback(xhr, callback) {
	if (xhr.readyState === 4) {
		if (xhr.status === 200 && xhr.responseText && xhr.responseText !== "") {
    	    callback(JSON.parse(xhr.responseText).value);
		}
	}
}



function reactAsyncRequestAJAX(xhr, uri, input, callback) {
	xhr.onreadystatechange = function() { reactAsyncRequestCallback(xhr, callback); };

	try {
		xhr.open("get", uri+"?input="+input, true); // inserimento nella query per GET
		xhr.open("post", uri, true);
	} catch(e) { alert(e); }

	xhr.setRequestHeader("Content-Type", "application/json"); // specifica tipo dati JSON nel body
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); // specifica tipo dati par1=value1&par2=value2 nel body
	
	xhr.send("input="+input); // inserimento nel body per POST
}



function reactAsyncRequest(uri, input, callback) {
	var xhr = myGetXmlHttpRequest();

	if (xhr) reactAsyncRequestAJAX(xhr, uri, input, callback);
}