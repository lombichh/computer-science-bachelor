'use strict';

class Ricerca extends React.Component {
	constructor(props) {
		super(props);
		
		this.nome = "";
		
		this.onChangeNome = this.onChangeNome.bind(this);
		this.onClickSearch = this.onClickSearch.bind(this);
	}
	
	onChangeNome(event) {
		this.nome = event.target.value;
	}
	
	onClickSearch(event) {
		this.props.search(this.nome);
	}
	
    render() {
	    return (
			<div>
				<input type="text" onChange={this.onChangeNome}/>
				<button onClick={this.onClickSearch}>Ricerca</button>
			</div>
	    );
    }
}