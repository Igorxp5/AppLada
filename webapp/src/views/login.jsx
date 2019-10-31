import React from 'react'
import { Link } from "react-router-dom"
import api from './../api/user'
import getErrorMessage from './../api/errors'
import { EntranceBlock, EntranceInput, EntranceButton } from '../components/EntranceBlock'
import display from './../display'

class Login extends React.Component {
	
    constructor(props) {
    	super(props);
    	this.state = {
    		login: '',
        	password: ''
    	};
    }

    componentDidMount() {
        document.title = 'Login - AppLada';
    }

    getLoginPayload(credentials) {
        let payload = {};
        if (credentials.login.includes('@')) {
            payload['email'] = credentials.login;
        } else {
            payload['login'] = credentials.login;
        }
        payload['password'] = credentials.password;
        return payload;
    }

	submitForm = event => {
        event.preventDefault();
        if (!this.state.login || !this.state.password) {
            return display.notification.error('Preencha todos os campos')
        }
        let loginPayload = this.getLoginPayload({
            login: this.state.login,
            password: this.state.password
        });
        api.auth.userLogin(loginPayload).then(response => {
            let errors = response.data.errors;
            if (errors.length > 0) {
                errors.map((error) => {
                    let message = getErrorMessage(error.code)
                    return display.notification.error(message);
                });
            } else {
                document.location = '/dashboard';
            }
            document.location = '/dashboard';
        }).catch(err => {
            let error = err.response.data.errors[0];
            let message = getErrorMessage(error.code);
            display.notification.error(message);
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
        		<img src='/images/logo-applada.png' className='entrance-logo' alt='applada logo'/>
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