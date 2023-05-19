import React, {Component} from "react";
import withAuth from "../auth/CheckAuth";
import axios from "axios";
import {useNavigate} from "react-router-dom";
import CreationModal from "../bets/CreationModal";
import {FormGroup, Input, Label, Modal, ModalBody, ModalHeader, Table} from "reactstrap";
import '../../styles/mybets.css';
import TakeBetModal from "../bets/TakeBetModal";
import UserHeader from "./UserHeader";

let endpointUser = "http://localhost:8080/api/user"
let endpointGet = "http://localhost:8080/api/bets/"

const withNavigate = (Component) => {
    return function WrappedComponent(props) {
        const navigate = useNavigate();
        const isAuthenticated = !!localStorage.getItem('token');
        return isAuthenticated ? <Component navigate={navigate} {...props} /> : null;
    }
};

class MyBets extends Component {

    constructor(props) {
        super(props);
        this.state = {
            user: {
                user_id: 0,
                username: "",
                balance: 0,
                created_bets: [],
                taken_bets: []
            },
            modalIsOpen: false,
            selectedBet: {},
            ticketIsOpen: false,
            selectedTicket: {},
            selectedTicketBet: {},
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

    handleRowClick = (betId) => {

        const authToken = localStorage.getItem('token');

        axios.get(endpointGet + `${betId}`, {
            headers: {
                Authorization: `Bearer ${authToken}`,
            },
        })
            .then(response => {
                this.setState({ selectedBet: response.data, modalIsOpen: true });
            })
            .catch(error => {
                console.log(error.response.data)
            });

    };

    handleTicketClick = (betId, ticket) => {

        const authToken = localStorage.getItem('token');

        axios.get(endpointGet + `${betId}`, {
            headers: {
                Authorization: `Bearer ${authToken}`,
            },
        })
            .then(response => {
                this.setState({ selectedTicketBet: response.data, selectedTicket: ticket, ticketIsOpen: true });
            })
            .catch(error => {
                console.log(error.response.data)
            });

    };

    toggleModal = () => {
        this.setState((prevState) => ({
            modalIsOpen: !prevState.modalIsOpen,
        }));
    };

    toggleTicketModal = () => {
        this.setState((prevState) => ({
            ticketIsOpen: !prevState.ticketIsOpen,
        }));
    };

    render() {
        const options = {
            timeZone: 'UTC'
        };
        return (
            <div className="main-container">
                <UserHeader/>
                <div className="my-bets">
                    <div>
                        <span>Created:</span>
                        <Table
                            hover
                            responsive
                            size=""
                        >
                            <thead>
                            <tr>
                                <th>
                                    #
                                </th>
                                <th>
                                    Day of pari
                                </th>
                                <th>
                                    Type de pari
                                </th>
                                <th>
                                    Status
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            {
                                this.state.user.created_bets.map(bet => (
                                    <tr key={bet.id} onClick={() => this.handleRowClick(bet.id)}>
                                        <th scope="row"> {bet.id}</th>
                                        <td> {new Date(bet.bet_date).toLocaleDateString("fr", options)} </td>
                                        <td> {bet.type === 1 ? 'Proportion de lignes où il y aura un problème' : bet.type === 2 ? 'La présence de problèmes sur une ligne' : 'Le nombre total d\'incidents pour cette journée'} </td>
                                        <td> {bet.status}</td>
                                    </tr>
                                ))
                            }
                            </tbody>
                        </Table>
                    </div>
                    <div>
                        <span>Participated:</span>
                        <Table
                            hover
                            responsive
                            size=""
                        >
                            <thead>
                            <tr>
                                <th>
                                    #
                                </th>
                                <th>
                                    Day of pari
                                </th>
                                <th>
                                    Type de pari
                                </th>
                                <th>
                                    Possible win
                                </th>
                                <th>
                                    Status
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            {
                                this.state.user.taken_bets.map(bet => (
                                    <tr key={bet.id} onClick={() => this.handleTicketClick(bet.id, bet)}>
                                        <th scope="row"> {bet.bet.id}</th>
                                        <td> {new Date(bet.bet.bet_date).toLocaleDateString("fr", options)}</td>
                                        <td> {bet.bet.type === 1 ? 'Proportion de lignes où il y aura un problème' : bet.type === 2 ? 'La présence de problèmes sur une ligne' : 'Le nombre total d\'incidents pour cette journée'} </td>
                                        <td> {bet.bid ? bet.value * bet.bet.qt_victory : bet.value * bet.bet.qt_loss }</td>
                                        <td> {bet.bet.status}</td>
                                    </tr>
                                ))
                            }
                            </tbody>
                        </Table>
                    </div>


                    <Modal isOpen={this.state.modalIsOpen} toggle={this.toggleModal} backdrop="static" size="lg">
                        <ModalHeader toggle={this.toggleModal} className="form-title">
                            {this.state.selectedBet && (
                            <div className="tb-title">
                                <div>
                                    <b>#{this.state.selectedBet.id}</b> {this.state.selectedBet.title}
                                </div>
                                <span>Created by: @{this.state.selectedBet.creator_username}#{this.state.selectedBet.creator_id}</span>
                            </div>
                            )}
                        </ModalHeader>
                        <ModalBody>
                            {this.state.selectedBet && (
                                <div className="tb-form-block-line-1">
                                    <FormGroup>
                                        <Label for="type">Type de pari</Label>
                                        <p>{this.state.selectedBet.type === 1 ? 'Proportion de lignes où il y aura un problème' : this.state.selectedBet.type === 2 ? 'La présence de problèmes sur une ligne' : this.state.selectedBet.type === 3 ? 'Le nombre total d\'incidents pour cette journée' : 'Error'}</p>
                                    </FormGroup>
                                    <FormGroup>
                                        <Label for="startDay">Jour de pari</Label>
                                        <p>{new Date(this.state.selectedBet.bet_date).toLocaleDateString("fr", options)} </p>
                                    </FormGroup>
                                    <FormGroup>
                                        <Label for="startDay">Date limite pour parier</Label>
                                        <p>{new Date(this.state.selectedBet.limit_date).toLocaleString("fr", options)} </p>
                                    </FormGroup>
                                </div>
                            )}
                            {this.state.selectedBet && (
                                <div className="tb-form-block-2">
                                    {this.state.selectedBet.type === 1 && (
                                        <div className="tb-form-type1-block">
                                            <FormGroup>
                                                <Label for="select">RER/Métro ?</Label>
                                                <p>{this.state.selectedBet.m_r}</p>
                                            </FormGroup>
                                            <FormGroup>
                                                <Label for="selectQty">%/qté ?</Label>
                                                <p>{this.state.selectedBet.num_type === 1 ? "%" : this.state.selectedBet.num_type === 2 ? "qté" : "error"}</p>
                                            </FormGroup>
                                            <FormGroup>
                                                <Label for="value">Valeur</Label>
                                                <p>{this.state.selectedBet.value}</p>
                                            </FormGroup>
                                        </div>
                                    )}
                                    {this.state.selectedBet.type === 2 && (
                                        <div className="tb-form-type2-block">
                                            <FormGroup>
                                                <Label for="select">RER/Métro ?</Label>
                                                <p>{this.state.selectedBet.m_r}</p>
                                            </FormGroup>
                                            <FormGroup>
                                                <Label for="selectLine">Ligne</Label>
                                                <p>{this.state.selectedBet.line}</p>
                                            </FormGroup>

                                        </div>
                                    )}
                                    {this.state.selectedBet.type === 3 && (
                                        <div className="tb-form-type2-block">
                                            <FormGroup>
                                                <Label for="select">RER/Métro ?</Label>
                                                <p>{this.state.selectedBet.m_r}</p>
                                            </FormGroup>
                                            <FormGroup>
                                                <Label for="value">Valeur</Label>
                                                <p>{this.state.selectedBet.value}</p>
                                            </FormGroup>
                                        </div>
                                    )}
                                </div>
                            )}
                            {this.state.selectedBet && (
                                <div className="tb-form-qt-block">
                                    <FormGroup>
                                        <Label className="tb-qtDefeat" for="qtDefeat">Taux de défaite</Label>
                                        <p>{this.state.selectedBet.qt_loss}</p>
                                    </FormGroup>
                                    <FormGroup>
                                        <Label className="tb-qtVictory" for="qtVictory">Taux de réussite</Label>
                                        <p>{this.state.selectedBet.qt_victory}</p>
                                    </FormGroup>
                                </div>
                            )}
                        </ModalBody>
                    </Modal>

                    <Modal isOpen={this.state.ticketIsOpen} toggle={this.toggleTicketModal} backdrop="static" size="lg">
                        <ModalHeader toggle={this.toggleTicketModal} className="form-title">
                            {this.state.selectedTicketBet && (
                                <div className="tb-title">
                                    <div>
                                        <b>#{this.state.selectedTicketBet.id}</b> {this.state.selectedTicketBet.title}
                                    </div>
                                    <span>Created by: @{this.state.selectedTicketBet.creator_username}#{this.state.selectedTicketBet.creator_id}</span>
                                </div>
                            )}
                        </ModalHeader>
                        <ModalBody>
                            {this.state.selectedTicketBet && (
                                <div className="tb-form-block-line-1">
                                    <FormGroup>
                                        <Label for="type">Type de pari</Label>
                                        <p>{this.state.selectedTicketBet.type === 1 ? 'Proportion de lignes où il y aura un problème' : this.state.selectedTicketBet.type === 2 ? 'La présence de problèmes sur une ligne' : this.state.selectedTicketBet.type === 3 ? 'Le nombre total d\'incidents pour cette journée' : 'Error'}</p>
                                    </FormGroup>
                                    <FormGroup>
                                        <Label for="startDay">Jour de pari</Label>
                                        <p>{new Date(this.state.selectedTicketBet.bet_date).toLocaleDateString("fr", options)} </p>
                                    </FormGroup>
                                    <FormGroup>
                                        <Label for="startDay">Date limite pour parier</Label>
                                        <p>{new Date(this.state.selectedTicketBet.limit_date).toLocaleString("fr", options)} </p>
                                    </FormGroup>
                                </div>
                            )}
                            {this.state.selectedTicketBet && (
                                <div className="tb-form-block-2">
                                    {this.state.selectedTicketBet.type === 1 && (
                                        <div className="tb-form-type1-block">
                                            <FormGroup>
                                                <Label for="select">RER/Métro ?</Label>
                                                <p>{this.state.selectedTicketBet.m_r}</p>
                                            </FormGroup>
                                            <FormGroup>
                                                <Label for="selectQty">%/qté ?</Label>
                                                <p>{this.state.selectedTicketBet.num_type === 1 ? "%" : this.state.selectedTicketBet.num_type === 2 ? "qté" : "error"}</p>
                                            </FormGroup>
                                            <FormGroup>
                                                <Label for="value">Valeur</Label>
                                                <p>{this.state.selectedTicketBet.value}</p>
                                            </FormGroup>
                                        </div>
                                    )}
                                    {this.state.selectedTicketBet.type === 2 && (
                                        <div className="tb-form-type2-block">
                                            <FormGroup>
                                                <Label for="select">RER/Métro ?</Label>
                                                <p>{this.state.selectedTicketBet.m_r}</p>
                                            </FormGroup>
                                            <FormGroup>
                                                <Label for="selectLine">Ligne</Label>
                                                <p>{this.state.selectedTicketBet.line}</p>
                                            </FormGroup>

                                        </div>
                                    )}
                                    {this.state.selectedTicketBet.type === 3 && (
                                        <div className="tb-form-type2-block">
                                            <FormGroup>
                                                <Label for="select">RER/Métro ?</Label>
                                                <p>{this.state.selectedTicketBet.m_r}</p>
                                            </FormGroup>
                                            <FormGroup>
                                                <Label for="value">Valeur</Label>
                                                <p>{this.state.selectedTicketBet.value}</p>
                                            </FormGroup>
                                        </div>
                                    )}
                                </div>
                            )}
                            {this.state.selectedTicketBet && (
                                <div className="tb-form-qt-block">
                                    <FormGroup>
                                        <Label className="tb-qtDefeat" for="qtDefeat">Taux de défaite</Label>
                                        <p>{this.state.selectedTicketBet.qt_loss}</p>
                                    </FormGroup>
                                    <FormGroup>
                                        <Label className="tb-qtVictory" for="qtVictory">Taux de réussite</Label>
                                        <p>{this.state.selectedTicketBet.qt_victory}</p>
                                    </FormGroup>
                                    <FormGroup>
                                        <Label for="qtVictory">Result of pari</Label>
                                        <div className="tb-form-bet-result">
                                            <div>
                                                <label>
                                                    <input type="radio" name="bid" checked={this.state.selectedTicket.bid === true} value="oui"
                                                           readOnly={true}/>
                                                    Oui
                                                </label>
                                            </div>
                                            <div>
                                                <label>
                                                    <input type="radio" name="bid" checked={this.state.selectedTicket.bid === false} value="non"
                                                           readOnly={true}/>
                                                    Non
                                                </label>
                                            </div>

                                        </div>
                                    </FormGroup>
                                </div>
                            )}
                            {this.state.selectedTicket && (
                            <div className="tb-footer">
                                <FormGroup className="tb-amount">
                                    <Label for="bet_value">Amount for pari</Label>
                                    <Input
                                        readOnly={true}
                                        value={this.state.selectedTicket.value}
                                    />
                                </FormGroup>
                            </div>
                            )}
                        </ModalBody>
                    </Modal>
                </div>

            </div>
        );
    }
}
export default withAuth(withNavigate(MyBets));