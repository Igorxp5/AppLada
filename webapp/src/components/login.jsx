import React from 'react'
import './../style/login.css'
import api from './../api/user'
import animate from './../animations'

class Login extends React.Component {
    state = {
        email: '',
        password: ''
    }

    submitForm = event => {
        event.preventDefault()
        api.auth.userLogin({
            email: this.state.email,
            password: this.state.password
        }).then(resp => {
            console.log('RESPONSE LOGIN > ', resp.data)
        }).catch(err => {
            animate.warning.showErrorPopup(err)        
        })
    }

    addEmailToState = event => {
        this.setState({
            email: event.target.value
        })
    }

    addPasswordToState = event => {
        this.setState({
            password: event.target.value
        })
    }

    render() {
        return (
            <div className='login-container'>
                <form className='login-form' onSubmit={this.submitForm}>
                    <label>E-MAIL:</label>
                    <input type='text' className='login-form-inputs' onChange={this.addEmailToState}/>
                    <label>SENHA:</label>
                    <input type='password' className='login-form-inputs' onChange={this.addPasswordToState}/>
                    <input type='submit' value='ENTRAR' id='submit-login-form'/>
                </form>
            </div>
        )
    }
}

export default Login