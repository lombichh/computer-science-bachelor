const webSocket = new WebSocket("ws://localhost:8080/tomcat-template/actions");

webSocket.onmessage = function(event) {
	const myBean = JSON.parse(event.data);
	
	if (event.data.includes("value")) {
		myGetElementById("websocketOutput").innerHTML = myBean.value;
	} else {
		myGetElementById("websocketOutput").innerHTML = myBean.value;
	}
}

function websocketRequest() {
	var input = myGetElementById("websocketInput").value;
	
	if (isNaN(input)) myGetElementById("websocketOutput").innerHTML = "error";
	else {
		const myBean = {value: input}
		webSocket.send(JSON.stringify(myBean));
	}
}