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
                <p className="label">LOGIN:</p>
                <input type="text" onChange={this.addLoginToState}></input>
                <p className="label">NOME:</p> 
                <input type="text" onChange={this.addNameToState}></input>
                <p className="label">E-MAIL:</p> 
                <input type="text" onChange={this.addEmailToState}></input>
                <p className="label">DATA DE NASCIMENTO:</p> 
                <input type="text" onChange={this.addBirthdayToState}></input>
                <p className="label">GÊNERO: &emsp;
                <select name="gender" onChange={this.addGenderToState} value={this.state.gender}>
                    <option value="">Selecione</option>
                    <option value="Masculino">Masculino</option>
                    <option value="Feminino">Feminino</option>
                </select>         
                </p>        
                <p className="label">SENHA:</p> 
                <input type="password" onChange={this.addPasswordToState}></input>
                <p className="label">CONFIRMAR SENHA:</p> 
                <input type="password"></input> <br></br>
                <input type="submit" value="Cadastrar" id="submit-cadastro-form"></input>
                </form>
            </div>
        )
    }
}

export default Cadastro