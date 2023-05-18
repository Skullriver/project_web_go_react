import {Component} from "react";
import withAuth from "../auth/CheckAuth";
import axios from "axios";
import CreationModal from "../bets/CreationModal";
import '../../styles/userHeader.css';
import {useNavigate} from "react-router-dom";
import {Button} from "reactstrap";

let endpointUser = "http://localhost:8080/api/user"

const withNavigate = (Component) => {
    return function WrappedComponent(props) {
        const navigate = useNavigate();
        const isAuthenticated = !!localStorage.getItem('token');
        return isAuthenticated ? <Component navigate={navigate} {...props} /> : null;
    }
};

class UserHeader extends Component {

    constructor(props) {
        super(props);
        this.state = {
            user: {
                user_id: 0,
                username: "",
                balance: 0,
                created_bets: {},
                taken_bets: {}
            }
        };
    }

    componentDidMount() {
        this.resetState();
    }

    resetState = () => {
        this.getUser();
    };

    getUser = () => {

        const authToken = localStorage.getItem('token');

        axios.get(endpointUser, {
            headers: {
                Authorization: `Bearer ${authToken}`,
            }
        })
            .then(
                res => this.setState({
                    user: res.data,
                }))
            .catch(error => {
                console.log(error.response.data)
                // setAlertMessage(error.response.data)
                // setAlert(true)
            })

    };

    handleExit = () => {
        localStorage.removeItem('token');
        this.props.navigate('/login');
    };

    render() {
        return (
            <div>
                <div className="user-header">
                    <div>
                        <span>Username</span>
                        <div>@{this.state.user.username}#{this.state.user.user_id}</div>
                        <div><a href="#" onClick={this.handleExit}>log out</a></div>
                    </div>
                    <div>
                        <span>Mes paris</span>
                        <div>
                            <div>créé : {this.state.user.created_bets.length}</div>
                            <div>participé : {this.state.user.taken_bets.length}</div>
                        </div>
                    </div>
                    <div>
                        <span>Proposer un pari</span>
                        <div><CreationModal/></div>
                    </div>
                </div>
                <hr/>
            </div>
        );
    }
}
export default withAuth(withNavigate(UserHeader));