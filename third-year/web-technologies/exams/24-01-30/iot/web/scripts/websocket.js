const webSocket = new WebSocket("ws://localhost:8080/iot/actions");

var interval;
var temps = [];

webSocket.onmessage = function(event) {
	if (event.data.includes("value")) {
		const averageTemp = JSON.parse(event.data);
		myGetElementById("iotOutput").innerHTML = "Average temp: " + averageTemp.value;
	} else {
		const comando = JSON.parse(event.data);
		clearInterval(interval);
		myGetElementById("iotOutput").innerHTML = "Dispositivo IoT interrotto";
	}
}

function inviaTemp() {
	const temp = Math.floor(Math.random() * (15 - 25 + 1)) + 15;
	
	temps[temps.length - 1] = temp;
	var sumTemps = 0;
	for (var i = 0; i < temps.length; i++) {
		sumTemps += temps[i];
	}
	const averageTemp = sumTemps/temps.length;
	
	const iotInfo = {temp: temp, averageTemp: averageTemp};
	webSocket.send(JSON.stringify(iotInfo));
}

function startIoT() {
	interval = setInterval(inviaTemp, 1000*60);
}

function inviaComando() {
	const sessionId = myGetElementById("sessionId").value;
	const comandoText = myGetElementById("comandoText").value;
	
	const comando = {sessionId: sessionId, comandoText: comandoText};
	webSocket.send(JSON.stringify(comando));
}