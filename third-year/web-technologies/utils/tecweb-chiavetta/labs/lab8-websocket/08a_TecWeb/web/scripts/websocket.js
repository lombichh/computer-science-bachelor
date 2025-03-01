const webSocket = new WebSocket("ws://localhost:8080/08a_TecWeb/actions");

webSocket.onmessage = function(event) {
	const operationResp = JSON.parse(event.data);
	if (operationResp.valid) {
		myGetElementById("result").innerHTML = operationResp.result;
	} else {
		myGetElementById("result").innerHTML = "reached requests limit";
	}
}

function calculateOperationResult(num1, num2, op) {
	if (isNaN(num1) || isNaN(num2)) myGetElementById("result").innerHTML = "error";
	else {
		const operationReq = {
			num1: num1,
			num2: num2,
			op: op	
		};
		webSocket.send(JSON.stringify(operationReq));
	}
}