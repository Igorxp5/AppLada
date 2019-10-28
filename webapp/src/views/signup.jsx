import React from 'react'
import display from './../display'
import api from './../api/user'
import { EntranceBlock, EntranceInput, EntranceButton } from '../components/EntranceBlock'

class Signup extends React.Component {

	constructor(props) {
    	super(props);
    	this.state = {
    		login: '',
	        password: '',
	        confirmPassword: '',
	        name: '',
	        email: '',
	        birthday: '',
	        gender: ''
    	};
    }

	componentDidMount() {
        document.title = 'Registrar-se - AppLada'
    }

    _submit() {
    	api.signUp.userSignUp({
            login: this.state.login,
            password: this.state.password,
            name: this.state.name,
            email: this.state.email,
            birthday: this.state.birthday,
            gender: this.state.gender
        }).then(response => {
            display.notification.success('Usuário criado com sucesso')
            document.location = '/';
        }).catch(err => {
            let message = err.response.data.errors[0].message;
            display.notification.error(message)
        });
    }

    submitForm = event => {
        event.preventDefault()
        if (this.state.password !== this.state.confirmPassword) {
        	this.getNotificationCenter().errorAlert('As senhas não coincidem');
        } else {
        	this._submit();
        }
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

    addConfirmPasswordToState = event => {
        this.setState({
            confirmPassword: event.target.value
        })
    }
    
    addNameToState = event => {
        this.setState({
            name: event.target.value
        })
    }
    
    addEmailToState = event => {
        this.setState({
            email: event.target.value
        })
    }
    
    addBirthdayToState = event => {
        this.setState({
            birthday: event.target.value
        })
    }
    
    addGenderToState = event => {
        this.setState({
            gender: event.target.value
        })
    }

    render() {
        return (
        	<div style={{padding: '50px'}}>
        		<img src='/images/logo-applada.png' className='entrance-logo' alt='logo'/>
	            <EntranceBlock title='Registrar-se'>
	            	<form style={{display: 'flex', flexDirection: 'column'}} onSubmit={this.submitForm}>
	            		<EntranceInput name='name' placeholder='Nome' style={{width: '100%'}} 
	            					   onChange={this.addNameToState} required/>
	            		<EntranceInput name='login' placeholder='Usuário' style={{width: '100%'}} 
	            					   onChange={this.addLoginToState} required/>
	            		<EntranceInput name='email'  type='email' placeholder='E-mail' style={{width: '100%'}} 
	            					   onChange={this.addEmailToState} required/>
	            		<div style={{display: 'flex', justifyContent: 'space-between'}}>
		            		<EntranceInput name='birthday' type='date' placeholder='Data de Nascimento' style={{width: '45%'}} 
		            					   onChange={this.addBirthdayToState} required/>
		            		<select class='entrance-input' style={{width: '45%'}} onChange={this.addGenderToState} required>
		            			<option disabled selected value="">Selecione</option>
		            			<option value="M">Masculino</option>
		            			<option value="F">Feminino</option>
		            			<option value="O">Outros</option>
		            		</select>
		            	</div>
	            		<EntranceInput name='password' type='password' placeholder='Senha' style={{width: '100%'}} 
	            					   onChange={this.addPasswordToState} required/>
	            		<EntranceInput name='confirmPassword' type='password' placeholder='Confirmar Senha' style={{width: '100%'}} 
	            					   onChange={this.addConfirmPasswordToState} required/>
	            		<EntranceButton text='Criar Conta' style={{margin: '10px auto'}} type='submit'/>
	            	</form>
	            </EntranceBlock>
            </div>
        );
    }
}

export default Signup;