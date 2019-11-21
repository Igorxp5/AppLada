import React from 'react'
import {Map, GoogleApiWrapper, Marker} from 'google-maps-react';
import games from './../../api/pelada'

export class MapContainer extends React.Component {   

    state = {
        lat: '',
        lng: '',
        peladas: []
    }

    componentDidMount() {
        games.all().then(response => {
            let peladas = []
            let coord = []
            console.log('>>>>>>>>>>>>>', response.data.data)
            response.data.data.map(p => {
                peladas.push({latitude: p.latitude, longitude: p.longitude})                
            })
            this.setState({
                peladas: peladas
            },() => {
                console.log(this.state)
            })
        })
    }

    renderPeladas = () => {
        
    }


    
    mapClicked = (t, map, coord) => {
        let lat = coord.latLng.lat()
        let lng = coord.latLng.lng()
        this.setState({ lat: lat, lng: lng })
        localStorage.setItem('lat', lat)
        localStorage.setItem('lng', lng)
    }

    onMarkerClick(props, marker, e) {
        console.log(props)
        console.log(marker)
        console.log(e)
    }
    
    render() {
        const mapStyles = {
            width: '47%',
            height: '70vh',
            position: 'relative',
            display: 'block',
            borderRadius: '10px',
            marginLeft: '3%'
            };
            
        return (
            <Map
                google={this.props.google}
                zoom={8}
                style={mapStyles}
                initialCenter={{ lat: -8.0475622, lng: -34.8769643}}
                onClick={this.mapClicked}
            >
                <Marker                
                position={{lat: -8.0475622, lng: -34.8769643}} />
                <Marker                
                position={{lat: this.state.lat, lng: this.state.lng}} />
            </Map> 
        );
    }
  }

  export default GoogleApiWrapper({
    apiKey: 'AIzaSyDXWWICHgOv5fYE771f5Bc-Ggrn0lP5Xjs'
  })(MapContainer);