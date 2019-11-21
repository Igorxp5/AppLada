import axios from 'axios'

const gamesApi = axios.create({
    baseURL: 'http://dev.applada.com.br/games'
})

function getHeaders() {
    let token = localStorage.getItem('loginToken');
    return {
        headers: {
            Authorization: 'Bearer ' + token //the token is a variable which holds the token
        }
    }
}

export default {
    
    create(payload) {
        return gamesApi.post('/', payload, getHeaders());    
    },
    all() {
        return gamesApi.get('/', getHeaders());    
    },
} 