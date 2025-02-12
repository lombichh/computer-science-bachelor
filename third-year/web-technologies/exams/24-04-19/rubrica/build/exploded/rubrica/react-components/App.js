'use strict';

class App extends React.Component {
	constructor(props) {
		super(props);
		
		// state
		this.state = {
			listaRicerca: []
		};
		
		// inizializzazione rubrica
		this.listaRubrica = [];
		this.listaRubrica[0] = {nome: "nome1", numtel: "numtel1"};
		this.listaRubrica[1] = {nome: "nome2", numtel: "numtel2"};
		this.listaRubrica[2] = {nome: "nome3", numtel: "numtel3"};
		this.listaRubrica[3] = {nome: "nome4", numtel: "numtel4"};
		this.listaRubrica[4] = {nome: "nome5", numtel: "numtel5"};
		this.listaRubrica[5] = {nome: "nome6", numtel: "numtel6"};
		this.listaRubrica[6] = {nome: "nome7", numtel: "numtel7"};
		this.listaRubrica[7] = {nome: "nome8", numtel: "numtel8"};
		this.listaRubrica[8] = {nome: "nome9", numtel: "numtel9"};
		this.listaRubrica[9] = {nome: "nome10", numtel: "numtel10"};

		// this
		this.search = this.search.bind(this);
		this.delete = this.delete.bind(this);
		this.add = this.add.bind(this);
	}
	
	search(nome) {
		var newListaRicerca = [];
		
		for (var i = 0; i < this.listaRubrica.length; i++) {
			if (this.listaRubrica[i].nome.startsWith(nome))
				newListaRicerca[newListaRicerca.length] = this.listaRubrica[i];
		}
		
		this.setState({
		  listaRicerca: newListaRicerca
		});
	}
	
	removeFromList(list, index) {
		for (var i = index; i < list.length - 1; i++) {
			list[i] = list[i + 1];
		}
		list[list.length - 1] = null;
	}
	
	delete(ricercaIndex) {
		var newListaRubrica = [];
		
		for (var i = 0; i < this.listaRubrica.length; i++) {
			if (this.listaRubrica[i].nome !== this.state.listaRicerca[ricercaIndex].nome) {
				newListaRubrica[newListaRubrica.length] = this.listaRubrica[i];
			}
		}
		
		this.listaRubrica = newListaRubrica;
	}
	
	add(nome, numtel) {
		var found = false;
		for (var i = 0; i < this.listaRubrica.length; i++) {
			if (this.listaRubrica[i].nome === nome) {
				this.listaRubrica[i] = {nome: nome, numtel: numtel};
				found = true;
			}
		}
		
		if (found == false) this.listaRubrica[this.listaRubrica.length] = {nome: nome, numtel: numtel};
	}
	
	render() {
		return(
			<div>
	            <h1>Rubrica</h1>
				<Ricerca search={this.search}/>
				<Display listaRicerca={this.state.listaRicerca} delete={this.delete}/>
				<Aggiunta listaRubrica={this.listaRubrica} add={this.add}/>
			</div>
		);
	}
}