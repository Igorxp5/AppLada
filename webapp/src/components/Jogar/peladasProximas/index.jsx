import React from 'react'
import './../../../style/jogar/peladasProximas.css'
import games from './../../../api/pelada'
import PeladaPopup from './../peladaPopup'
import dateFormat from 'dateformat'

class PeladasProximas extends React.Component {

    state = {
        peladas: [
        ],
        showComponent: false,
        current: {}
    }    

    componentDidMount() {
        this.refreshGamesList();
    }

    refreshGamesList = () => {
        games.all().then(response => {
            let peladas = [];
            let coord = [];
            let filteredData = response.data.data.filter(v =>{
                return v.status != 'finished';
            });
            filteredData.map(p => {
                p.start_date = new Date(p.start_date);
                p.start_date = dateFormat(p.start_date, 'dd mmm HH:MM');
                peladas.push({titulo: p.title, dataHora: p.start_date, criador:p.owner, description: p.description, id: p.id})
                coord.push({latitude: p.latitude, longitude: p.longitude});
            });
            this.setState({
                peladas: peladas
            },() => {
                //console.log(this.state)
            })
        });
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
    
    showPeladaProxima = () => {
        return this.state.peladas.map(pelada => {
            let detalhes = Object.values(pelada)
            let i = 0
            return detalhes.map(det => {
                if (i<3){
                    i++
                    //console.log(pelada.titulo, pelada.description)
                    return <div key={det} onClick={() => {this.openDetails(pelada.titulo, pelada.description, pelada.id, pelada.criador, pelada.dataHora)}}style={{textAlign:'center', color:'white', zIndex:'999'}} className='peladaItem'>{det}</div>
                } else {
                    return null
                }
                
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
            start_date= {this.state.current.start_time}
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
                <div className='peladas-proximas-menu'>CRIADA POR</div>
                    {this.showPeladaProxima()}
            </div>
            
        )
    }
}

export default PeladasProximas