import React from 'react'
import NavBar from './../components/navbar'
import Jogar from './../components/Jogar'
import { BrowserRouter as Router, Route } from "react-router-dom"
import './../style/dashboard/dashboard.css'


class Dashboard extends React.Component {
    componentDidMount() {
        document.title = 'Dashboard - AppLada'
    }
    
    render() {
        return(
            <div>
                <Router>     
                    <NavBar />        
                    <div id='dashboard-body'> 
                        <Route path="/dashboard" component={ Jogar }/>
                    </div>
                </Router>
                
            </div>
        )
    }
}

export default Dashboard;