'use strict';

class Gioco extends React.Component {
	constructor(props) {
		super(props);
		
		this.onClickCella = this.onClickCella.bind(this);
	}
	
	onClickCella(event) {
		var coordinate = event.target.id.split("-");
		this.props.turnoGiocatore(coordinate[0], coordinate[1]);
	}
	
	render() {
		var matriceHtml = [];
		
		for (var riga = 0; riga < 3; riga++) {
			for (var colonna = 0; colonna < 3; colonna++) {
				if (this.props.matrice[riga][colonna] == 0) {
					if (this.props.turno == 1) {
						matriceHtml.push(
							<div style={{ display: 'inline-block', width: '50px', height: '50px', backgroundColor: 'grey' }}></div>
						);
					} else {
						// mio turno -> clickabile
						matriceHtml.push(
							<div id={riga+"-"+colonna} onClick={this.onClickCella} style={{ display: 'inline-block', width: '50px', height: '50px', backgroundColor: 'grey' }}></div>
						);
					}
				} else if (this.props.matrice[riga][colonna] == 1) {
					matriceHtml.push(
						<div style={{ display: 'inline-block', width: '50px', height: '50px', backgroundColor: 'grey' }}>O</div>
					);
				} else if (this.props.matrice[riga][colonna] == 2) {
					matriceHtml.push(
						<div style={{ display: 'inline-block', width: '50px', height: '50px', backgroundColor: 'grey' }}>X</div>
					);
				}
			}
			matriceHtml.push(<br/>);
		}
			
    	return (
	        <div>
				{matriceHtml}
	        </div>
        );
	}
}