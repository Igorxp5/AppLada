import React, { Component } from 'react';
import { BrowserRouter as Router, Route } from "react-router-dom"
import Login from './views/login'
import Signup from './views/signup'
import Dashboard from './views/dashboard'
import Notification from './components/notification'
import RecuperarSenha from './views/recuperarSenha'

class App extends Component {
  getNotificationCenter() {
    return this.notificationCenter;
  }

  render() {
    return (
      <div className="app">        
        
        <Router>
          <Notification />
          <Route exact path="/" component={ Login } />
          <Route path="/signup" component={ Signup } />
          <Route path="/dashboard" component={ Dashboard }/>
          <Route path="/forgot-password" component={ RecuperarSenha }/>
        </Router>
      </div>
    );
  }
}

export default App;
