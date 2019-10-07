import React, { Component } from 'react';
import { BrowserRouter as Router, Route } from "react-router-dom"
import Login from './views/login'
import Signup from './views/signup'
import Dashboard from './views/dashboard'
import NotificationCenter from './components/notification_center'

class App extends Component {
  getNotificationCenter() {
    return this.notificationCenter;
  }

  render() {
    return (
      <div className="app">
        <NotificationCenter ref={ el => this.notificationCenter = el }/>
        <Router>
          <Route exact path="/" render={ () => <Login app={this} /> } />
          <Route path="/signup" render={ () => <Signup app={this} /> } />
          <Route path="/dashboard" render={ () => <Dashboard app={this} /> } />
        </Router>
      </div>
    );
  }
}

export default App;
