import React from 'react'
import Mapa from './mapa'
import Peladas from './peladas'

class Jogar extends React.Component {
    render() {
        return (
            <div style={{width: '100%', height:'100%'}}>
                <Mapa />
                <Peladas />
            </div>
        )
    }
}

export default Jogar;