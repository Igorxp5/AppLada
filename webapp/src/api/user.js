import axios from 'axios'
import Utils from '../components/utils';

const userApi = axios.create({
    baseURL: 'http://dev.applada.com.br'
    // validateStatus: function (status) {
    //     return status < 500; // Reject only if the status code is greater than or equal to 500
    // }
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
    currentUserJwt: function() {
        let token = localStorage.getItem('loginToken');
        return Utils.parseJwt(token);
    },
    currentUser: function() {
        let userJwt = this.currentUserJwt();
        return userApi.get('/users/' + userJwt.login, getHeaders());
    },
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
    },
    user: {
        show(login) {
            return userApi.get('/users/' + login, getHeaders());
        },
        statistics(login) {
            return userApi.get('/users/' + login + '/statistics', getHeaders());
        },
        teams(login) {
            return userApi.get('/users/' + login + '/teams', getHeaders());
        },
        checkIfIsFollower(login) {
            return userApi.options('/users/' + login + '/followers', getHeaders());
        },
        follow(login) {
            return userApi.post('/users/' + login + '/followers', {}, getHeaders());
        },
        unfollow(login) {
            return userApi.delete('/users/' + login + '/followers', getHeaders());
        }
    },
    team: {
        statistics(initials) {
            return userApi.get('/teams/' + initials + '/statistics', getHeaders());
        }
    }
} 