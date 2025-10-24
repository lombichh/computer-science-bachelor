const webSocket = new WebSocket("ws://localhost:8080/08b_TecWeb/actions");

webSocket.onmessage = function(event) {
	if (event.data.includes("operand")) {
		const updateOperand = JSON.parse(event.data);
		if (updateOperand.operand == 1) {
			myGetElementById("num1").value = updateOperand.num;
		} else if (updateOperand.operand == 2) {
			myGetElementById("num2").value = updateOperand.num;
		}
	} else {
		const operationResp = JSON.parse(event.data);
		if (operationResp.valid) {
			myGetElementById("result").innerHTML = operationResp.result;
		} else {
			myGetElementById("result").innerHTML = "reached requests limit";
		}
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

function updateOperand(operand, num) {
	const updateOperand = {
		operand: operand,
		num: num
	};
	webSocket.send(JSON.stringify(updateOperand));
}