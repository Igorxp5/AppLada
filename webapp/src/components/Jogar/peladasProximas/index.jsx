import React from 'react'
import './../../../style/jogar/peladasProximas.css'

class PeladasProximas extends React.Component {

    state = {
        peladas: [
            {
                titulo: 'Pelada das 11h',
                dataHora: 'em 5 dias',
                distancia: '7 Km',
                criador: 'Xeldu'
            },
            {
                titulo: 'Pelada das 09h',
                dataHora: 'em 7 dias',
                distancia: '11 Km',
                criador: 'Kayque'
            }
        ]
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
                <div className='peladas-proximas-menu'>DISTÂNCIA</div>
                <div className='peladas-proximas-menu'>CRIADA POR</div>
                    {this.showPeladaProxima()}
            </div>
            
        )
    }
}

export default PeladasProximas