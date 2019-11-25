// import Notification from './components/notification'
// import React from 'react'

import getError from './api/errors'

function styleNotification(color, message) {
    let popup = document.getElementById('notification-component');            
    let popupText = document.getElementById('notification-text');
    let iconId = document.getElementById('notification-icon');
    
    let icon = ''
    if (color === '#E42C2C') {
        icon = '<i class="fas fa-exclamation-triangle"></i>'
    } else {
        icon = '<i class="far fa-check-circle"></i>'
    }
    
    popupText.innerHTML = message;

    iconId.innerHTML = icon;

    popup.style.backgroundColor = color
    popup.style.display = 'flex';
    
    setTimeout(() => {
        popup.style.display = 'none';
    }, 5000)
}

export default {
    notification: {
        error(message) {
            styleNotification('#E42C2C', message)
        },
        errors(errors) {
            errors.map(error => {
                let message = getError(error.code) || error.message;
                this.error(message);
            });
        },
        success(message) {
            styleNotification('#20bb6d', message)
        }
    }
}