import React from 'react'
import NavBar from './../components/navbar'


class Dashboard extends React.Component {
    componentDidMount() {
        document.title = 'Dashboard - AppLada'
    }
    
    render() {
        return(
            <NavBar />
        )
    }
}

export default Dashboard;