import React from 'react'
import './../../style/perfil/perfil-menu.css'
import TimesLista from './perfil-times-lista'

import api from './../../api/user'

class PerfilMenu extends React.Component {

    constructor({exProp}){
        super()
        let state = {
            current: 'perfil-peladas',
            allPages: ['perfil-peladas', 'perfil-times'],
            teams: []
        }
        this.state = {...state, exProp}
      }

    changePage = page => {
        this.setState({
            current: page
        })
    }

    async componentDidMount() {
        let page = document.getElementById(this.state.current);
        page.style.color = 'white'
        page.style.borderBottom = '3px solid white';
    }

    async componentDidUpdate() {
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
        });

        api.user.teams(this.props.login).then(response => {
            let teams = response.data.data;
            teams.map(team => {
                api.team.statistics(team.initials).then(responseStatistics => {
                    let win_tournaments = responseStatistics.data.data.total_win_tournaments;
                    team['win_tournaments'] = win_tournaments;
                    this.setState({teams: teams});
                });
            });
            
        });
    }

    componentWillReceiveProps(props) {
        this.setState({ ...this.state, ...props });
    }

    teste = () => {
        //console.log('TESTE')
    }

    showComponent = () => {
        switch(this.state.current) {
            case 'perfil-times':
                let teams = this.state.teams.map(function(team){
                    return <TimesLista key={team.initials} nome={team.name} vitorias={team.win_tournaments} membros={team.total_members}/>;
                });
                return (teams);
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
                        <li id='perfil-peladas' onClick={() => {this.changePage('perfil-peladas')}}>PELADAS</li>                        
                        <li id='perfil-times' onClick={() => {this.changePage('perfil-times')}}>TIMES</li>
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