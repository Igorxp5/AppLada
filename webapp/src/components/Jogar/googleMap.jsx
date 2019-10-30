import React from 'react'
import {Map, GoogleApiWrapper} from 'google-maps-react';

export class MapContainer extends React.Component {    
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
            />
        );
    }
  }

  export default GoogleApiWrapper({
    apiKey: 'AIzaSyDXWWICHgOv5fYE771f5Bc-Ggrn0lP5Xjs'
  })(MapContainer);