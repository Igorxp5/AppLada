import React from 'react'
import Page from './page'


class Dashboard extends Page {
    componentDidMount() {
        document.title = 'Login - AppLada'
    }
    
    render() {
    	let style = {
			color: '#FFFFFF',
			fontSize: '4em',
			textShadow: '0 0 5px rgba(0, 0, 0, 0.3)'
		}
        return(
            <h1 style={style}>VOCÊ ENTROU</h1>
        )
    }
}

export default Dashboard;