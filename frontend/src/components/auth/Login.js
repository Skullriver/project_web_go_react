import React, {Component, useEffect} from "react";
import axios from 'axios';
import '../../styles/auth.css';
import {useNavigate} from "react-router-dom";
import {Alert} from "reactstrap";
import withAuth from "./CheckAuth";

import { API_BASE_URL } from '../../config';
let endpoint = `${API_BASE_URL}:8080/user/login`

const withNavigate = (Component) => {
    return function WrappedComponent(props) {
        const navigate = useNavigate();

        const isAuthenticated = !!localStorage.getItem('token');

        useEffect(() => {

            if (isAuthenticated) {
                navigate('/'); // Redirect to the desired page for authenticated users
            }
        }, [navigate, isAuthenticated]);

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
                        <h3>S'identifier</h3>
                        <div className="mb-3">
                            <label>Adresse e-mail</label>
                            <input
                                type="email"
                                className="form-control"
                                placeholder="Entrez votre e-mail"
                                value={this.state.email}
                                onChange={this.handleEmailChange}
                            />
                        </div>
                        <div className="mb-3">
                            <label>Mot de passe</label>
                            <input
                                type="password"
                                className="form-control"
                                placeholder="Entrez votre mot de passe"
                                value={this.state.password}
                                onChange={this.handlePasswordChange}
                            />
                        </div>
                        <Alert color="danger" isOpen={this.state.messageOpen} toggle={this.onDismiss}>
                            {this.state.message}
                        </Alert>
                        <div className="d-grid">
                            <button type="submit" className="btn btn-primary">
                                Se connecter
                            </button>
                        </div>
                        <p className="forgot-password text-right">
                            Vous n'avez pas de compte? <a href="/register">S'inscrire</a>
                        </p>
                    </form>
                </div>
            </div>

        );
    }
}


export default withAuth(withNavigate(Login));