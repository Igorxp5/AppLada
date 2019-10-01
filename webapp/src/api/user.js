import axios from 'axios'

const userApi = axios.create({
    baseURL: 'http://api.applada.com.br'
})

export default {
    auth: {
        userLogin(payload) {
            return userApi('/login', payload)
        }
    }
} 