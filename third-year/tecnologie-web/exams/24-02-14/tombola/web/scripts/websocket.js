const webSocket = new WebSocket("ws://localhost:8080/tombola/actions");

webSocket.onmessage = function(event) {
	const response = JSON.parse(event.data);
	
	if (response.type == 1) {
		// richiesta partecipazione -> stampa risultato
		myGetElementById("tombolaOutput").innerHTML = "Risultato partecipazione: " + response.value;
	} else if (response.type == 2) {
		// numero tombola -> stampa numero
		myGetElementById("tombolaOutput").innerHTML = "Numero estratto: " + response.value;
	} else if (response.type == 3) {
		// messaggio push -> stampa messaggio
		myGetElementById("outputMessaggioAdmin").innerHTML = "Messaggio push: " + response.value;
	}
}

function partecipaTombola() {
	const request = {type: 1};
	webSocket.send(JSON.stringify(request));
}

function segnalaTombola() {
	const request = {type: 2};
	webSocket.send(JSON.stringify(request));
}

function ritiro() {
	const request = {type: 3};
	webSocket.send(JSON.stringify(request));
}

function messaggioPush() {
	const request = {type: 4};
	webSocket.send(JSON.stringify(request));
}