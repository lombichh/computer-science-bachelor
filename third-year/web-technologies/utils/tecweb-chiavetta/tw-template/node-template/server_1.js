// conta parole con fs
const http = require("http");
const fs = require("fs");

const hostname = "127.0.0.1";
const port = 3000;

const server = http.createServer((req, res) => {
	res.statusCode = 200;
	//res.setHeader("Content-Type", "text/plain");
	res.setHeader("Content-Type", "text/html");
	
	var html = "<!DOCTYPE html>"+
    "<html>"+
    "	<head>"+
    "		<meta charset='utf-8' />"+
    "		<title>App name</title>"+
    "	</head>"+
    "	<body>";
	
	const fileName = "myFile.txt";
	fs.readFile(fileName, (error, dataBuffer) => {
		if (error) {
			console.log("Errore nella lettura del file");
		} else {
			var words = 0;
			const lines = dataBuffer.toString().split("\n");
			for (var line of lines) {
				for (var word of line.split(" ")) {
					if (word != "")
						words++;
				}
			}
			
			html += "<label>Numero di parole nel file "+fileName+": <input type='text' disabled='disabled' value='"+words+"'></label>";
		}
		
		html += "</body>"+
		"</html>"
			
		res.write(html);
		res.end();
	});
});

server.listen(port, hostname, () => {
  console.log("Server running at http://${hostname}:${port}/");
});