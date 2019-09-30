import React from 'react'
import './../style/login.css'

class Login extends React.Component {
    state = {

    }

    render() {
        return (
            <div className='login-container'>
                <form className='login-form'>
                    <label>E-MAIL:</label>
                    <input type='text' className='login-form-inputs'/>
                    <label>SENHA:</label>
                    <input type='password' className='login-form-inputs'/>
                    <input type='submit' value='ENTRAR' id='submit-login-form'/>
                </form>
            </div>
        )
    }
}

export default Login