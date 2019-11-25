import React from 'react'
import './../../style/perfil/perfil-index.css'
import api from './../../api/user'
import display from './../../display'
import PerfilMenu from './perfilMenu'
import SearchInput from '../search_input'

class Perfil extends React.Component {

    state = {
        login: null,
        level: null,
        following: null,
        followers: null,
        games: null,
        tournaments: null,
        searchInput: null,
        perfilMenu: null,
        isFollower: null,
        otherLogin: ''
        
    }

    getLoginUrl() {
        let paths = document.location.pathname.split('/');
        
        if (paths[paths.length - 1] == '' || paths[paths.length - 1] == 'perfil') {
            return null;
        }
        return paths[paths.length - 1];
    }

    async componentDidMount(){
        
        let login = ''; 
        let urlLogin = this.getLoginUrl();
        
        if (urlLogin === null) {
            login = api.currentUserJwt().login;
        } else {
            login = urlLogin;
        }
        this.setState({
            otherLogin: login
        })
        
        api.user.show(login).then(response => {
            let data = response.data.data;           
            this.setState({
                login: data.login,
                level: data.level,
                following: data.following,
                followers: data.followers
            });
            this.checkIfIsFollower();
        });
        api.user.statistics(login).then(response => {
            let data = response.data.data;
            this.setState({
                games: data.total_played_games,
                tournaments: data.total_played_tournaments
            });
        });
    }

    onSearch = event => {
        if (this.state.searchInput != null) {
            document.location = '/dashboard/perfil/' + this.state.searchInput
            event.preventDefault();
        }
    }

    getSearchInput = event => {
        this.setState({searchInput: event.target.value});
    }

    follow = event => {
        api.user.follow(this.state.login).then(response => {
            display.notification.success('Agora você está seguindo <b>' + this.state.login + '</b>')
            this.setState({followers: this.state.followers + 1, isFollower: true});
        }).catch(err => {
            display.notification.errors(err.response.data.errors);
        });
    }

    unfollow = event => {
        api.user.unfollow(this.state.login).then(response => {
            display.notification.success('Agora você não está mais seguindo <b>' + this.state.login + '</b>')
            this.setState({followers: this.state.followers - 1, isFollower: false});
        }).catch(err => {
            display.notification.errors(err.response.data.errors);
        });
    }

    checkIfIsFollower = () => {
        api.user.checkIfIsFollower(this.state.login).then(response => {
            let isFollower = response.headers['allow'].indexOf('DELETE') != -1
            this.setState({isFollower: isFollower});
        }).catch(err => {
            display.notification.errors(err.response.data.errors);
        });
    }

    renderFollowButton = () => {
        if (api.currentUserJwt().login != this.state.login && this.state.isFollower === false) {
            return (<button class="perfil-follow-button" onClick={this.follow}>Seguir</button>);
        } else if (this.state.isFollower === true) {
            return (<button class="perfil-follow-button" onClick={this.unfollow}>Deixar de Seguir</button>);
        }
        
    }

    render() {
        return(
            <div id='perfil-container-maior'>
                <div class="perifl-side-left">
                    <form id="search-user" class="search-user" onSubmit={this.onSearch}>
                        <SearchInput style={{marginTop: 10, width: '100%'}} onChange={this.getSearchInput} />
                    </form>
                    <div class="perfil-user">
                        <div className="perfil-user-top">
                            <div className="perfil-user-figure">
                                <img className="perfil-user-image" src="./../../images/user_Avatar.png"/>
                                <div className="perfil-user-name">{this.state.login}</div>
                                <div className="perfil-user-level">
                                    <i className="fas fa-star" style={{color: '#fff630', marginTop: '10px'}}></i>
                                    {this.state.level}
                                </div>
                            </div>
                            <div class="perfil-user-details">
                                <div class="perfil-user-followers-block">
                                    <div class="perfil-user-following">
                                        <span><b>{this.state.following}</b></span>
                                        <span>Seguindo</span>
                                    </div>
                                    <div class="perfil-user-followers">
                                        <span><b>{this.state.followers}</b></span>
                                        <span>Seguidores</span>
                                    </div>
                                </div>
                                <div>
                                { this.renderFollowButton() }
                                </div>
                            </div>
                        </div>
                        <div class="perfil-user-bottom">
                            <div class="perfil-user-bottom-games">
                                <span><i class="perfil-user-bottom-games-icon"></i></span>
                                <span class="perfil-user-bottom-games-value">{this.state.games}</span>
                                <span>Peladas</span>
                            </div>
                            <div class="perfil-user-bottom-tournaments">
                            <span><i class="perfil-user-bottom-tournaments-icon"></i></span>
                                <span class="perfil-user-bottom-tournaments-value">{this.state.tournaments}</span>
                                <span>Torneios</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="perifl-side-right">
                    <PerfilMenu login={this.state.login} otherLogin={this.state.otherLogin}/>
                </div>
            </div>
        )
    }
}

export default Perfil