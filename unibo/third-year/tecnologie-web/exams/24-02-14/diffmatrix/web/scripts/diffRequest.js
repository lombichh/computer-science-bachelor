var numResults = 0;
var row1 = -1;
var row2 = -1;
var row3 = -1;
var row4 = -1;


function asyncRequestCallback(xhr, outputElement) {
	if (xhr.readyState === 2) {
	    outputElement.innerHTML = "Richiesta inviata...";
	} else if (xhr.readyState === 3) {
    	outputElement.innerHTML = "Ricezione della risposta...";
	} else if (xhr.readyState === 4) {
		if (xhr.status === 200 && xhr.responseText && xhr.responseText !== "") {
			var response = JSON.parse(xhr.responseText);
			if (response.rowIndex == 1) row1 = response.row;
			else if (response.rowIndex == 2) row2 = response.row;
			else if (response.rowIndex == 3) row3 = response.row;
			else if (response.rowIndex == 4) row4 = response.row;

			numResults++;
			
			if (numResults == 4)
				outputElement.innerHTML = "Matrice risultante: [[" + row1 + "], [" + row2 + "], [" + row3 + "], [" + row4 + "]]\nTempo complessivo: " + response.millis;
		} else {
			outputElement.innerHTML = "Impossibile effettuare l'operazione richiesta.<br />";
			outputElement.innerHTML += "Errore riscontrato: " + xhr.statusText;
		}
	}

}



function asyncRequestIFrame(uri, outputElement) {
	outputElement.innerHTML = '<iframe src="' + uri + '" width="50%" height="50px">Il tuo browser non supporta gli iframe</iframe>';
}



function asyncRequestAJAX(xhr, uri, rowIndex, row1, row2, outputElement) {
	xhr.onreadystatechange = function() { asyncRequestCallback(xhr, outputElement); };

	try {
		xhr.open("post", uri, true);
	} catch(e) { alert(e); }

	var request = {rowIndex: rowIndex, row1: row1, row2: row2};

	xhr.setRequestHeader("Content-Type", "application/json"); // specifica tipo dati JSON nel body
	xhr.send(JSON.stringify(request));
}



function asyncRequest(uri, outputElement) {
	var row11 = myGetElementById("1-1");
	var row12 = myGetElementById("1-2");
	var row13 = myGetElementById("1-3");
	var row14 = myGetElementById("1-4");
	
	var row21 = myGetElementById("2-1");
	var row22 = myGetElementById("2-2");
	var row23 = myGetElementById("2-3");
	var row24 = myGetElementById("2-4");
	
	var elems11 = row11.split(',');
	var elems12 = row11.split(',');
	var elems13 = row11.split(',');
	var elems14 = row11.split(',');

	var elems21 = row11.split(',');
	var elems22 = row11.split(',');
	var elems23 = row11.split(',');
	var elems24 = row11.split(',');
	
	// controllo argomenti
	var valid = true;
	for (var col = 0; col < 4; col++) {
		if (isNaN(elems11[col]) || elems11[col] >= 500) valid = false;
		if (isNaN(elems12[col]) || elems12[col] >= 500) valid = false;
		if (isNaN(elems13[col]) || elems13[col] >= 500) valid = false;
		if (isNaN(elems14[col]) || elems14[col] >= 500) valid = false;
	}
	for (var col = 0; col < 4; col++) {
		if (isNaN(elems21[col]) || elems21[col] >= 500) valid = false;
		if (isNaN(elems22[col]) || elems22[col] >= 500) valid = false;
		if (isNaN(elems23[col]) || elems23[col] >= 500) valid = false;
		if (isNaN(elems24[col]) || elems24[col] >= 500) valid = false;
	}
	
	if (valid) {
		// argomenti validi -> richiesta
		var xhr = myGetXmlHttpRequest();
		if (xhr) {
			numResults = 0;
			asyncRequestAJAX(xhr, uri, 1, elems11, elems21, outputElement);
			asyncRequestAJAX(xhr, uri, 2, elems12, elems22, outputElement);
			asyncRequestAJAX(xhr, uri, 3, elems13, elems23, outputElement);
			asyncRequestAJAX(xhr, uri, 4, elems14, elems24, outputElement);
		} else asyncRequestIFrame(uri, outputElement);
	}
}