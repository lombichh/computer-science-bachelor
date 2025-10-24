'use strict';

class Aggiunta extends React.Component {
	constructor(props) {
		super(props);
		
		this.state = { conferma: false };
		
		this.nome = "";
		this.numtel = "";
		
		this.onChangeNome = this.onChangeNome.bind(this);
		this.onChangeNumtel = this.onChangeNumtel.bind(this);
		this.onClickAdd = this.onClickAdd.bind(this);
		this.onClickSovrascrivi = this.onClickSovrascrivi.bind(this);
	}
	
	onChangeNome(event) {
		this.nome = event.target.value;
	}
	
	onChangeNumtel(event) {
		this.numtel = event.target.value;
	}
	
	onClickAdd(event) {
		var found = false;
		for (var i = 0; i < this.props.listaRubrica.length; i++) {
			if (this.props.listaRubrica[i].nome === this.nome) {
				found = true;
				break;
			}
		}
		
		if (found) {
			this.setState({
				conferma: true
			});
		} else this.props.add(this.nome, this.numtel);
	}
	
	onClickSovrascrivi(event) {
		this.setState({
			conferma: false
		});
		this.props.add(this.nome, this.numtel);
	}
	
    render() {
		if (this.state.conferma) {
			return (
				<div>
					<span>è già presente un contatto con lo stesso nome, vuoi sovrascrivere?</span>
					<button onClick={this.onClickSovrascrivi}>Sovrascrivi</button>
				</div>
			);
		} else {
			return (
				<div>
					<input type="text" onChange={this.onChangeNome}/>
					<input type="text" onChange={this.onChangeNumtel}/>
					<button onClick={this.onClickAdd}>Aggiungi</button>
				</div>
		    );
		}
    }
}