import React from 'react'
import Page from './page'
import { Link } from "react-router-dom"
import { withRouter } from "react-router"

import api from './../api/user'
import getErrorMessage from './../api/errors'
import { EntranceBlock, EntranceInput, EntranceButton } from '../components/EntranceBlock'

class Login extends Page {
	
    constructor(props) {
    	super(props);
    	Object.assign(this.state, {
    		login: '',
        	password: ''
    	});
    }

    componentDidMount() {
        document.title = 'Login - AppLada'
    }

	submitForm = event => {
        event.preventDefault();
        api.auth.userLogin({
            login: this.state.login,
            password: this.state.password
        }).then(response => {
            let errors = response.data.errors;
            if (errors.length > 0) {
				errors.map((error) => {
					let message = getErrorMessage(error.code)
        			this.getNotificationCenter().newAlert(message);
				});
            } else {
                document.location = '/dashboard';
            }
        }).catch(err => {
        	let message = getErrorMessage(0);
        	this.getNotificationCenter().newAlert(message);
        });
    }

    addLoginToState = event => {
        this.setState({
            login: event.target.value
        })
    }

    addPasswordToState = event => {
        this.setState({
            password: event.target.value
        })
    }

    render() {
        return (
        	<div>
        		<img src='/images/logo-applada.png' className='entrance-logo'/>
	            <EntranceBlock title='Entrar'>
	            	<form style={{display: 'flex', flexDirection: 'column'}} onSubmit={this.submitForm}>
	            		<EntranceInput name='login' placeholder='Usuário ou Email' style={{width: '100%'}} 
	            					   onChange={this.addLoginToState} required/>
	            		<EntranceInput name='password' type='password' placeholder='Senha' style={{width: '100%'}} 
	            					   onChange={this.addPasswordToState} required/>
                        <Link to="/forgot-password" 
                              style={{alignSelf: 'flex-end', textAlign: 'right', marginBottom: '10px'}}>Esqueci minha senha</Link>
	            		<EntranceButton text='Entrar' style={{margin: '10px auto'}} type='submit'/>
                        <p style={{textAlign: 'center', marginTop: '5px'}}>Não possui conta? <Link to='/signup'>Criar uma conta</Link></p>
	            	</form>
	            </EntranceBlock>
            </div>
        );
    }
}

export default Login;