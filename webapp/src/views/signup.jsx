import React from 'react'
import Page from './page'

import api from './../api/user'
import getErrorMessage from './../api/errors'
import { EntranceBlock, EntranceInput, EntranceButton } from '../components/EntranceBlock'
import ErrorNotification from '../components/error_notification'

class Signup extends Page {
	componentDidMount() {
        document.title = 'Registrar-se - AppLada'
    }

    render() {
        return (
        	<div>
        		<img src='/images/logo-applada.png' className='entrance-logo'/>
	            <EntranceBlock title='Registrar-se'>
	            	<form onSubmit={this.submitForm}>
	            		<EntranceInput name='login' placeholder='Usuário ou Email' style={{width: '100%'}} 
	            					   onChange={this.addLoginToState} required/>
	            		<EntranceInput name='password' type='password' placeholder='Senha' style={{width: '100%'}} 
	            					   onChange={this.addPasswordToState} required/>
	            		<EntranceButton text='Criar Conta' style={{margin: '10px auto'}} type='submit'/>
	            	</form>
	            </EntranceBlock>
            </div>
        );
    }
}

export default Signup;