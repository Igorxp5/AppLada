import React from 'react'
import Utils from './utils'
import './../style/dashboard/navbar.css'
import { Link } from 'react-router-dom'

class NavBar extends React.Component {

    state = {
        current: 'jogar',
        allPages: ['jogar', 'perfil', 'feed', 'times', 'torneios'],
        user: {
            name: 'Igor',
            level: '45'
        }
    }

    setCurrentPage = page => {
        this.setState({
            current: page
        })
    }

    componentDidMount() {
        let page = document.getElementById(this.state.current)
        page.style.color = 'white'
        page.style.borderBottom = '3px solid white'
    }

    componentDidUpdate() {
        let page = document.getElementById(this.state.current)
        page.style.color = 'white'
        page.style.borderBottom = '3px solid white'
        this.state.allPages.map(el => {
            if (this.state.current !== el) {
                let notCurrent = document.getElementById(el)
                notCurrent.style.color = 'grey'
                notCurrent.style.borderBottom = 'none'
            }
            return null
        })
    }

    render() {
        return (
            <nav id='dashboard-navbar'>
                <div id='dashboard-navbar-perfil'>
                    <img src='./../../images/user_Avatar.png' alt='user' />
                    <span>
                        <label>{this.state.user.name}<br></br>
                        <i className="fas fa-star" style={{color: 'yellow', marginTop: '10px'}}></i> {this.state.user.level}
                        </label>
                    </span>
                </div>
                <div id='dashboard-navbar-menu'>
                    <ul>
                        <li onClick={() => {this.setCurrentPage('jogar')}}><Link id='jogar' to='/dashboard'>JOGAR</Link></li>
                        <li onClick={() => {this.setCurrentPage('perfil')}}><Link id='perfil' to='/dashboard/perfil'>PERFIL</Link></li>
                        <li onClick={() => {this.setCurrentPage('feed')}}><Link id='feed' to='/dashboard/feed'>FEED</Link></li>
                        <li onClick={() => {this.setCurrentPage('times')}}><Link id='times' to='/dashboard/times'>TIMES</Link></li>
                        <li onClick={() => {this.setCurrentPage('torneios')}}><Link id='torneios' to='/dashboard/torneios'>TORNEIOS</Link></li>
                    </ul>
                </div>
                <div id='dashboard-navbar-simbolos'>
                    <i className="fas fa-cog"></i>
                    <i className="fas fa-sign-out-alt"></i>                    
                </div>
            </nav>
        )
    }
}

export default NavBar;