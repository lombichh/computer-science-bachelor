function leggiCallback(xhr) {
	if (xhr.readyState === 4) {
		if (xhr.status === 200 && xhr.responseText && xhr.responseText !== "") {
			myGetElementById("lavagnaOutput").innerHTML = xhr.responseText;
		}
	}

}


function leggi() {
	var xhr = myGetXmlHttpRequest();

	if (xhr) {
		xhr.onreadystatechange = function() { leggiCallback(xhr); };

		try {
			xhr.open("get", "lavagnaServlet", true);
		} catch(e) { alert(e); }

		xhr.send();
	}
	
}


function iniziaLettura() {
	leggi();
	setInterval(leggi, 10000);
}