'use strict';

class Display extends React.Component {
	constructor(props) {
		super(props);
		
		this.onClickDelete = this.onClickDelete.bind(this);
	}
	
	onClickDelete(event) {
		this.props.delete(event.target.id);
	}
	
    render() {
		var listaRicercaHtml = [];

		for (var i = 0; i < this.props.listaRicerca.length; i++) {
			listaRicercaHtml.push(
				<div>
					<span>{this.props.listaRicerca[i].nome}, {this.props.listaRicerca[i].numtel}</span>
					<button id={i} onClick={this.onClickDelete}>Rimuovi</button>
					<br/>
				</div>
			);
		}
			
    	return (
	        <div>
				{listaRicercaHtml}
	        </div>
        );
    }
}