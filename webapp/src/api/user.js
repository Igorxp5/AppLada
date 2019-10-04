import axios from 'axios'

const userApi = axios.create({
    baseURL: 'http://api.applada.com.br',
    headers: {
        'Access-Control-Allow-Origin': '*'
    }
})

export default {
    auth: {
        userLogin(payload) {
            console.log(payload)
            return userApi.post('/login', payload)
        }
    },
    signUp: {
        userSignUp(payload) {
            console.log(payload)
            return userApi.post('/signup', payload)
        }
    }
} 