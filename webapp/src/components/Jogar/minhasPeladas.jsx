import React from 'react'
import games from './../../api/pelada'
import api from './../../api/user'
import PeladaPopup from './peladaPopup'
import dateFormat from 'dateformat'

class MinhasPeladas extends React.Component {
    state = {
        peladas: [],
        showComponent: false,
        current: {}
    }

    componentDidMount() {
        this.refreshGamesList();
    }

    refreshGamesList = () => {
        const login = api.currentUserJwt().login;
        games.user(login).then(response => {
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
                    peladas.push({titulo: p.title, dataHora: p.start_date, criador:p.owner, description: p.description, estado: p.status, id: p.id})
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

    showMinhasPeladas = () => {
        const infos = ['titulo', 'dataHora', 'estado'];
        return this.state.peladas.map(pelada => {
            return infos.map(info => {
                let det = pelada[info];
                return <div key={det} onClick={() => {this.openDetails(pelada.titulo, pelada.description, pelada.id, pelada.criador, pelada.dataHora)}}style={{textAlign:'center', color:'white', zIndex:'999'}} className='peladaItem'>{det}</div>
            }, this);
        })
    }

    openDetails = (title, description, id, owner, start_time) => {
        this.setState({showComponent: true, current:{
            title: title,
            description: description,
            id: id,
            owner: owner,
            start_time: start_time
        }})
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
            start_date= {this.state.current.start_time}
            />
        }
    }

    renderPeladas = () => {
        return this.state.peladas.map(p => {
            //console.log(p)
            return(
                <div style={{color:'white', marginTop: '10px'}}>
                    <h2>{p.title}</h2>
                    <p>{p.start_date}</p>
                </div>
            )
        })
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
                    {this.showMinhasPeladas()}
            </div>
        );
    }
}

export default MinhasPeladas