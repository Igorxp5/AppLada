import React from 'react'
import Notification from './notification'

class NotificationCenter extends React.Component {
	
	constructor() {
		super();
		this.state = {
			notifications: []
		}
	}

	errorAlert(text, timeout) {
		this.setState((state) => ({
			notifications: [...state.notifications, {text: text, timeout: timeout, type: 'error'}]
		}));
	}

	successAlert(text, timeout) {
		this.setState((state) => ({
			notifications: [...state.notifications, {text: text, timeout: timeout, type: 'success'}]
		}));
	}

	render() {
		return(
	        <div className='notification-region'>
	        	{
                    this.state.notifications.map((notification) => (
                        <Notification key={notification.text} text={notification.text} timeout={notification.timeout} type={notification.type}/>
                    ))
                }
	        </div>
	    )
	}
}

export default NotificationCenter;