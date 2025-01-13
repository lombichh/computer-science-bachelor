// conta parole con fs
const http = require("http");
const url = require("url");
const querystring = require("querystring");
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
	const params = querystring.parse(url.parse(req.url).query);
	if (!params["word"]) {
		res.end("Errore: nessun parametro word passato nella query");
		return;
	}
	const word = params["word"];

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
    "	<body>";
	
	var counter = 0;
	
	rl.on("line", (currentLine) => {
		for (var currentWord of currentLine.split(" ")) {
			if (currentWord === word) counter++;
		}
	});
	
	rl.on("close", () => {
		if (counter > 5) {
			// remove words
			rl = readline.createInterface({
				input: fs.createReadStream(filename),
				output: process.stout,
				terminal: false
			});
			var output = "";
			var startOfFile = true;
			rl.on("line", (currentLine) => {
				if (startOfFile) startOfFile = false;
				else output += "\n";
				
				var startOfLine = true;
				for (var currentWord of currentLine.split(" ")) {
					if (currentWord == word+",") {
						output += ",";
					} else if (currentWord != word) {
						if (startOfLine) {
							output += currentWord;
							startOfLine = false;
						} else output += " " + currentWord;
					}
				}
			});
			rl.on("close", () => {
				var writableStreamEvent = fs.createWriteStream(filename);
				writableStreamEvent.on('finish', function () {
					html += "<label>Numero di parole: <input type='text' disabled='disabled' value='"+counter+"'></label></br>";

					html += "</body>"+
					"</html>"
						
					res.write(html);
					res.end();
				});
				writableStreamEvent.write(output);
				writableStreamEvent.end();
			});
		} else {
			html += "<label>Numero di parole: <input type='text' disabled='disabled' value='"+counter+"'></label></br>";

			html += "</body>"+
			"</html>"
				
			res.write(html);
			res.end();
		}
	});
	
	rl.on("error", (error) => {
		// gestisci errore
	});
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});