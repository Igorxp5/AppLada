import React from 'react'
import {Map, GoogleApiWrapper, Marker, InfoWindow} from 'google-maps-react';
import games from './../../api/pelada'

export class MapContainer extends React.Component {   

    state = {
        showingInfoWindow: false,
        activeMarker: {},
        selectedPlace: {},
        lat: '',
        lng: '',
        peladas: []
    }

    onMarkerClick = (props, marker, e) => {
    this.setState({
      selectedPlace: props,
      activeMarker: marker,
      showingInfoWindow: true
    });
    //console.log('$$$$$$$$$$$$$', props)
    }

    componentDidMount() {
        games.all().then(response => {
            let peladas = []
            response.data.data.map(p => {
                peladas.push({latitude: p.latitude, longitude: p.longitude, title: p.title, owner: p.owner})                
            })
            this.setState({
                peladas: peladas
            },() => {
            })
        })
    }

    renderPeladas = () => {
        return this.state.peladas.map(p => {
            //console.log('########', p)
            return(                
                <Marker                
                position={{lat: p.latitude, lng: p.longitude}} name={p.title} owner={p.owner}
                onClick={this.onMarkerClick}/>
            )
        })
    }


    
    mapClicked = (t, map, coord) => {
        let lat = coord.latLng.lat()
        let lng = coord.latLng.lng()
        this.setState({ lat: lat, lng: lng })
        localStorage.setItem('lat', lat)
        localStorage.setItem('lng', lng)
    }

    onMarkerClick(props, marker, e) {
        //console.log(props)
        //console.log(marker)
        //console.log(e)
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
                {this.renderPeladas()}

                <InfoWindow
                marker={this.state.activeMarker}
                visible={this.state.showingInfoWindow}>
                    <div style={{Height: '500px'}}>
                    <h1>{this.state.selectedPlace.name}</h1>
                    <p>
                        {
                            this.state.selectedPlace.owner
                        } <br></br>                        
                    </p>
                    </div>
                </InfoWindow>
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