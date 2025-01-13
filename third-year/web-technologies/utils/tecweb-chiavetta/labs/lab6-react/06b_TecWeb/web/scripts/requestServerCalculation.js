function getServerCalculationResult(xhr, callback) {
	if (xhr.readyState === 4) {
		if (xhr.status === 200) {
			callback(xhr.responseText);
		} else {
			state = {
				result: "Error"
			}
		}

	}
}



function requestServerCalculationAJAX(uri, xhr, callback) {
	xhr.onreadystatechange = function() {
		getServerCalculationResult(xhr, callback);
	}

	try {
		xhr.open("get", uri, true);
	}
	catch(e) { alert(e); }

	xhr.send(null);
}



function requestServerCalculation(uri, callback) {
	var xhr = myGetXmlHttpRequest();
	
	if (xhr) requestServerCalculationAJAX(uri, xhr, callback);

}
