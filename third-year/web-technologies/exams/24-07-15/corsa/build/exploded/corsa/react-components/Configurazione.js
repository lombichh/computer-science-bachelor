'use strict';

class Configurazione extends React.Component {
	constructor(props) {
		super(props);
		
		this.state = { numCorridori: 0 };
		
		this.changeNum = this.changeNum.bind(this);
		this.onClick = this.onClick.bind(this);
	}
	  
	changeNum(event) {
		this.state.numCorridori = event.target.value;
	}
	
	onClick() {
		this.props.start(this.state.numCorridori);
	}
	
    render() {
	    return (
			<div>
				Numero corridori: <input type="text" onChange={this.changeNum}/>
				<button onClick={this.onClick}>Inizia gara</button>
			</div>
	    );
    }
}