import React, { Component } from 'react';
import { BrowserRouter as Router, Route } from "react-router-dom"
import Home from './views/home'
import FailPopup from './components/fail_popup'

class App extends Component {
  render() {
    return (
      <div className="App">
        <FailPopup />        
        <Router>          
          <Route path='/' component={ Home }/>
        </Router>
      </div>
    );
  }
}

export default App;
