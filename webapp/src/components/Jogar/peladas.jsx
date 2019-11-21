import React from 'react'
import './../../style/jogar/pelada.css'
import PeladasProximas from './peladasProximas'
import CriarPelada from './criarPelada'
import MinhasPeladas from './minhasPeladas'

class Peladas extends React.Component {

    state = {
        current: 'peladas-proximas',
        allPages: ['peladas-proximas', 'minhas-peladas', 'criar-pelada']
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
            case 'peladas-proximas':
                return(<PeladasProximas />)
            case 'minhas-peladas':
                return <MinhasPeladas />
            default:
                return(<CriarPelada lat={this.props.lat} lng={this.props.lng}/>)
        }
    }
    

    render() {
        return(
            <div id='pelada-container'>
                <div id='pelada-container-menu'>
                    <ul>
                        <li id='peladas-proximas' onClick={() => {this.changePage('peladas-proximas')}}>PELADAS PROXIMAS</li>
                        <li id='minhas-peladas' onClick={() => {this.changePage('minhas-peladas')}}>MINHAS PELADAS</li>
                        <li id='criar-pelada' onClick={() => {this.changePage('criar-pelada')}}>CRIAR PELADA</li>
                    </ul>
                </div>
                <div id='show-content'>
                    {this.showComponent()}                                
                </div>
            </div>
        )
    }
}

export default Peladas;