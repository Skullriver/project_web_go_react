import React, {Component} from "react";
import axios from 'axios';

let endpoint = "http://localhost:8080/login"

class Login extends Component {
   
  constructor(props) {
    super(props);
    this.state = {
        email: "",
        password: ""
    };
  }

  handleEmailChange = event => {
      this.setState({ email: event.target.value });
  };

  handlePasswordChange = event => {
      this.setState({ password: event.target.value });
  };

  handleSubmit = event => {
      event.preventDefault();

      const user = {
          email: this.state.email,
          password: this.state.password
      };

      axios.post(endpoint, user)
          .then(response => {
              console.log(response.data);
          })
          .catch(error => {
              console.log(error);
          });
  };

    render() {
        return (
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
        <div className="mb-3">
          <div className="custom-control custom-checkbox">
            <input
              type="checkbox"
              className="custom-control-input"
              id="customCheck1"
            />
            <label className="custom-control-label" htmlFor="customCheck1">
              Remember me
            </label>
          </div>
        </div>
        <div className="d-grid">
          <button type="submit" className="btn btn-primary">
            Submit
          </button>
        </div>
        <p className="forgot-password text-right">
          Forgot <a href="#">password?</a>
        </p>
      </form>
          );
    }
}


export default Login;