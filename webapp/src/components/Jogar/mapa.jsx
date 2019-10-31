import React from 'react'
import './../../style/jogar/mapa.css'
import MapContainer from './googleMap'

class Mapa extends React.Component {

    render() {
        return(
            <div id='jogar-mapa-container'>
                {/* <form>
                    <input type='text' id='jogar-mapa-input'></input>
                </form> */}
                <div id='google-map-container'>
                    <MapContainer />
                </div>
            </div>
        )
    }
}

export default Mapa;