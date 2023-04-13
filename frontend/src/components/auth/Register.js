import {Button, Form, FormFeedback, FormGroup, Input, Label} from "reactstrap";
import React, {Component} from "react";
import axios from 'axios';


let endpoint = "http://localhost:8080/register"

class Register extends Component {

    constructor(props) {
        super(props);
        this.state = {
            validUserName: false,
            validEmail: false,
            validPswd : false,
            fstpswd : "",
            userName : "",
            Email : ""


        };
    }


    handleNameChange = event => {
        //TODO verifier que le nom d'utilisateur est libre

        if (event.target.value === "") {
            this.setState({validUserName: false});
        } else {
            this.setState({validUserName: true});
            this.setState({userName: event.target.value});
        }
    };

     parseEmailAddress(email) {
        const atIndex = email.indexOf('@');
        const atI2 = email.indexOf('.');
        if (atIndex >= 0 && atI2 >=0) {
            const username = email.substring(0, atIndex);
            const domain = email.substring(atIndex + 1);
            return true;

        } else {
            return false;
        }
    }
    handleMailChange = event => {
        if(this.parseEmailAddress(event.target.value)){
            this.setState({validEmail:true})
            this.setState({Email:event.target.value})

        }
        else{
            this.setState({validEmail:false})

        }
    }

    handlePasswordChange = event => {
        //this.setState({password: event.target.value});
        this.setState({fstpswd : event.target.value});
    };
    handleSubmit = event => {
        event.preventDefault();

        const user = {
            email: this.state.Email,
            password: this.state.fstpswd,
            un : this.state.userName
        };

        axios.post(endpoint, user).then(reponse => {
            console.log(reponse.data);
        }).catch(error => {
            console.log(error);
        });
    };

    checkPswd = event =>{
        if(this.state.fstpswd === event.target.value ){
            this.setState({validPswd :true})
        }
    };


    render() {

        return (
            <div className="main-container">


                <Form className="auth-inner">
                    <h3>Register</h3>
                    <FormGroup className="classname2">
                        <Label for="UserName">
                            User name
                        </Label>
                        <Input valid={this.state.validUserName} invalid={!this.state.validUserName}
                               onChange={this.handleNameChange}
                        />
                    </FormGroup>
                    <FormGroup className="classname2">
                        <Label for="emailAddress">
                            Email address
                        </Label>
                        <Input
                        valid = {this.state.validEmail} invalid = {!this.state.validEmail}
                        onChange = {this.handleMailChange}

                        />
                    </FormGroup>
                    <FormGroup className="classname2">
                        <Label for="pswd1">
                            Password
                        </Label>
                        <Input type = "password"
                               onChange = {this.handlePasswordChange}
                        />

                    </FormGroup>
                    <FormGroup className="classname2">
                        <Label for="pswd2">
                            Repeat Password
                        </Label>
                        <Input type = "password" valid = {this.state.validPswd} invalid = {!this.state.validPswd}
                               onChange = {this.checkPswd}

                        />

                    </FormGroup>
                    <Button type="submit" color="primary" className="classname" onClick= {this.handleSubmit}>
                        Submit
                    </Button>
                </Form>

            </div>


        )


    }

}

export default Register