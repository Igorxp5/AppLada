import React from 'react'
import games from './../../api/pelada'
import api from './../../api/user'

class MinhasPeladas extends React.Component {
    state = {
        peladas: []
    }

    componentDidMount() {
        const login = api.currentUserJwt().login
        games.user(login).then(response => {
            this.setState({
                peladas: response.data.data
            })            
        })
    }

    renderPeladas = () => {
        return this.state.peladas.map(p => {
            console.log(p)
            return(
                <div style={{color:'white', marginTop: '10px'}}>
                    <h2>{p.title}</h2>
                    <p>{p.start_date}</p>
                </div>
            )
        })
    }

    render() {
        return(
        <div style={{width: '100%', height: '100%'}}>
            {
                this.renderPeladas()
            }
        </div>)
    }
}

export default MinhasPeladas