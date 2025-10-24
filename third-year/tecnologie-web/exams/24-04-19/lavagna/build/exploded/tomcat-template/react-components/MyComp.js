'use strict';

class MyComp extends React.Component {
	constructor(props) {
		super(props);
		
		this.state = {
			key1: "value1",
			key2: 10
		};
		
		this.onClick = this.onClick.bind(this); // bind del contesto this al metodo onClick
	}
	
	onClick(event) {
        event.target; // oggetto che ha scatenato l'onClick, posso richiamarne le proprietà
		
		reactAsyncRequest(
			'./myServlet',
			this.state.key1,
			(result) => {
				this.setState({
					key1: result
				}); // aggiornare lo stato (richiama automaticamente render)
			}
		); // richiesta AJAX
	};
	
	render() {
		return(
			<button onClick={this.onClick}>{this.state.key1}</button>
		);
	}
}