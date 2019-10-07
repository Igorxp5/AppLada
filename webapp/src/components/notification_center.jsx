import React from 'react'
import ErrorNotification from './error_notification'

class NotificationCenter extends React.Component {
	
	constructor() {
		super();
		this.state = {
			notifications: []
		}
	}

	newAlert(text, timeout) {
		this.setState((state) => ({
			notifications: [...state.notifications, {text: text, timeout: timeout}]
		}));
	}

	render() {
		return(
	        <div className='notification-region'>
	        	{
                    this.state.notifications.map((notification) => (
                        <ErrorNotification key={notification.text} text={notification.text} timeout={notification.timeout}/>
                    ))
                }
	        </div>
	    )
	}
}

export default NotificationCenter;