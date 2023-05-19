import {Component} from "react";
import {BrowserRouter as Router, Link, Route, Routes, useNavigate} from "react-router-dom";
import {RxExit} from "react-icons/rx";
import Login from "./auth/Login";
import TrafficPage from "./traffic/TrafficPage";
import BetsPage from "./bets/BetsPage";
import Register from "./auth/Register";
import MyBets from "./user/MyBets";

class Menu extends Component {

    handleExit = () => {
        localStorage.removeItem('token');
        window.location.reload();
    };

    render() {

        return (
            <Router>
                <div className="App">
                    <nav className="navbar navbar-expand-lg navbar-light fixed-top">
                        <div className="container">
                            <div className="links">
                                <Link className="navbar-brand" to={'/'}>
                                    Welcome
                                </Link>
                                <Link className="nav-link" to={'/traffic'}>
                                    Traffic status
                                </Link>
                            </div>
                            <div><a href="#" onClick={this.handleExit}><RxExit/></a></div>
                        </div>
                    </nav>
                    <div>
                        <div>
                            <Routes>
                                <Route exact path="/" element={<BetsPage/>}/>
                                <Route path="/login" element={<Login/>}/>
                                <Route path="/register" element={<Register/>}/>
                                <Route path="/traffic" element={<TrafficPage/>}/>
                                <Route path="/user" element={<MyBets/>}/>
                            </Routes>
                        </div>
                    </div>

                </div>
            </Router>
        )
    }
}

export default Menu