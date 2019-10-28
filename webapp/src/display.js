// import Notification from './components/notification'
// import React from 'react'

function styleNotification(color, message) {
    let popup = document.getElementById('notification-component');            
    let popupText = document.getElementById('notification-text');
    let iconId = document.getElementById('notification-icon');
    
    let icon = ''
    if (color === 'red') {
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
            styleNotification('red', message)
        },
        success(message) {
            styleNotification('green', message)
        }
    }
}