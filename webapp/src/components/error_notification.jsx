import React from 'react'
import ReactDOM from 'react-dom';
import './../style/error_notification.css'

class ErrorNotification extends React.Component {
	constructor(props) {
		super();
		this.state = {
			showing: '',
			timeout: props.timeout || 10000,
			closingTimeout: null
		}

		let closingTimeout = setTimeout(() => {
			this.close();
		}, this.state.timeout, this);
		this.state.closingTimeout = closingTimeout;

		this.show();
	}

	show = function() {
		setTimeout(() => {
			this.setState({showing: 'show'});
		}, 300, this);
	}

	close = function() {
		clearTimeout(this.state.closingTimeout);
		this.setState({
            showing: ''
        });
		setTimeout(() => {
            this.element.remove();
        }, 1000);
	}

	render() {
		return(
	        <div className={'error-notification ' + this.state.showing} 
	        	 onClick={this.close.bind(this)} ref={(element) => { this.element = element }}>
	            <i className="error-notification-icon fas fa-exclamation-circle"></i> 
	            <span className='error-notification-text'>{this.props.text}</span>
	        </div>
	    )
	}
}

export default ErrorNotification;