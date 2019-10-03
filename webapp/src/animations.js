export default {
    warning: {
        showErrorPopup(warning) {
            let popup = document.getElementById('popup-fail-component');            
            let popupText = document.getElementById('popup-fail-text');
            popupText.innerHTML = warning;
            popupText.style.textDecoration = 'none';
            popup.style.display = 'flex';
            setTimeout(() => {
                popup.style.display = 'none';
            }, 3000)

        }
    }
}