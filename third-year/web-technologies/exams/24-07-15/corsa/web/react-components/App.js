'use strict';

class App extends React.Component {
	constructor(props) {
		super(props);
		
		this.state = {
			posCorridori: [1, 2, 3, 4, 2],
			garaFinita: false
		};
		
		this.numCorridori = 5;
		this.colorCorridori = [];
		this.numCorridoriTraguardo = 0;
		this.posCorrente = 0;
		this.classifica = {};
		
		this.start = this.start.bind(this);
		this.reset = this.reset.bind(this);
	}
	
	progredisci() {
		var indiceParimerito = 0;
		for (var i = 0; i < this.numCorridori; i++) {
			if (this.state.posCorridori[i] < 10) {
				// corridore non ancora al traguardo -> progredisci
				this.state.posCorridori[i] += Math.floor(Math.random() * 3) + 1;
				if (this.state.posCorridori[i] >= 10) {
					// corridore ha raggiunto il traguardo -> aggiungi alla classifica
					this.numCorridoriTraguardo++;
					this.classifica[this.posCorrente][indiceParimerito] = i + 1;
					indiceParimerito++;
				}
			}
		}
		
		if (this.numCorridoriTraguardo == this.numCorridori) {
			// tutti i corridori al traguardo -> termina
			clearInterval(this.corsa);
			this.state.garaFinita = true;
		}
	}
	
	start(numCorridori) {
		// num corridori valido -> start
		this.numCorridori = numCorridori;
		
		// inizializza posizioni
		for (var i = 0; i < this.numCorridori; i++) {
			this.state.posCorridori[i] = 1;
			this.colorCorridori[i] = "red";
		}
		
		// inzia corsa
		this.corsa = setInterval(progredisci, 4000);
	}
	
	reset() {
		clearInterval(this.corsa);
		
		this.state = {
			posCorridori: [],
			garaFinita: false
		};

		this.numCorridori = 0;
		this.colorCorridori = [];
		this.numCorridoriTraguardo = 0;
		this.classifica = {};
	}
	
	render() {
		return(
			<div>
	            <h1>Corsa</h1>
				<Configurazione start={this.start}/>
				<Pista posCorridori={this.state.posCorridori} colorCorridori={this.colorCorridori}/>
				<Classifica garaFinita={this.state.garaFinita} classifica={this.classifica} reset={this.reset}/>
			</div>
		);
	}
}