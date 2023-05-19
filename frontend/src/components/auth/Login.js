import React, {Component, useEffect} from "react";
import axios from 'axios';
import '../../styles/auth.css';
import {useNavigate} from "react-router-dom";
import {Alert} from "reactstrap";
import withAuth from "./CheckAuth";

let endpoint = "http://localhost:8080/user/login"

const withNavigate = (Component) => {
    return function WrappedComponent(props) {
        const navigate = useNavigate();

        const isAuthenticated = !!localStorage.getItem('token');

        useEffect(() => {

            if (isAuthenticated) {
                navigate('/'); // Redirect to the desired page for authenticated users
            }
        }, [navigate]);

        return <Component navigate={navigate} {...props} />;
    }
};

class Login extends Component {

    constructor(props) {
        super(props);
        this.state = {
            email: "",
            password: "",
            message: "",
            messageOpen: false
        };
    }


    handleEmailChange = event => {
        this.setState({email: event.target.value});
    };

    handlePasswordChange = event => {
        this.setState({password: event.target.value});
    };

    handleSubmit = event => {
        event.preventDefault();

        const user = {
            email: this.state.email,
            password: this.state.password
        };


        axios.post(endpoint, user)
            .then(response => {
                localStorage.setItem('token', response.data.token);
                this.props.navigate('/');
            })
            .catch(error => {
                this.setState({message:error.response.data})
                this.setState({messageOpen: true})
            });
    };

    onDismiss = () => this.setState({messageOpen: false});

    render() {
        return (
            <div className="auth-wrapper">
                <div className="auth-inner">
                    <form onSubmit={this.handleSubmit}>
                        <h3>Sign In</h3>
                        <div className="mb-3">
                            <label>Email address</label>
                            <input
                                type="email"
                                className="form-control"
                                placeholder="Enter email"
                                value={this.state.email}
                                onChange={this.handleEmailChange}
                            />
                        </div>
                        <div className="mb-3">
                            <label>Password</label>
                            <input
                                type="password"
                                className="form-control"
                                placeholder="Enter password"
                                value={this.state.password}
                                onChange={this.handlePasswordChange}
                            />
                        </div>
                        <Alert color="danger" isOpen={this.state.messageOpen} toggle={this.onDismiss}>
                            {this.state.message}
                        </Alert>
                        <div className="d-grid">
                            <button type="submit" className="btn btn-primary">
                                Submit
                            </button>
                        </div>
                        <p className="forgot-password text-right">
                            Don't have account? <a href="/register">Register</a>
                        </p>
                    </form>
                </div>
            </div>

        );
    }
}


export default withAuth(withNavigate(Login));