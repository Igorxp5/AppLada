import axios from 'axios'

const userApi = axios.create({
    baseURL: 'http://dev.applada.com.br'
    // validateStatus: function (status) {
    //     return status < 500; // Reject only if the status code is greater than or equal to 500
    // }
})

export default {
    auth: {
        userLogin(payload) {
            return userApi.post('/login', payload);
        },
        userPassword(payload) {
            return  userApi.post('/')
        }
    },
    signUp: {
        userSignUp(payload) {
            return userApi.post('/signup', payload);
        }
    }
} 