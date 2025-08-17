var result1;
var result2;
var result3;
var numResults;


function ricercaCallback(xhr, outputElement) {
	if (xhr.readyState === 2) {
	    outputElement.innerHTML = "Richiesta inviata...";
	} else if (xhr.readyState === 3) {
    	outputElement.innerHTML = "Ricezione della risposta...";
	} else if (xhr.readyState === 4) {
		if (xhr.status === 200 && xhr.responseText && xhr.responseText !== "") {
			const result = JSON.parse(xhr.responseText);
			if (result.num == 1) result1 = result.value;
			else if (result.num == 2) result2 = result.value;
			else if (result.num == 3) result3 = result.value;
			
			numResults++;
			if (numResults == 3) {
				const totResults = result1 + result2 + result3;
				outputElement.innerHTML = "Sono state trovate "
					+ result1 + " + " + result2 + " + " + result3
					+ " = " + totResults + "occorrenze di Di Modica";
			}
		} else {
			outputElement.innerHTML = "Impossibile effettuare l'operazione richiesta.<br />";
			outputElement.innerHTML += "Errore riscontrato: " + xhr.statusText;
		}
	}
}


function ricercaIFrame(uri, outputElement) {
	outputElement.innerHTML = '<iframe src="' + uri + '" width="50%" height="50px">Il tuo browser non supporta gli iframe</iframe>';
}


function ricercaAJAX(xhr, uri, inputData, outputElement) {
	xhr.onreadystatechange = function() { ricercaCallback(xhr, outputElement); };

	try {
		xhr.open("post", uri, true);
	} catch(e) { alert(e); }

	xhr.setRequestHeader("Content-Type", "application/json"); // specifica tipo dati JSON nel body
	
	xhr.send(JSON.stringify(inputData)); // inserimento nel body per POST
}


function ricerca(uri, sessionId, inputElement, outputElement) {
	const personsList = JSON.parse(inputElement.value).personsList;
	const n = personsList.length;
	const n3 = Math.floor(n/3);

	var personsList1;
	var personsList2;
	var personsList3;
	
	if (n%3 == 0) {
		// n%3 == 2 -> n/3, n/3, n/3
		var inputI = 0;
		
		var outputI = 0;
		while (inputI < n3) {
			personsList1[outputI] = personsList[inputI];
			inputI++;
			outputI++;
		}
		
		outputI = 0;
		while (inputI < n3) {
			personsList2[outputI] = personsList[inputI];
			inputI++;
			outputI++;
		}
		
		outputI = 0;
		while (inputI < n3) {
			personsList3[outputI] = personsList[inputI];
			inputI++;
			outputI++;
		}
	} else if (n%3 == 1) {
		// n%3 == 1 -> n/3, n/3, n/3+1
		var inputI = 0;

		var outputI = 0;
		while (inputI < n3) {
			personsList1[outputI] = personsList[inputI];
			inputI++;
			outputI++;
		}

		outputI = 0;
		while (inputI < n3) {
			personsList2[outputI] = personsList[inputI];
			inputI++;
			outputI++;
		}

		outputI = 0;
		while (inputI < n3+1) {
			personsList3[outputI] = personsList[inputI];
			inputI++;
			outputI++;
		}
	} else {
		// n%3 == 2 -> n/3, n/3+1, n/3+1
		var inputI = 0;

		var outputI = 0;
		while (inputI < n3) {
			personsList1[outputI] = personsList[inputI];
			inputI++;
			outputI++;
		}

		outputI = 0;
		while (inputI < n3+1) {
			personsList2[outputI] = personsList[inputI];
			inputI++;
			outputI++;
		}

		outputI = 0;
		while (inputI < n3+1) {
			personsList3[outputI] = personsList[inputI];
			inputI++;
			outputI++;
		}
	}
	
	var xhr = myGetXmlHttpRequest();

	if (xhr) {
		numResults = 0;
		result1 = -1;
		result2 = -1;
		result3 = -1;
		
		const inputData1 = {sessionId: sessionId, num: 1, personList: personsList1};
		ricercaAJAX(xhr, uri, inputData1, outputElement);
		const inputData2 = {sessionId: sessionId, num: 2, personList: personsList2};
		ricercaAJAX(xhr, uri, inputData2, outputElement);
		const inputData3 = {sessionId: sessionId, num: 3, personList: personsList3};
		ricercaAJAX(xhr, uri, inputData3, outputElement);
	} else ricercaIFrame(uri, outputElement);
}