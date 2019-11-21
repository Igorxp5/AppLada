import React from 'react'
import './../../../style/jogar/peladasProximas.css'
import games from './../../../api/pelada'

class PeladasProximas extends React.Component {

    state = {
        peladas: [
        ]
    }    

    componentDidMount() {
        games.all().then(response => {
            let peladas = []
            let coord = []
            console.log('>>>>>>>>>>>>>', response.data.data)
            response.data.data.map(p => {
                peladas.push({titulo: p.title, dataHora: p.start_date, criador:p.owner})
                coord.push({latitude: p.latitude, longitude: p.longitude})
            })
            this.setState({
                peladas: peladas
            },() => {
                console.log(this.state)
            })
        })
    }
    
    showPeladaProxima = () => {
        return this.state.peladas.map(pelada => {
            let detalhes = Object.values(pelada)
            return detalhes.map(det => {
                return <div key={det} style={{textAlign:'center', color:'white'}}>{det}</div>
            })
        })
    }

    render() {
        return(
            <div id='peladas-proximas-container'>                
                <div className='peladas-proximas-menu'>TÍTULO</div>
                <div className='peladas-proximas-menu'>DATA/HORA</div>
                <div className='peladas-proximas-menu'>CRIADA POR</div>
                    {this.showPeladaProxima()}
            </div>
            
        )
    }
}

export default PeladasProximas