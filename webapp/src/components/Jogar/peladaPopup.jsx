import React from 'react'
import './../../style/jogar/peladaPopup.css'

class PeladaPopup extends React.Component {

    state = {
        game: {
            title: 'Pelada das 11h',
            description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Sunt, repellat. Nam, nulla voluptatum exercitationem quo, vero deleniti aperiam sit similique ratione quibusdam tempora architecto totam provident optio temporibus impedit consequatur.',
            startDate: 1574226000000,
            owner: 'lucas123',
            participants: [
                {
                    login: 'igorxp5',
                    level: 50
                }
            ]
        }
    }

    render() {
        return (
            <div class="pelada-popup-all">
                <div class="pelada-popup-overlay"></div>
                <div class="pelada-popup-main">
                    <header class="pelada-popup-header">
                        <div class="pelada-popup-header-top">
                            <div class="pelada-popup-header-title">
                                <i class="fas fa-futbol"></i>
                                <h1>{this.state.game.title}</h1>
                            </div>
                            <i class="fas fa-times close"></i>
                        </div>
                        <p class="pelada-popup-header-description">
                            {this.state.game.description}
                        </p>
                        <div class="pelada-popup-header-info">
                            <div class="pelada-popup-header-info-date">
                                <i class="far fa-calendar-minus"></i>
                                <span>{new Date(this.state.game.startDate).getUTCDate() + '/' + (new Date(this.state.game.startDate).getUTCMonth() + 1)}</span>
                            </div>
                            <div class="pelada-popup-header-info-owner">
                                <i class="fas fa-user"></i>
                                <span>{this.state.game.owner}</span>
                            </div>
                        </div>
                    </header>
                    <div class="pelada-popup-content">
                        <h2 class="pelada-popup-content-title">Participantes</h2>
                        <div class="pelada-popup-content-participants">
                            {this.state.game.participants.map(function(participant){
                                return (
                                    <div class="pelada-popup-content-participant">
                                        <img class="pelada-popup-content-participant-image" src="./../../images/user_Avatar.png"/>
                                        <div class="pelada-popup-content-participant-info">
                                            <span class="pelada-popup-content-participant-name">{participant.login}</span>
                                            <span class="pelada-popup-content-participant-level">
                                                <i class="fas fa-star" style={{color: '#fff630', marginRight: 3}} aria-hidden="true"></i>
                                                {participant.level}
                                            </span>
                                        </div>
                                    </div>
                                );
                            })}

                        </div>

                        <button class="pelada-popup-button">Marcar Presença</button>
                    </div>
                </div>
            </div>
        );
    }
}

export default PeladaPopup;