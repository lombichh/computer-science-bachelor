var numResults = 0;
var max1 = -1;
var max2 = -1;
var min1 = -1;
var min2 = -1;


function asyncRequestCallback(xhr, outputElement) {
	if (xhr.readyState === 2) {
	    outputElement.innerHTML = "Richiesta inviata...";
	} else if (xhr.readyState === 3) {
    	outputElement.innerHTML = "Ricezione della risposta...";
	} else if (xhr.readyState === 4) {
		if (xhr.status === 200 && xhr.responseText && xhr.responseText !== "") {
			var maxminResponse = JSON.parse(xhr.responseText);
			if (maxminResponse.matr == 1) {
				max1 = maxminResponse.max;
				min1 = maxminResponse.min;
			}
			else if (maxminResponse.matr == 2)	{
				max2 = maxminResponse.max;
				min2 = maxminResponse.min;
			}

			numResults++;
			
			if (numResults == 2) {
				var max;
				var min;
				
				if (max1 > max2) max = max1;
				else max = max2;
				
				if (min1 > min2) min = min1;
				else min = min2;
				
				outputElement.innerHTML = "Massimo: " + max + "; Minimo: " + min;
			}
		} else {
			outputElement.innerHTML = "Impossibile effettuare l'operazione richiesta.<br />";
			outputElement.innerHTML += "Errore riscontrato: " + xhr.statusText;
		}
	}

}



function asyncRequestIFrame(uri, outputElement) {
	outputElement.innerHTML = '<iframe src="' + uri + '" width="50%" height="50px">Il tuo browser non supporta gli iframe</iframe>';
}



function asyncRequestAJAX(xhr, uri, matr, outputElement) {
	xhr.onreadystatechange = function() { asyncRequestCallback(xhr, outputElement); };

	try {
		xhr.open("post", uri, true);
	} catch(e) { alert(e); }

	xhr.setRequestHeader("Content-Type", "application/json"); // specifica tipo dati JSON nel body
	
	xhr.send(JSON.stringify(matr)); // inserimento matrice nel body
}



function asyncRequest(uri, nElement, matriceElement, outputElement) {
	var n = nElement.value;
	
	if (isNaN(n)) {
		outputElement.innerHTML = "La lunghezza n deve essere un numero";
	} else {
		// suddivisione matrici
		var matrice = JSON.parse(matriceElement);

		var matr1;
		var matr2;
		if (n%2 == 0) {
			// n pari -> n/2 e n/2
			for (var row = 0; row < n/2; row++) {
				for (var col = 0; col < n; col++) {
					matr1[row][col] = matrice[row][col];
				}
			}
			for (; row < n; row++) {
				for (var col = 0; col < n; col++) {
					matr2[row][col] = matrice[row][col];
				}
			}
		} else {
			// n dispari -> n/2 + 1 e n/2
			for (var row = 0; row < n/2 + 1; row++) {
				for (var col = 0; col < n; col++) {
					matr1[row][col] = matrice[row][col];
				}
			}
			for (; row < n; row++) {
				for (var col = 0; col < n; col++) {
					matr2[row][col] = matrice[row][col];
				}
			}
		}
		
		// richieste di calcolo
		var xhr = myGetXmlHttpRequest();
		if (xhr) {
			numResults = 0;
			asyncRequestAJAX(xhr, uri, matr1, outputElement);
			asyncRequestAJAX(xhr, uri, matr2, outputElement);
		} else asyncRequestIFrame(uri, outputElement);
	}
}