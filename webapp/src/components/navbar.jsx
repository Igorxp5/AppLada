import React from 'react'
import './../style/dashboard/navbar.css'

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
                        <li id='jogar' onClick={() => {this.setCurrentPage('jogar')}}>JOGAR</li>
                        <li id='perfil' onClick={() => {this.setCurrentPage('perfil')}}>PERFIL</li>
                        <li id='feed' onClick={() => {this.setCurrentPage('feed')}}>FEED</li>
                        <li id='times' onClick={() => {this.setCurrentPage('times')}}>TIMES</li>
                        <li id='torneios' onClick={() => {this.setCurrentPage('torneios')}}>TORNEIOS</li>
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