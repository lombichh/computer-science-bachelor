function isValidVotes(votes) {
	for (const vote of votes) {
		if (vote < 18 || vote > 33) return false;
	}
	return true;
}

function Statistica(votes) {
	this.votes = votes;
	
	this.min = function() {
		var min = 33;
		for (const vote of this.votes) {
			if (vote < min) min = vote;
		}
		return min;
	}
	
	this.max = function() {
		var max = 18;
		for (const vote of this.votes) {
			if (vote > max) max = vote;
		}
		return max;
	}
	
	this.avg = function() {
		var sum = 0;
		for (const vote of this.votes) sum += vote;
		var avg = sum/votes.length;
		return avg; // check if is float
	}
	
	this.var = function() {
		var varsum = 0;
		for (const vote of this.votes) {
			varsum += (vote-this.avg())**2;
		}
		varsum = varsum/votes.length;
		
		return Math.sqrt(varsum);
	}
	
	this.print = function(output) {
		output.innerHTML = "voti: " + this.votes
			+ "<br>minimo: " + this.min()
			+ "<br>massimo: " + this.max()
			+ "<br>media: " + this.avg().toFixed(2)
			+ "<br>variabilità: " + this.var().toFixed(2)
	}
}

const votesText = prompt("Inserisci una sequenza di voti tra 18 e 33");

var output = document.getElementById("output");
if (votesText != null) {
	const votes = votesText.split(",");
	for (var i = 0; i < votes.length; i++) {
		votes[i] = parseInt(votes[i]);
	}
	
	if (isValidVotes(votes)) {
		var statistica = new Statistica(votes);
		statistica.print(output);
	} else output.innerHTML = "I voti inseriti non sono validi";
} else {
	output.innerHTML = "Voti non inseriti";
}