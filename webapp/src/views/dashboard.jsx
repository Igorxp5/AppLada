import React from 'react'
import NavBar from './../components/navbar'
import Jogar from './../components/Jogar'
import Perfil from './../components/perfil'
import Feed from './../components/feed'
import Times from './../components/times'
import Torneios from './../components/torneios'
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
                        <Route exact path="/dashboard" component={ Jogar }/>
                        <Route path='/dashboard/perfil' component={ Perfil }/>
                        <Route path='/dashboard/feed' component={ Feed }/>
                        <Route path='/dashboard/times' component={ Times }/>
                        <Route path='/dashboard/torneios' component={ Torneios }/>
                    </div>
                </Router>
                
            </div>
        )
    }
}

export default Dashboard;