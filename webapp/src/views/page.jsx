import React from 'react'

class Page extends React.Component {
	constructor(props) {
		super();
		this.state = {
			app: props.app
		}
	}

	getNotificationCenter() {
    	return this.state.app.getNotificationCenter();
    }
}

export default Page;