import React, {useState} from 'react';
import {Button, Form, FormGroup, Input, Label, Modal, ModalBody, ModalFooter, ModalHeader} from 'reactstrap';
import '../../styles/takeBet.css';
import axios from "axios";

import { API_BASE_URL } from '../../config';
let endpointGet = `${API_BASE_URL}:8080/bet/`
let endpointPost = `${API_BASE_URL}:8080/bet/take`

function TakeBetModal(args) {

    const [selectedBet, setSelectedBet] = useState({});

    const [formData, setFormData] = useState({
        bet_id: args.bet_id,
        bid: '',
        bet_value: '',
    });

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
            })
            .catch(error => {
                console.log(error.response.data)
                setAlertMessage(error.response.data)
                setAlert(true)
            });
    }

    const [responseModal, setResponseModal] = useState(false);
    const [messageModal, setMessageModal] = useState('');
    const toggleResponseModal = () => {setResponseModal(!responseModal);window.location.reload()};

    const [alert, setAlert] = useState(false);
    const [alertMessage, setAlertMessage] = useState('');
    const onDismiss = () => {setAlert(!alert); window.location.reload()};

    const toggle = () => setModal(!modal);

    const [winText, setWinText] = useState("Le gain possible est 0");

    const handleInputChange = (event) => {
        const {name, value} = event.target;
        setFormData({...formData, [name]: value});

        if (name === "bid") {

            if (value === "oui") {
                let win = Math.round(selectedBet.qt_victory * formData.bet_value);
                setWinText("Le gain possible est " + win);
            }
            if (value === "non") {
                let win = Math.round(selectedBet.qt_loss * formData.bet_value);
                setWinText("Le gain possible est " + win);
            }

            setFormData({...formData, [name]: value});
        }

        if (name === "bet_value") {

            if( value === ""){
                setWinText("Le gain possible est " + 0);
            }

            if (formData.bid === "oui") {
                let win = Math.round(selectedBet.qt_victory * value);
                setWinText("Le gain possible est " + win);
            }
            if (formData.bid === "non") {
                let win = Math.round(selectedBet.qt_loss * value);
                setWinText("Le gain possible est " + win);
            }

            setFormData({...formData, [name]: value});
        }
    }

    const handleSubmit = (event) => {
        event.preventDefault();


        if(formData.bet_id === '' || formData.bid === '' || formData.bet_value === ''){
            setAlertMessage("Champs de form vides")
            setAlert(true)
        }else{

            if(new Date(selectedBet.limit_date) < new Date()){
                setAlertMessage("Date limite expirée")
                setAlert(true)
            }else{
                sendPost();
            }

        }

    };

    const sendPost = () => {

        const authToken = localStorage.getItem('token');

        axios.post(endpointPost, formData, {
            headers: {
                Authorization: `Bearer ${authToken}`,
            },
        })
            .then(response => {
                setModal(false);
                setFormData({
                    bet_id: args.bet_id,
                    bid: '',
                    bet_value: '',
                });
                setMessageModal(response.data.Message)
                setResponseModal(true);
            })
            .catch(error => {
                console.log(error.response.data)
                setAlertMessage(error.response.data)
                setAlert(true)
            });
    }

    const maxAmount = args.user.balance ? args.user.balance : 10000;

    const options = {
        timeZone: 'UTC'
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
                            <span>Créé par: {selectedBet.creator_username}#{selectedBet.creator_id}</span>
                        </div>
                    </ModalHeader>
                    <ModalBody>
                        <div className="tb-form-block-line-1">
                            <FormGroup>
                                <Label for="type">Type de pari</Label>
                                <p>{selectedBet.type === 1 ? 'Proportion de lignes où il y aura un problème' : selectedBet.type === 2 ? 'La présence de problèmes sur une ligne' : selectedBet.type === 3 ? 'Le nombre total d\'incidents pour cette journée' : 'Error'}</p>
                            </FormGroup>
                            <FormGroup>
                                <Label for="startDay">Jour de pari</Label>
                                <p>{new Date(selectedBet.bet_date).toLocaleDateString("fr", options)} </p>
                            </FormGroup>
                            <FormGroup>
                                <Label for="startDay">Date limite pour parier</Label>
                                <p>{new Date(selectedBet.limit_date).toLocaleString("fr", options)} </p>
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
                                <div className="tb-form-type2-block">
                                    <FormGroup>
                                        <Label for="select">RER/Métro ?</Label>
                                        <p>{selectedBet.m_r}</p>
                                    </FormGroup>
                                    <FormGroup>
                                        <Label for="selectLine">Ligne</Label>
                                        <p>{selectedBet.line}</p>
                                    </FormGroup>

                                </div>
                            )}
                            {selectedBet.type === 3 && (
                                <div className="tb-form-type2-block">
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
                                <Label className="tb-qtDefeat" for="qtDefeat">Taux de non réalisation</Label>
                                <p>{selectedBet.qt_loss}</p>
                            </FormGroup>
                            <FormGroup>
                                <Label className="tb-qtVictory" for="qtVictory">Taux de réalisation</Label>
                                <p>{selectedBet.qt_victory}</p>
                            </FormGroup>
                            <FormGroup>
                                <Label for="qtVictory">Résultat du pari</Label>
                                <div className="tb-form-bet-result">
                                    <div>
                                        <label>
                                            <input type="radio" name="bid" checked={formData.bid === "oui"} value="oui"
                                                   onChange={handleInputChange} required/>
                                            Réalisation
                                        </label>
                                    </div>
                                    <div>
                                        <label>
                                            <input type="radio" name="bid" checked={formData.bid === "non"} value="non"
                                                   onChange={handleInputChange}/>
                                            Non réalisation
                                        </label>
                                    </div>

                                </div>
                            </FormGroup>

                        </div>
                        <hr/>
                        <div className="tb-footer">
                            <FormGroup>
                                <Label for="qtVictory">Votre solde: </Label>
                                <p>{args.user.balance}</p>
                            </FormGroup>
                            <FormGroup className="tb-amount">
                                <Label for="bet_value">Montant pour pari</Label>
                                <Input
                                    type="number"
                                    step="1"
                                    min="200"
                                    max={maxAmount}
                                    name="bet_value"
                                    id="bet_value"
                                    value={formData.bet_value}
                                    onChange={handleInputChange}
                                    required
                                />
                            </FormGroup>
                        </div>
                        <div className="winText">
                            <b>{winText}</b>
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
            <Modal isOpen={alert} backdrop="static" size="sm" {...args}>
                <ModalHeader toggle={onDismiss} className="form-title">
                    Erreur
                </ModalHeader>
                <ModalBody>
                    {alertMessage}
                </ModalBody>
            </Modal>
            <Modal isOpen={responseModal} toggle={toggleResponseModal} backdrop="static" size="sm" {...args}>
                <ModalHeader toggle={toggleResponseModal} className="form-title">
                    Confirmation
                </ModalHeader>
                <ModalBody>
                    {messageModal}
                    <p>Vous pouvez voir vos paris <a href="/user">ici</a></p>
                </ModalBody>
            </Modal>
        </div>

    );
}

export default TakeBetModal;
