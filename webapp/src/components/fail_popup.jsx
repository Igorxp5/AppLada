import React from 'react'
import './../style/popups.css'

function FailPopup() {
    return(
        <div id='popup-fail-component'>
            <i className="fas fa-exclamation-circle" style={{fontSize:'1.5em', marginRight:'10px'}}></i> 
            <i id='popup-fail-text'></i>
        </div>
    )
}

export default FailPopup;