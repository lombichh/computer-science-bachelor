// conta parole con fs
const http = require("http");
const url = require("url");
const fs = require("fs");
const readline = require("readline");

const hostname = "127.0.0.1";
const port = 3000;

const server = http.createServer((req, res) => {
	res.statusCode = 200;
	//res.setHeader("Content-Type", "text/plain");
	res.setHeader("Content-Type", "text/html");
	
	const pathname = url.parse(req.url).pathname;
	const filename = pathname.substr(1, pathname.length);
	
	if (!filename){
		res.end("Errore: nessun file nell'url");
		return;
	}

	var rl = readline.createInterface({
		input: fs.createReadStream(filename),
		output: process.stout,
		terminal: false
	});
	
	var html = "<!DOCTYPE html>"+
    "<html>"+
    "	<head>"+
    "		<meta charset='utf-8' />"+
    "		<title>App name</title>"+
    "	</head>"+
    "	<body>"+
	"		<label>File richiesto: <input type='text' disabled='disabled' value='"+filename+"'></label></br>"
	
	var numLines = 0;
	var numTotWords = 0;
	var maxLine = -1;
	var maxWords = -1;
	
	rl.on("line", (line) => {
		numLines++;
		var numWords = 0;
		for (var word of line.split(" ")) {
			if (word != "") {
				numWords++;
				if (numWords > maxWords) {
					maxWords = numWords;
					maxLine = numLines;
				}
				numTotWords++;
			}
		}
		
		html += "<label>Numero di parole nella riga "+numLines+" : <input type='text' disabled='disabled' value='"+numWords+"'></label></br>";
	});
	
	rl.on("close", () => {
		html += "<label>Numero totale di righe: <input type='text' disabled='disabled' value='"+numLines+"'></label></br>";
		html += "<label>Numero totale di parole: <input type='text' disabled='disabled' value='"+numTotWords+"'></label></br>";
		html += "<label>La riga "+maxLine+" ha il maggior numero di parole: <input type='text' disabled='disabled' value='"+maxWords+"'></label></br>";

		html += "</body>"+
		"</html>"
			
		res.write(html);
		res.end();
	});
	
	rl.on("error", (error) => {
		// gestisci errore
	});
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});