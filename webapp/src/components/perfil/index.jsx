import React from 'react'
import './../../style/perfil/perfil-index.css'
import api from './../../api/user'
import PerfilMenu from './perfilMenu'
import SearchInput from '../search_input'

class Perfil extends React.Component {

    state = {
        login: null,
        level: null,
        following: null,
        followers: null,
        games: null,
        torunaments: null,
        searchInput: null
        
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
        
        api.user.show(login).then(response => {
            let data = response.data.data;
            this.setState({
                login: data.login,
                level: data.level,
                following: data.following,
                followers: data.followers
            });
        });
        api.user.statistics(login).then(response => {
            let data = response.data.data;
            this.setState({
                games: data.total_played_games,
                tournaments: data.total_played_tournaments
            });
        });
    }

    onSearch(event) {
        if (this.state.searchInput != null) {
            alert('Um nome foi enviado: ' + this.state.searchInput);
            event.preventDefault();
        }
    }

    getSearchInput(event) {
        this.setState({searchInput: event.target.value});
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
                                <div className="perfil-user-level">{this.state.level}</div>
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
                                    <button class="perfil-follow-button">Seguir</button>
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
                    <PerfilMenu/>
                </div>
            </div>
        )
    }
}

export default Perfil