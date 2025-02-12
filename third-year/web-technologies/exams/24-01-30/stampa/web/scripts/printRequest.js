function numNomiFileChange() {
	const numNomiFile = myGetElementById("numNomiFile").value;
	
	const nomeFile2 = myGetElementById("nomeFile2");
	const nomeFile3 = myGetElementById("nomeFile3");
	const nomeFile4 = myGetElementById("nomeFile4");
	
	if (numNomiFile == 1) {
		nomeFile2.style.display = "none";
		nomeFile3.style.display = "none";
		nomeFile4.style.display = "none";
	} else if (numNomiFile == 2) {
		nomeFile2.style.display = "block";
		nomeFile3.style.display = "none";
		nomeFile4.style.display = "none";
	} else if (numNomiFile == 3) {
		nomeFile2.style.display = "block";
		nomeFile3.style.display = "block";
		nomeFile4.style.display = "none";
	} else if (numNomiFile == 4) {
		nomeFile2.style.display = "block";
		nomeFile3.style.display = "block";
		nomeFile4.style.display = "block";
	}
}

function printRequest() {
	const nomeFile1 = myGetElementById("nomeFile1").value;
	const nomeFile2 = myGetElementById("nomeFile2").value;
	const nomeFile3 = myGetElementById("nomeFile3").value;
	const nomeFile4 = myGetElementById("nomeFile4").value;
	
	if (nomeFile1.endsWith(".txt") && nomeFile2.endsWith(".txt")
		&& nomeFile3.endsWith(".txt") && nomeFile4.endsWith(".txt")) {
		// nomi file validi -> invia richiesta di stampa
		myGetElementById("printForm").submit();
	}
}