import React from 'react'
import './../../style/jogar/peladaPopup.css'
import games from './../../api/pelada'
import display from './../../display'

class PeladaPopup extends React.Component {

    state = {
        game: {
            title: this.props.title,
            description: this.props.description,
            startDate: this.props.start_date,
            owner: this.props.owner,
            id: this.props.id,
            participants: [
            ]
        },
        participants: [
        ]
    }

    componentDidMount() {
        this.setState({
            startDate: this.props.start_date,
            id: this.props.id
        }, () => {
            games.getParticipants(this.state.id).then(response => {
                console.log('>>>>>>', response.data.data)
                let participants = response.data.data 
                this.setState({
                    participants: participants
                })
            })
        })


        // console.log('>>>>>>>>>>>>>', this.props.start_date)
        // console.log('!!!!!!!!!!!!1', this.props.id)
    }

    participate = () => {
        games.participate(this.state.id).then(response => {
            console.log(response.data)
            display.notification.success('Presença marcada com sucesso!')
        }).catch(err => {
            display.notification.error('Ocorreu um erro, verifique as informações')
            console.log(err.response.data)
        })
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
                                {/* <span>{new Date(this.state.game.startDate).getUTCDate() + '/' + (new Date(this.state.game.startDate).getUTCMonth() + 1)}</span> */}
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
                                console.log(participant)
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

                        <button class="pelada-popup-button" onClick={this.participate}>Marcar Presença</button>
                    </div>
                </div>
            </div>
        );
    }
}

export default PeladaPopup;