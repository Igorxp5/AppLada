import React from 'react'
import games from './../../api/pelada'
import display from './../../display'

class CriarPelada extends React.Component {

    state = {
        title: "",
	    latitude: "",
	    longitude: "",
	    description: "",
	    limit_participants: null,
	    start_date: null,
        end_date: "",
        date: ""
    }

    getTitulo = event => {
        this.setState({
            title: event.target.value
        })
    }
    
    getDate = event => {
        let date = event.target.value;
        this.setState({
            date: date
        })
    }

    getLimitParticipants = event => {
        let limitParticipants = event.target.value;
        if (limitParticipants && limitParticipants > 1) {
            this.setState({
                limit_participants: limitParticipants
            });
        }
        
    }

    getStartDate = event => {
        let startDate = event.target.value
        startDate.split(':')
        let hour = parseInt(startDate[0])
        let minute = parseInt(startDate[1])
        let start_timestamp = new Date(this.state.date);
        start_timestamp.setUTCHours(hour);
        start_timestamp.setUTCMinutes(minute);
        let timestamp = new Date(start_timestamp).getTime();
        this.setState({
            start_date: timestamp
        }, () => {
            //console.log(this.state.start_date)
        })
    }

    getEndDate = event => {
        let startDate = event.target.value
        startDate.split(':')
        let hour = parseInt(startDate[0])
        let minute = parseInt(startDate[1])
        let end_timestamp = new Date(this.state.date)
        end_timestamp.setUTCHours(hour)
        end_timestamp.setUTCMinutes(minute)
        let timestamp = new Date(end_timestamp).getTime()
        //console.log(timestamp)
        this.setState({
            end_date: timestamp
        }, () => {
            //console.log(this.state.end_date)
        })
    }

    getDescricao = event => {
        this.setState({
            description: event.target.value
        })
    }

    submitForm = event => {
        event.preventDefault()
        this.setState({
            latitude: localStorage.getItem('lat'),
            longitude: localStorage.getItem('lng')
        }, () => {
            games.create(this.state).then(response => {
                display.notification.success('Pelada criada com sucesso')
            }).catch(err => {
                display.notification.errors(err.response.data.errors);
            })
        })        
    }

    render() {
        const containerStyle = {
            width: '100%',
            height: '100%',
            paddingRight: '10%',
            zIndex: '999'
        }

        const formStyle = {
            display: 'flex',
            flexDirection: 'column',
            marginTop: '3%',
            color: 'white'
        }

        const inputStyle = {
            fontSize: '1.3em', 
            background: 'rgba(0,0,0,0)', 
            border: 'none',
            borderBottom: '3px solid #FFF',
            padding: '3px',
            zIndex: '999',
            marginTop: '1%',
            color: 'white',
            outline: 'none'
        }

        const gridStyle = {
            display: 'grid',
            gridTemplateColumns: '23% 30% 30% 17%',
            marginTop: '1%',
            zIndex: '999'
        }

        const inputStyleGrid = {
            fontSize: '1.3em', 
            background: 'rgba(0,0,0,0)', 
            border: 'none',
            borderBottom: '3px solid #FFF',
            padding: '3px',
            zIndex: '999',
            marginTop: '1%',
            color: 'white',
            marginLeft: '7%',
            outline: 'none',
            width: '100px'
        }

        const inputStyleArea = {
            fontSize: '1.3em', 
            background: 'rgba(0,0,0,0)', 
            border: 'none',
            borderBottom: '3px solid #FFF',
            padding: '3px',
            zIndex: '999',
            marginTop: '1%',
            minHeight: 180,
            maxHeight: 180,
            color: 'white',
            height: '30vh',
            outline: 'none'
        }

        return(
            <div style={containerStyle}>
                <div style={{color:'white', fontSize:'1.1em'}}>
                    Para criar uma pelada, preencha os campos abaixo e marque no mapa ao lado
                    o local de sua pelada.
                </div>
                <form style={formStyle} onSubmit={this.submitForm}>
                    <label style={{fontSize: '1.3em'}}>TÍTULO</label>
                    <input type='text' style={inputStyle} onChange={this.getTitulo}/>
                    <div style={gridStyle}>
                        <label style={{fontSize: '1.3em'}}>DATA</label>
                        <label style={{fontSize: '1.3em', marginLeft: '10px'}}>DE</label>
                        <label style={{fontSize: '1.3em', marginLeft: '10px'}}>ATÉ</label>
                        <label style={{fontSize: '1.3em', marginLeft: '10px'}}>LIMITE</label>
                        <input type='date' style={inputStyle} onChange={this.getDate}/>
                        <input type='time' style={inputStyleGrid} onChange={this.getStartDate}/>
                        <input type='time' style={inputStyleGrid} onChange={this.getEndDate}/>
                        <input type='number' style={inputStyleGrid} min="2" onChange={this.getLimitParticipants}/>
                    </div>
                    <label style={{fontSize: '1.3em', marginTop: '15px'}}>DESCRIÇÃO</label>
                    <textarea style={inputStyleArea} onChange={this.getDescricao}/>
                    <input type='submit' value='CRIAR PELADA' className='create-pelada-button' style={{marginTop: '25px'}}/>
                </form>
            </div>
        )
    }
}

export default CriarPelada