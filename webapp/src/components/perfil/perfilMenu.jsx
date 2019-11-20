import React from 'react'
import './../../style/perfil/perfil-menu.css'
import TimesLista from './perfil-times-lista'

class PerfilMenu extends React.Component {
    state = {
        current: 'perfil-times',
        allPages: ['perfil-times', 'perfil-peladas']
    }

    changePage = page => {
        console.log(page)
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

    teste = () => {
        console.log('TESTE')
    }

    showComponent = () => {
        switch(this.state.current) {
            case 'perfil-times':
                return(<TimesLista nome='Nautico' vitorias={4} membros={12}/>)
            case 'perfil-peladas':
                return 'perfil peladas'
            default:
                return('bbbbbbbbb')
        }
    }
    

    render() {
        return(
            <div id='perfil-container'>
                <div id='perfil-container-menu'>
                    <ul>
                        <li id='perfil-times' onClick={() => {this.changePage('perfil-times')}}>TIMES</li>
                        <li id='perfil-peladas' onClick={() => {this.changePage('perfil-peladas')}}>PELADAS</li>                        
                    </ul>
                </div>
                <div id='show-content'>
                    {this.showComponent()}                                
                </div>
            </div>
        )
    }
}

export default PerfilMenu