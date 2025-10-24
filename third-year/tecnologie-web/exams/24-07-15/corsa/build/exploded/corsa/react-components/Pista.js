'use strict';

class Pista extends React.Component {
    render() {
		var pista = [];

		for (var i = 0; i < this.props.posCorridori.length; i++) {
			for (var j = 1; j <= 11; j++) {
				if (j == this.props.posCorridori[i]) pista.push(<div style={{ display: 'inline-block', width: '50px', height: '25px', backgroundColor: 'red' }}></div>);
				else pista.push(<div style={{ display: 'inline-block', width: '50px', height: '25px', backgroundColor: 'grey' }}></div>);
			}
			pista.push(<br/>);
		}
			
    	return (
	        <div>
				{pista}
	        </div>
        );
    }
}