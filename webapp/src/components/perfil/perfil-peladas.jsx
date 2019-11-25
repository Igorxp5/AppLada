import React from 'react'
import './../../style/perfil/peladasPerfil.css'
import games from './../../api/pelada'
import PeladaPopup from './../Jogar/peladaPopup'
import dateFormat from 'dateformat'

class PerfilPelada extends React.Component {

    state = {
        peladas: [
        ],
        showComponent: false,
        current: {},
        login: ''
    }    

    componentDidMount() {
        this.refreshGamesList();
    }

    componentWillReceiveProps(props) {
        this.setState({ ...this.state, ...props }, () => {console.log(this.state)});
        console.log('@@@@@@@@@@@@@@', this.props.otherLogin)
        this.refreshGamesList()
    }

    refreshGamesList = () => {
        games.user(this.state.otherLogin).then(response => {
            let peladas = [];
            let coord = [];
            let filteredData = response.data.data.filter(v =>{
                return v.status != 'finished';
            });
            const statusText = {
                'on_hold': 'Aguardando Início',
                'in_progress': 'Em Andamento',
                'finished': 'Finalizado'
            }
            filteredData.map(p => {
                if (p.staus != 'finished') {
                    p.start_date = new Date(p.start_date);
                    p.start_date = dateFormat(p.start_date, 'dd mmm HH:MM');
                    p.status = statusText[p.status];
                    peladas.push({
                        titulo: p.title, dataHora: p.start_date, criador:p.owner, 
                        description: p.description, estado: p.status, id: p.id, limitParticipants: p.limit_participants})
                    coord.push({latitude: p.latitude, longitude: p.longitude});
                }
            });
            this.setState({
                peladas: peladas
            },() => {
                //console.log(this.state)
            })
        });
    }

    openDetails = (title, description, id, owner, start_time, limit_participants) => {
        this.setState({showComponent: true, current:{
            title: title,
            description: description,
            id: id,
            owner: owner,
            start_time: start_time,
            limit_participants: limit_participants
        }})
    }
    
    showPeladaProxima = () => {
        const infos = ['titulo', 'dataHora', 'estado'];
        if (!this.state.peladas) {
            return <div>Não foi relacionado em peladas ainda</div>
        }
        return this.state.peladas.map(pelada => {
            return infos.map(info => {
                let det = pelada[info];
                return <div key={det} onClick={() => {this.openDetails(pelada.titulo, pelada.description, pelada.id, pelada.criador, pelada.dataHora, pelada.limitParticipants)}}style={{textAlign:'center', color:'white', zIndex:'999'}} className='peladaItem'>{det}</div>
            }, this)
            // for(var i=0; i<detalhes.length; i++) {
            //     let det = detalhes[i]
            //     //console.log('==', detalhes.length)
            //     return <div key={det} onClick={() => {this.openDetails(pelada.title, pelada.description)}}style={{textAlign:'center', color:'white', zIndex:'999'}}>{det}</div>               
            // }
        })
    }

    closePopup = () => {
        this.setState({
            showComponent: false
        });
        this.refreshGamesList();
    }

    displayPopup = () => {
        if (this.state.showComponent) {
            return <PeladaPopup closePopup={this.closePopup} title={this.state.current.title} description={this.state.current.description}
            id= {this.state.current.id}
            owner= {this.state.current.owner}
            start_date={this.state.current.start_time}
            limit_participants={this.state.current.limit_participants}
            />
        }
    }

    render() {
        return(
            <div id='peladas-proximas-container'>  
            {
                this.displayPopup()
            }              
                <div className='peladas-proximas-menu'>TÍTULO</div>
                <div className='peladas-proximas-menu'>DATA/HORA</div>
                <div className='peladas-proximas-menu'>SITUAÇÃO</div>
                    {this.showPeladaProxima()}
            </div>
            
        )
    }
}

export default PerfilPelada