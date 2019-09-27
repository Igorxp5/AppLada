import React from 'react'
import { BrowserRouter as Router, Route, Link } from "react-router-dom"
import './../style/home.css'
import Login from './../components/login'
import Cadastro from './../components/cadastro'

class Home extends React.Component {
    render() {
        return(
            <div className='home-container'>
                <div className='home-left'></div>
                <div className='home-right'>
                    <Router>
                        <ul className='home-navbar'>
                            <li>
                                <Link to='/login'>Login</Link>
                            </li>
                            <li>
                                <Link to='/cadastro'>Cadastro</Link>
                            </li>
                        </ul>
                        <div className='form-container'>
                            
                                <Route  exact path='/login' component={ Login }/>
                                <Route exact path='/cadastro' component={ Cadastro }/>
                            
                        </div>
                    </Router>
                </div>
            </div>
        )
    }
}

export default Home;