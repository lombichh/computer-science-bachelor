'use strict';

class Punteggio extends React.Component {
	render() {
    	return (
	        <div>
				Pareggi: {this.props.punteggio[0]}, Vittore O: {this.props.punteggio[1]}, Vittore X: {this.props.punteggio[2]}
	        </div>
        );
	}
}