import React from 'react'
import Utils from './utils'
import './../style/dashboard/navbar.css'
import { Link } from 'react-router-dom'
import api from './../api/user'

class NavBar extends React.Component {

    state = {
        current: 'jogar',
        allPages: ['jogar', 'perfil', 'feed', 'times', 'torneios'],
        user: {
            name: null,
            level: null
        }
    }

    setCurrentPage = page => {
        this.setState({
            current: page
        })
    }

    componentDidMount() {
        let login = api.currentUserJwt().login;
        api.user.show(login).then(response => {
            let data = response.data.data;
            this.setState({
                user: {
                    name: data.login,
                    level: data.level    
                }
            });
        });

        let currentPageUrl = document.location.pathname.split('/').slice(2);
        if (currentPageUrl.length > 0) {
            currentPageUrl = currentPageUrl[0].toLowerCase();
            if (this.state.allPages.indexOf(currentPageUrl) != -1) {
                this.setState({current: currentPageUrl});
            }    
        }

        let page = document.getElementById(this.state.current)
        page.style.color = 'white'
        page.style.borderBottom = '3px solid white'
    }

    componentDidUpdate() {
        let page = document.getElementById(this.state.current);
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

    logout = () => {
        api.auth.logout().then(response => {
            localStorage.removeItem('loginToken');
            document.location = '/'
        });
    }

    render() {
        return (
            <nav id='dashboard-navbar'>
                <div id='dashboard-navbar-perfil'>
                    <img src='./../../images/user_Avatar.png' alt='user' />
                    <span>
                        <label>{this.state.user.name}<br></br>
                        <i className="fas fa-star" style={{color: '#fff630', marginTop: '10px'}}></i> {this.state.user.level}
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
                    <i className="fas fa-sign-out-alt" style={{cursor: 'pointer'}} onClick={this.logout}></i>                    
                </div>
            </nav>
        )
    }
}

export default NavBar;