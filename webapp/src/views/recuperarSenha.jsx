import React from 'react'
import { EntranceBlock, EntranceInput, EntranceButton } from '../components/EntranceBlock'

class RecuperarSenha extends React.Component {

    state = {
        login: ''
    }

    addLoginToState = event => {
        this.setState({
            login: event.target.value
        })        
    }

    submitForm = event => {
        event.preventDefault() 

    }

    render() {
        return(
            <EntranceBlock title='ESQUECI MINHA SENHA'>
                <form style={{display: 'flex', flexDirection: 'column'}} onSubmit={this.submitForm}>
                    <EntranceInput placeholder='Usuário ou Email' style={{width: '100%'}} 
                                    onChange={this.addLoginToState} required/>                    
                    <EntranceButton text='Enviar' style={{margin: '10px auto'}} type='submit'/>                    
                </form>
            </EntranceBlock>
        )
    }
}

export default RecuperarSenha;