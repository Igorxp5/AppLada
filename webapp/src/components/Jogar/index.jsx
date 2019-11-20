import React from 'react'
import Mapa from './mapa'
import Peladas from './peladas'

class Jogar extends React.Component {

    state = {
        lat: '',
        lng: ''
    }

    saveCoord = (lat, lng) => {
        this.setState({
            lat,
            lng
        })
    }

    render() {
        return (
            <div style={{width: '100%', height:'100%'}}>
                <Mapa saveCoord={this.saveCoord}/>
                <Peladas lat={this.state.lat} lng={this.state.lng}/>
            </div>
        )
    }
}

export default Jogar;