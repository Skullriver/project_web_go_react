import React, {useState} from 'react';
import {Button, Form, FormGroup, Input, Label, Modal, ModalBody, ModalFooter, ModalHeader} from 'reactstrap';
import '../../styles/takeBet.css';
import axios from "axios";

let endpointGet = "http://localhost:8080/api/bets/"

function TakeBetModal(args) {

    const [selectedBet, setSelectedBet] = useState({});

    const authToken = localStorage.getItem('token');

    const [modal, setModal] = useState(false);

    const handleBetClick = (betId) => {
        axios.get(endpointGet + `${betId}`, {
            headers: {
                Authorization: `Bearer ${authToken}`,
            },
        })
            .then(response => {
                setSelectedBet(response.data);
                toggle();
                console.log(selectedBet)
            })
            .catch(error => {
                console.log(error.response.data)
                // setAlertMessage(error.response.data)
                // setAlert(true)
            });
    }

    const toggle = () => setModal(!modal);

    const [formData, setFormData] = useState({
        user_id: args.user.user_id,
        bet_id: args.bet_id,
        bid: '',
        betValue: '',
    });

    const handleInputChange = (event) => {
        const {name, value} = event.target;
        setFormData({...formData, [name]: value});
    }

    const handleSubmit = (event) => {
        event.preventDefault();
        const authToken = localStorage.getItem('token');
        console.log(formData)
    };

    return (
        <div>
            <Button onClick={() => handleBetClick(args.bet_id)}>
                Parier
            </Button>
            <Modal isOpen={modal} toggle={toggle} backdrop="static" size="lg" {...args}>
                <Form onSubmit={handleSubmit}>
                    <ModalHeader toggle={toggle} className="form-title">
                        <div className="tb-title">
                            <div>
                                <b>#{selectedBet.id}</b> {selectedBet.title}
                            </div>
                            <span>Created by: @{selectedBet.creator_username}#{selectedBet.creator_id}</span>
                        </div>
                    </ModalHeader>
                    <ModalBody>
                        <div className="tb-form-block-line-1">
                            <FormGroup>
                                <Label for="type">Type de pari</Label>
                                <p>{selectedBet.type === 1 ? 'Proportion de lignes où il y aura un problème' : selectedBet.type === 2 ? 'La présence de problèmes sur une ligne' : 'Le nombre total d\'incidents pour cette journée'}</p>
                            </FormGroup>
                            <FormGroup>
                                <Label for="startDay">Date limite pour parier</Label>
                                <p>{new Date(selectedBet.limit_date).toLocaleString()} </p>
                            </FormGroup>
                        </div>
                        <div className="tb-form-block-2">
                            {selectedBet.type === 1 && (
                                <div className="tb-form-type1-block">
                                    <FormGroup>
                                        <Label for="select">RER/Métro ?</Label>
                                        <p>{selectedBet.m_r}</p>
                                    </FormGroup>
                                    <FormGroup>
                                        <Label for="selectQty">%/qté ?</Label>
                                        <p>{selectedBet.num_type === 1 ? "%" : selectedBet.num_type === 2 ? "qté" : "error"}</p>
                                    </FormGroup>
                                    <FormGroup>
                                        <Label for="value">Valeur</Label>
                                        <p>{selectedBet.value}</p>
                                    </FormGroup>
                                </div>
                            )}
                            {selectedBet.type === 2 && (
                                <div className="form-type2-block">
                                    <div>
                                        <FormGroup>
                                            <Label for="select">RER/Métro ?</Label>
                                            <p>{selectedBet.m_r}</p>
                                        </FormGroup>
                                        <FormGroup>
                                            <Label for="selectLine">Ligne</Label>
                                            <p>{selectedBet.line}</p>
                                        </FormGroup>
                                    </div>

                                </div>
                            )}
                            {selectedBet.type === 3 && (
                                <div className="form-type3-block">
                                    <FormGroup>
                                        <Label for="select">RER/Métro ?</Label>
                                        <p>{selectedBet.m_r}</p>
                                    </FormGroup>
                                    <FormGroup>
                                        <Label for="value">Valeur</Label>
                                        <p>{selectedBet.value}</p>
                                    </FormGroup>
                                </div>
                            )}
                        </div>
                        <div className="tb-form-qt-block">
                            <FormGroup>
                                <Label className="tb-qtDefeat" for="qtDefeat">Taux de défaite</Label>
                                <p>{selectedBet.qt_loss}</p>
                            </FormGroup>
                            <FormGroup>
                                <Label className="tb-qtVictory" for="qtVictory">Taux de réussite</Label>
                                <p>{selectedBet.qt_victory}</p>
                            </FormGroup>
                            <FormGroup>
                                <Label for="qtVictory">Result of pari</Label>
                                <div className="tb-form-bet-result">
                                    <div>
                                        <label>
                                            <input type="radio" name="bid" checked={formData.bid === "oui"} value="oui"
                                                   onChange={handleInputChange} required/>
                                            Oui
                                        </label>
                                    </div>
                                    <div>
                                        <label>
                                            <input type="radio" name="bid" checked={formData.bid === "non"} value="non"
                                                   onChange={handleInputChange}/>
                                            Non
                                        </label>
                                    </div>

                                </div>
                            </FormGroup>

                        </div>
                        <hr/>
                        <div className="tb-footer">
                            <FormGroup>
                                <Label for="qtVictory">Your balance: </Label>
                                <p>{args.user.balance}</p>
                            </FormGroup>
                            <FormGroup className="tb-amount">
                                <Label for="betValue">Amount for pari</Label>
                                <Input
                                    type="number"
                                    step="1"
                                    min="200"
                                    max="10000"
                                    name="betValue"
                                    id="betValue"
                                    value={formData.betValue}
                                    onChange={handleInputChange}
                                    required
                                />
                            </FormGroup>
                        </div>
                        <div>
                            The possible win ....
                        </div>
                    </ModalBody>
                    <ModalFooter>

                        <Button type="submit" color="primary">Confirmer</Button>

                        <Button color="secondary" onClick={toggle}>
                            Annuler
                        </Button>
                    </ModalFooter>
                </Form>
            </Modal>
        </div>
    );
}

export default TakeBetModal;
