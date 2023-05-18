import {Component} from "react";
import axios from "axios";
import {Col, Container, Row, Spinner, Table} from "reactstrap";
import CreationModal from "./CreationModal";
import withAuth from "../auth/CheckAuth";
import {useNavigate} from "react-router-dom";
import TakeBetModal from "./TakeBetModal";
import UserHeader from "../user/UserHeader";

const withNavigate = (Component) => {
    return function WrappedComponent(props) {
        const navigate = useNavigate();
        const isAuthenticated = !!localStorage.getItem('token');
        return isAuthenticated ? <Component navigate={navigate} {...props} /> : null;
    }
};

let endpoint = "http://localhost:8080/api/getActiveBets"
let endpointUser = "http://localhost:8080/api/user"

class BetsPage extends Component {

    constructor(props) {
        super(props);
        this.state = {
            betsList: [],
            user: {}
        };
    }


    componentDidMount() {
        this.resetState();
    }

    resetState = () => {
        this.getActiveBets();
        this.getUser();
    };

    getActiveBets = () => {
        this.setState({
            betsList: [],
        });
        const authToken = localStorage.getItem('token');

        axios.get(endpoint, {
            headers: {
                Authorization: `Bearer ${authToken}`,
            }
        })
            .then(
                res => this.setState({
                    betsList: res.data,
                }))
            .catch(error => {
                console.log(error.response.data)
                // setAlertMessage(error.response.data)
                // setAlert(true)
            })

    };

    getUser = () => {
        this.setState({
            user: {},
        });
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



    render() {

        return (
            <div className="main-container">
                <UserHeader/>
                <Container fluid style={{marginTop: "15px", padding: "0 50px"}}>
                    <Row>
                        <Col>
                            <div>

                                {!this.state.betsList || this.state.betsList.length <= 0 ? (
                                    <Spinner color="secondary" size="sm">
                                        Loading...
                                    </Spinner>
                                ) : (
                                    <Table>
                                        <thead>
                                        <tr>
                                            <th>
                                                #
                                            </th>
                                            <th>
                                                Date limite
                                            </th>
                                            <th>
                                                Type de pari
                                            </th>
                                            <th>
                                                Taux de réussite
                                            </th>
                                            <th>
                                                Taux de défaite
                                            </th>
                                            <th>
                                                Auteur
                                            </th>
                                            <th>
                                                Status
                                            </th>
                                            <th>

                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {
                                            this.state.betsList.map(bet => (
                                                <tr key={bet.id}>
                                                    <th scope="row"> {bet.id}</th>
                                                    <td> {new Date(bet.limit_date).toLocaleString()} </td>
                                                    <td> {bet.type === 1 ? 'Proportion de lignes où il y aura un problème' : bet.type === 2 ? 'La présence de problèmes sur une ligne' : 'Le nombre total d\'incidents pour cette journée'} </td>
                                                    <td> {bet.qt_victory} </td>
                                                    <td> {bet.qt_loss} </td>
                                                    <td> @{bet.username}#{bet.user_id} </td>
                                                    <td> {bet.status}</td>
                                                    <td> <TakeBetModal user={this.state.user} bet_id={bet.id}/></td>
                                                </tr>
                                            ))
                                        }
                                        </tbody>
                                    </Table>
                                )
                                }
                            </div>

                        </Col>
                    </Row>
                </Container>
            </div>
        );
    }
}

export default withAuth(withNavigate(BetsPage));