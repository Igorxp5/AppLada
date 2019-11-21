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
    team: {
        statistics(initials) {
            return userApi.get('/teams/' + initials + '/statistics', getHeaders());
        }
    }
} 