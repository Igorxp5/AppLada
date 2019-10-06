import React from 'react'
import './../style/cadastro.css'
import api from './../api/user'
import animate from './../animations'

class Cadastro extends React.Component {
    state = {
        login: '',
        password: '',
        name: '',
        email: '',
        birthday: '',
        gender: ''
    }

    submitForm = event => {
        event.preventDefault()
        api.signUp.userSignUp({
            login: this.state.login,
            password: this.state.password,
            name: this.state.name,
            email: this.state.email,
            birthday: this.state.birthday,
            gender: this.state.gender
        }).then(resp => {
            console.log('RESPONSE SIGNUP > ', resp.data)
        }).catch(err => {
            animate.warning.showErrorPopup(err)        
        })
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
            <div className='cadastro-container'>
                <form className='cadastro-form' onSubmit={this.submitForm}>                    
                    <label>Login:</label>
                    <input type="text" onChange={this.addLoginToState} className='cadastro-form-inputs'></input>                    
                    <label className="cadastro-label">Nome:</label> 
                    <input type="text" onChange={this.addNameToState} className='cadastro-form-inputs'></input>
                    <label className="cadastro-label">E-mail:</label> 
                    <input type="email" onChange={this.addEmailToState} className='cadastro-form-inputs'></input>
                    <label className="cadastro-label">Data de nascimento:</label> 
                    <input type="date" onChange={this.addBirthdayToState} className='cadastro-form-inputs' style={{width: '32%', textAlign:'center'}}></input>                    
                    <div className="select is-rounded" style={{marginTop: '50px'}}>
                        <select name="gender" onChange={this.addGenderToState} value={this.state.gender}>
                            <option value="">Gênero</option>
                            <option value="Masculino">Masculino</option>
                            <option value="Feminino">Feminino</option>
                        </select>   
                    </div>
                    <label className="cadastro-label">Senha:</label> 
                    <input type="password" onChange={this.addPasswordToState} className='cadastro-form-inputs'></input>
                    <label className="cadastro-label">Confirmar senha:</label> 
                    <input type="password" className='cadastro-form-inputs'></input> <br></br>
                    <input type="submit" value="Cadastrar" id="submit-login-form"></input>
                </form>
            </div>
        )
    }
}

export default Cadastro