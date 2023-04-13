import {Component} from "react";
import {BrowserRouter as Router, Link, Route, Routes} from "react-router-dom";

import Login from "./auth/Login";
import TrafficPage from "./traffic/TrafficPage";
import Register from "./auth/Register";

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
                                    <li className = "nav-item">
                                        <Link className = "nav-link" to = {'/register'}>
                                            Register
                                        </Link>
                                    </li>
                                    <li className="nav-item">
                                        <Link className="nav-link" to={'/traffic'}>
                                            Traffic status
                                        </Link>
                                    </li>

                                </ul>
                            </div>
                        </div>
                    </nav>
                    <div>
                        <div>
                            <Routes>
                                <Route exact path="/" element={<Login/>}/>
                                <Route path="/login" element={<Login/>}/>
                                <Route path="/register" element={<Register/>}/>
                                <Route path="/traffic" element={<TrafficPage/>}/>
                            </Routes>
                        </div>
                    </div>

                </div>
            </Router>
        )
    }
}

export default Menu