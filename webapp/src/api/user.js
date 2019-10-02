import axios from 'axios'

const userApi = axios.create({
    baseURL: 'http://api.applada.com.br',
    headers: {
        'Access-Control-Allow-Origin': '*'
    }
})

axios.defaults.headers.post['Access-Control-Allow-Origin'] = '*';

export default {
    auth: {
        userLogin(payload) {
            return userApi.post('/login', payload)
        }
    }
} 