'use strict';

class App extends React.Component {
	constructor(props) {
		super(props);
		
		// state
		this.state = {
			matrice: [[0, 0, 0], [0, 0, 0], [0, 0, 0]], // 0 -> undefined, 1 -> O, 2 -> X
			turno: 1, // 1 -> O, 2 -> X
			celleVincitrici: [[-1, -1], [-1, -1], [-1, -1]],
			punteggio: [0, 0, 0] // [pareggi, vittorie 1, vittorie 2]
		};

		// this
		this.inizia = this.inizia.bind(this);
		
		this.inizia();
	}
	
	controllaTris() {
		var vincitore = -1;
		
		// TODO: cambia celle vincitrici
		
		// controlla vittoria
		if (this.state.matrice[0][0] != 0
			&& this.state.matrice[0][0] == this.state.matrice[0][1]
			&& this.state.matrice[0][1] == this.state.matrice[0][2]) {
			if (this.state.matrice[0][0] == 1) vincitore = 1;
			else vincitore = 2;
				
			this.setState({
				celleVincitrici: [[0, 0], [0, 1], [0, 2]]
			});
		}
		else if (this.state.matrice[1][0] != 0
			&& this.state.matrice[1][0] == this.state.matrice[1][1]
			&& this.state.matrice[1][1] == this.state.matrice[1][2]) {
			if (this.state.matrice[0][0] == 1) vincitore = 1;
			else vincitore = 2;
			
			this.setState({
				celleVincitrici: [[0, 0], [0, 1], [0, 2]]
			});
		}
		else if (this.state.matrice[2][0] != 0
			&& this.state.matrice[2][0] == this.state.matrice[2][1]
			&& this.state.matrice[2][1] == this.state.matrice[2][2]) {
			if (this.state.matrice[0][0] == 1) vincitore = 1;
			else vincitore = 2;
			
			if (this.state.matrice[0][0] == 1) vincitore = 1;
			else vincitore = 2;
		}
		else if (this.state.matrice[0][0] != 0
			&& this.state.matrice[0][0] == this.state.matrice[1][0]
			&& this.state.matrice[1][0] == this.state.matrice[2][0]) {
			if (this.state.matrice[0][0] == 1) vincitore = 1;
			else vincitore = 2;
			
			this.setState({
				celleVincitrici: [[0, 0], [0, 1], [0, 2]]
			});
		}
		else if (this.state.matrice[0][1] != 0
			&& this.state.matrice[0][1] == this.state.matrice[1][1]
			&& this.state.matrice[1][1] == this.state.matrice[2][1]) {
			if (this.state.matrice[0][0] == 1) vincitore = 1;
			else vincitore = 2;
			
			this.setState({
				celleVincitrici: [[0, 0], [0, 1], [0, 2]]
			});
		}
		else if (this.state.matrice[0][2] != 0
			&& this.state.matrice[0][2] == this.state.matrice[1][2]
			&& this.state.matrice[1][2] == this.state.matrice[2][2]) {
			if (this.state.matrice[0][0] == 1) vincitore = 1;
			else vincitore = 2;
			
			this.setState({
				celleVincitrici: [[0, 0], [0, 1], [0, 2]]
			});
		}
		else if (this.state.matrice[0][0] != 0
			&& this.state.matrice[0][0] == this.state.matrice[1][1]
			&& this.state.matrice[1][1] == this.state.matrice[2][2]) {
			if (this.state.matrice[0][0] == 1) vincitore = 1;
			else vincitore = 2;
			
			this.setState({
				celleVincitrici: [[0, 0], [0, 1], [0, 2]]
			});
		}
		else if (this.state.matrice[0][2] != 0
			&& this.state.matrice[0][2] == this.state.matrice[1][1]
			&& this.state.matrice[1][1] == this.state.matrice[2][0]) {
			if (this.state.matrice[0][0] == 1) vincitore = 1;
			else vincitore = 2;
			
			this.setState({
				celleVincitrici: [[0, 0], [0, 1], [0, 2]]
			});
		}
		
		if (vincitore == -1) {
			// controlla pareggio
			for (var riga = 0; riga < 3; riga++) {
				for (var colonna = 0; colonna < 3; colonna++) {
					if (this.state.matrice[riga][colonna] != 0) {
						vincitore = 0;
						break;
					}
				}
			}
		}
		
		if (vincitore == 0) {
			this.setState({
				punteggio: [this.state.punteggio[0] + 1, this.state.punteggio[1], this.state.punteggio[2]]
			});
			alert("Pareggio");
		} else if (vincitore == 1) {
			this.setState({
				punteggio: [this.state.punteggio[0], this.state.punteggio[1] + 1, this.state.punteggio[2]]
			});
			alert("Ha vinto il giocatore 1");
		} else if (vincitore == 2) {
			this.setState({
				punteggio: [this.state.punteggio[0], this.state.punteggio[1], this.state.punteggio[2] + 1]
			});
			alert("Ha vinto il giocatore 2");
		} else {
			// continua gioco
			if (this.state.turno == 1) {
				this.setState({
					turno: 2 // giocatore
				});
			} else {
				this.setState({
					turno: 1 // calcolatore
				});
				this.turnoCalcolatore();
			}
		}
	}
	
	turnoCalcolatore() {
		var interval = setInterval(() => {
			var riga = Math.floor(Math.random() * 3);
			var colonna = Math.floor(Math.random() * 3);
			
			while (this.state.matrice[riga][colonna] != 0) {
				riga = Math.floor(Math.random() * 3);
				colonna = Math.floor(Math.random() * 3);
			}
			
			var nuovaMatrice = this.state.matrice;
			nuovaMatrice[riga][colonna] = 1;
			
			this.setState({
				matrice: nuovaMatrice
			});

			clearInterval(interval);
			
			this.controllaTris();
		}, 3000);
	}
	
	turnoGiocatore(riga, colonna) {
		var nuovaMatrice = this.state.matrice;
		nuovaMatrice[riga][colonna] = 2;
		
		this.setState({
			matrice: nuovaMatrice
		});
		
		controllaTris();
	}
	
	inizia() {
		this.setState({
			matrice: [[0, 0, 0], [0, 0, 0], [0, 0, 0]],
			celleVincitrici: [[-1, -1], [-1, -1], [-1, -1]],
			turno: 1
		});
		
		this.turnoCalcolatore();
	}
	
	render() {
		return(
			<div>
	            <h1>Tris</h1>
				<Gioco matrice={this.state.matrice} turno={this.state.turno} celleVincitrici={this.state.celleVincitrici} turnoGiocatore={this.turnoGiocatore}/>
				<Punteggio punteggio={this.state.punteggio}/>
			</div>
		);
	}
}