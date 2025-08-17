'use strict';

class Classifica extends React.Component {
    render() {
		var classifica = [];
		
		if (this.props.garaFinita) {
			for (var i = 0; i < this.props.classifica.length; i++) {
				classifica.push(<p>- {i + 1}: {this.props.classifica[i]}</p>);
			}
		}
			
    	return (
	        <div>
				{classifica}
				<button reset={this.props.reset}>Reset</button>
	        </div>
        );
    }
}
