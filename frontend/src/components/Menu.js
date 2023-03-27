import {Component} from "react";
import {Nav, Navbar, NavItem} from "reactstrap";
import {BrowserRouter as Router, Route, Routes, Link} from "react-router-dom";

import Login from "./auth/Login";

class Menu extends Component {
    render() {
  
      return (
        <Router>
        <div className="App">
          <nav className="navbar navbar-expand-lg navbar-light fixed-top">
            <div className="container">
              <Link className="navbar-brand" to={'/'}>
                Welcome
              </Link>
              <div className="collapse navbar-collapse" id="navbarTogglerDemo02">
                <ul className="navbar-nav ml-auto">
                  <li className="nav-item">
                    <Link className="nav-link" to={'/login'}>
                      Login
                    </Link>
                  </li>
                  <li className="nav-item">
                    <Link className="nav-link" to={'/login'}>
                      Sign up
                    </Link>
                  </li>
                </ul>
              </div>
            </div>
          </nav>
          <div className="auth-wrapper">
            <div className="auth-inner">
              <Routes>
                <Route exact path="/" element={<Login />} />
                <Route path="/login" element={<Login />} />
                <Route path="/login" element={<Login />} />
              </Routes>
            </div>
          </div>
        </div>
      </Router>
      )
    }
  }
  
  export default Menu