import React from 'react'
import './../../style/jogar/peladaPopup.css'
import games from './../../api/pelada'
import display from './../../display'
import user from './../../api/user'

class PeladaPopup extends React.Component {

    state = {
        game: {
            title: this.props.title,
            description: this.props.description,
            startDate: this.props.start_date,
            owner: this.props.owner,
            id: this.props.id
        },
        participants: [],
        isParticipating: false,
        isOwner: false
    }

    componentDidMount() {
        this.setState({
            startDate: this.props.start_date,
            id: this.props.id
        }, () => {
            games.getParticipants(this.state.id).then(response => {
                let participants = response.data.data;
                this.setState({
                    participants: participants
                });
                this.updatePartipatingAndOwner();
            })
        })
    }

    updatePartipatingAndOwner = () => {
        let currentUserLogin = user.currentUserJwt().login;
        let isParticipating = false;
        this.state.participants.map(p => {
            if (p.login == currentUserLogin) isParticipating = true;
        });
        let isOwner = this.state.game.owner == currentUserLogin;
        this.setState({isParticipating: isParticipating, isOwner: isOwner});
    }

    participate = () => {
        games.participate(this.state.id).then(response => {
            display.notification.success('Presença marcada com sucesso!');
            this.setState({participants: response.data.data});
            this.updatePartipatingAndOwner();
        }).catch(err => {
            display.notification.errors(err.response.data.errors);
        });
    }

    leavePelada = () => {
        games.leavePelada(this.state.id).then(response => {
            display.notification.success('Você saiu da pelada');
            this.setState({participants: response.data.data});
            this.updatePartipatingAndOwner();
        }).catch(err => {
            display.notification.errors(err.response.data.errors);
        });
    }

    deletePelada = () => {
        let confirm = window.confirm('Você tem certeza que quer desfazer a pelada?')
        if (confirm) {
            games.deletePelada(this.state.id).then(response => {
                display.notification.success('Pelada desfeita');
                this.setState({participants: []});
                this.updatePartipatingAndOwner();
                this.props.closePopup();
            }).catch(err => {
                display.notification.errors(err.response.data.errors);
            });
        }
    }

    renderPartipateButton = () => {
        if (this.state.isOwner) {
            return (<button class="pelada-popup-button red" onClick={this.deletePelada}>Desfazer Pelada</button>);
        } else if (this.state.isParticipating) {
            return (<button class="pelada-popup-button red" onClick={this.leavePelada}>Sair da Pelada</button>);
        } else if (this.state.participants.length > 0) {
            return (<button class="pelada-popup-button" onClick={this.participate}>Marcar Presença</button>);
        }
        
    }

    render() {
        return (
            <div className="pelada-popup-all" style={{left: '0', zIndex: '1000'}}>
                <div className="pelada-popup-overlay"></div>
                <div className="pelada-popup-main">
                    <header className="pelada-popup-header">
                        <div className="pelada-popup-header-top">
                            <div className="pelada-popup-header-title">
                                <i className="fas fa-futbol"></i>
                                <h1>{this.state.game.title}</h1>
                            </div>
                            <i className="fas fa-times close" onClick={this.props.closePopup}></i>
                        </div>
                        <p className="pelada-popup-header-description">
                            {this.state.game.description}
                        </p>
                        <div className="pelada-popup-header-info">
                            <div className="pelada-popup-header-info-date">
                                <i className="far fa-calendar-minus"></i>
                                <span>{this.state.startDate}</span>
                            </div>
                            <div className="pelada-popup-header-info-owner">
                                <i className="fas fa-user"></i>
                                <span>{this.state.game.owner}</span>
                            </div>
                        </div>
                    </header>
                    <div className="pelada-popup-content">
                        <h2 className="pelada-popup-content-title">Participantes</h2>
                        <div className="pelada-popup-content-participants">
                            {this.state.participants.map(function(participant){
                                return (
                                    <div className="pelada-popup-content-participant">
                                        <img className="pelada-popup-content-participant-image" src="./../../images/user_Avatar.png"/>
                                        <div className="pelada-popup-content-participant-info">
                                            <span className="pelada-popup-content-participant-name">{participant.login}</span>
                                            <span className="pelada-popup-content-participant-level">
                                                <i className="fas fa-star" style={{color: '#fff630', marginRight: 3}} aria-hidden="true"></i>
                                                {participant.level}
                                            </span>
                                        </div>
                                    </div>
                                );
                            })}

                        </div>
                        {this.renderPartipateButton()}
                    </div>
                </div>
            </div>
        );
    }
}

export default PeladaPopup;