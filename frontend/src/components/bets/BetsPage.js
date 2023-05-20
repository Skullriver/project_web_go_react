import {Component} from "react";
import axios from "axios";
import {Badge, Col, Container, Row, Spinner, Table} from "reactstrap";
import withAuth from "../auth/CheckAuth";
import {useNavigate} from "react-router-dom";
import TakeBetModal from "./TakeBetModal";
import UserHeader from "../user/UserHeader";
import {API_BASE_URL} from '../../config';

let endpoint = `${API_BASE_URL}:8080/bet/active/get`
let endpointUser = `${API_BASE_URL}:8080/user/get`

const withNavigate = (Component) => {
    return function WrappedComponent(props) {
        const navigate = useNavigate();
        const isAuthenticated = !!localStorage.getItem('token');
        return isAuthenticated ? <Component navigate={navigate} {...props} /> : null;
    }
};

class BetsPage extends Component {

    constructor(props) {
        super(props);
        this.state = {
            betsList: [],
            user: {},
            userBetsIds: []
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
            .then(res => {
                this.setState({
                    user: res.data,
                }, () => {
                    const idArray = this.state.user.taken_bets.map(item => item.bet_id);
                    this.setState({
                        userBetsIds: idArray,
                    })
                })
            })
            .catch(error => {
                console.log(error.response.data)
                // setAlertMessage(error.response.data)
                // setAlert(true)
            })

    };


    render() {
        const options = {
            timeZone: 'UTC'
        };
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
                                    <Table responsive>
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
                                                Taux de réalisation
                                            </th>
                                            <th>
                                                Taux de non réalisation
                                            </th>
                                            <th>
                                                Auteur
                                            </th>
                                            <th>
                                                Statut
                                            </th>
                                            <th>

                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {

                                            this.state.betsList.map(bet => {
                                                let color = bet.status === "created" ? "secondary" : bet.status === "opened" ? "primary" : "";
                                                return (
                                                    <tr key={bet.id}>
                                                        <th scope="row"> {bet.id}</th>
                                                        <td> {new Date(bet.limit_date).toLocaleString("fr", options)} </td>
                                                        <td> {bet.type === 1 ? 'Proportion de lignes où il y aura un problème' : bet.type === 2 ? 'La présence de problèmes sur une ligne' : 'Le nombre total d\'incidents pour cette journée'} </td>
                                                        <td> {bet.qt_victory} </td>
                                                        <td> {bet.qt_loss} </td>
                                                        <td> {bet.username}#{bet.user_id} </td>
                                                        <td>
                                                            <Badge color={color}>{bet.status}</Badge>
                                                        </td>
                                                        <td>{this.state.userBetsIds.includes(bet.id) ? "deja parié" :
                                                            <TakeBetModal user={this.state.user}
                                                                          bet_id={bet.id}/>}</td>
                                                    </tr>
                                                );
                                            })
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