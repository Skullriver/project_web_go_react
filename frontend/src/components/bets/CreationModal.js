import React, {useEffect, useState} from 'react';
import {Alert, Button, Form, FormGroup, Input, Label, Modal, ModalBody, ModalFooter, ModalHeader} from 'reactstrap';
import '../../styles/createBet.css';
import DatePicker from "react-datepicker";
import {fr} from "date-fns/locale";
import {isSameDay} from "date-fns";
import axios from "axios";

import { API_BASE_URL } from '../../config';
let endpointGet = `${API_BASE_URL}:8080/bet/creationInfo/get`
let endpointPost = `${API_BASE_URL}:8080/bet/create`

function CreationModal(args) {

    const [data, setData] = useState({RER:[], Metro:[]});

    const authToken = localStorage.getItem('token');

    const [modal, setModal] = useState(false);

    useEffect(() => {
        axios.get(endpointGet, {
            headers: {
                Authorization: `Bearer ${authToken}`,
            },
        })
            .then(response => setData(response.data))
            .catch(error => {
                setAlertMessage(error.response.data)
                setAlert(true)
            });
    }, [authToken]);

    let initialStartDay = new Date(new Date().setDate(new Date().getDate() + 1));

    let initialLimitDate = new Date().getHours() < 20 ? new Date(new Date().getTime() + 60 * 60 * 1000)
        : new Date()

    const [formData, setFormData] = useState({
        title: '',
        type: '',
        startDay: initialStartDay,
        limitDate: initialLimitDate,
        qtDefeat: '',
        qtVictory: '',
        m_r: '',
        num_type: '',
        selectLine: '',
        value: '',
    });

    let limitDateMinHour;
    let limitDateMaxHour;

    let dayBefore = new Date(formData.startDay).setDate(new Date(formData.startDay).getDate() - 1);

    if (isSameDay(dayBefore, new Date())) {
        limitDateMinHour = new Date().getTime() + 60 * 60 * 1000;
        limitDateMaxHour = new Date().setHours(21, 0, 0, 0);
    } else {
        limitDateMinHour = new Date(dayBefore).setHours(3, 0, 0, 0);
        limitDateMaxHour = new Date(dayBefore).setHours(21, 0, 0, 0);
    }

    const [hoursData, setHoursData] = useState({
        limitDateMinHour: limitDateMinHour,
        limitDateMaxHour: limitDateMaxHour,
    });

    const toggle = () => setModal(!modal);

    const [responseModal, setResponseModal] = useState(false);
    const [messageModal, setMessageModal] = useState('');
    const toggleResponseModal = () => {setResponseModal(!responseModal);window.location.reload()};

    const [alert, setAlert] = useState(false);
    const [alertMessage, setAlertMessage] = useState('');
    const onDismiss = () => {setAlert(!alert);window.location.reload()}

    const [type1Visible, setType1Visible] = useState(false);
    const [type2Visible, setType2Visible] = useState(false);
    const [type3Visible, setType3Visible] = useState(false);

    const handleInputChange = (event) => {
        const {name, value} = event.target;
        setFormData({...formData, [name]: value});


        if (name === 'type') {
            switch (value) {
                case '1':
                    setType1Visible(true);
                    setType2Visible(false);
                    setType3Visible(false);
                    break;
                case '2':
                    setType1Visible(false);
                    setType2Visible(true);
                    setType3Visible(false);
                    break;
                case '3':
                    setType1Visible(false);
                    setType2Visible(false);
                    setType3Visible(true);
                    break;
                default:
                    setType1Visible(false);
                    setType2Visible(false);
                    setType3Visible(false);
                    break;
            }
        }
    };

    const handleDateChange = (name, date) => {
        setFormData({
            ...formData,
            [name]: new Date(date)
        });
        if (name === "limitDate") {
            if (isSameDay(date, new Date())) {
                setHoursData({...hoursData,
                    ['limitDateMinHour']: new Date().getTime() + 60 * 60 * 1000,
                    ['limitDateMaxHour']: new Date().setHours(21, 0, 0, 0),
                })
            } else {
                setHoursData({...hoursData,
                    ['limitDateMinHour']: new Date(dayBefore).setHours(3, 0, 0, 0),
                    ['limitDateMaxHour']: new Date(dayBefore).setHours(21, 0, 0, 0),
                })
            }
        }


    };

    const handleSubmit = (event) => {
        event.preventDefault();
        const authToken = localStorage.getItem('token');
        axios.post(endpointPost, formData, {
            headers: {
                Authorization: `Bearer ${authToken}`,
            },
        })
            .then(response => {
                setModal(false);
                setFormData({
                    title: '',
                    type: '',
                    startDay: initialStartDay,
                    limitDate: initialLimitDate,
                    qtDefeat: '',
                    qtVictory: '',
                    m_r: '',
                    num_type: '',
                    selectLine: '',
                    value: '',
                });
                setMessageModal(response.data.Message)
                setResponseModal(true);
            })
            .catch(error => {
                setAlertMessage(error.response.data)
                setAlert(true)
            });
    };




    return (
        <div>
            <Button onClick={toggle} color="primary">
                Créer
            </Button>
            <Modal isOpen={modal} toggle={toggle} backdrop="static" size="lg" {...args}>
                <Form onSubmit={handleSubmit}>
                    <ModalHeader toggle={toggle} className="form-title">
                        <Input
                            type="text"
                            name="title"
                            id="title"
                            value={formData.title}
                            onChange={handleInputChange}
                            placeholder="Mon pari..."
                            required
                        />
                    </ModalHeader>
                    <ModalBody>
                        <div className="form-block-1">
                            <div className="form-block-line-1">
                                <FormGroup>
                                    <Label for="type">Type de pari</Label>
                                    <Input
                                        type="select"
                                        name="type"
                                        id="type"
                                        value={formData.type}
                                        onChange={handleInputChange}
                                        required
                                    >
                                        <option value="">Sélectionnez le type</option>
                                        <option value="1">Proportion de lignes où il y aura un problème</option>
                                        <option value="2">La présence de problèmes sur une ligne</option>
                                        <option value="3">Le nombre total d'incidents pour cette journée</option>
                                    </Input>
                                </FormGroup>
                                <FormGroup>
                                    <Label for="startDay">Jour de pari</Label>
                                    <br/>
                                    <DatePicker
                                        className="form-control"
                                        selected={formData.startDay}
                                        onChange={(date) => handleDateChange('startDay', date)}
                                        minDate={new Date().setDate(new Date().getDate() + 1)}
                                        locale={fr}
                                        dateFormat="dd/MM/yyyy"
                                        todayButton="Today"
                                        onKeyDown={(e) => {
                                            e.preventDefault();
                                        }}
                                        required
                                    />
                                </FormGroup>
                            </div>

                            <FormGroup>
                                <Label for="limitDate">Date limite pour parier</Label>
                                <DatePicker
                                    className="form-control"
                                    selected={formData.limitDate}
                                    onChange={(date) => handleDateChange('limitDate', date)}
                                    minDate={new Date()}
                                    maxDate={new Date(formData.startDay).setDate(new Date(formData.startDay).getDate() - 1) }
                                    locale={fr}
                                    dateFormat="dd/MM/yyyy HH:mm"
                                    timeInputLabel="Time:"
                                    timeIntervals={15}
                                    showTimeSelect
                                    timeFormat="HH:mm"
                                    minTime={hoursData.limitDateMinHour} // Add one hour to the start day and set it as minTime
                                    maxTime={hoursData.limitDateMaxHour} // Add five hours to the start day and set it as maxTime
                                    todayButton="Today"
                                    onKeyDown={(e) => {
                                        e.preventDefault();
                                    }}
                                    required
                                />
                            </FormGroup>
                        </div>
                        <div className="form-block-2">
                            {type1Visible && (
                                <div className="form-type1-block">
                                    <div className="form-type1-line">
                                        <FormGroup>
                                            <Label for="select">RER/Métro ?</Label>
                                            <Input
                                                type="select"
                                                name="m_r"
                                                id="select"
                                                value={formData.m_r}
                                                onChange={handleInputChange}
                                                required
                                            >
                                                <option value="">Sélectionnez...</option>
                                                <option value="RER">RER</option>
                                                <option value="Metro">Métro</option>
                                            </Input>
                                        </FormGroup>
                                        <FormGroup>
                                            <Label for="selectQty">%/qté ?</Label>
                                            <Input
                                                type="select"
                                                name="num_type"
                                                id="selectQty"
                                                value={formData.num_type}
                                                onChange={handleInputChange}
                                                required
                                            >
                                                <option value="">Sélectionnez...</option>
                                                <option value="%">%</option>
                                                <option value="qty">qté</option>
                                            </Input>
                                        </FormGroup>
                                    </div>
                                    <FormGroup>
                                        <Label for="value">Valeur</Label>
                                        <Input
                                            type="number"
                                            name="value"
                                            id="value"
                                            min="1"
                                            value={formData.value}
                                            onChange={handleInputChange}
                                            required
                                        />
                                    </FormGroup>
                                </div>
                            )}
                            {type2Visible && (
                                <div className="form-type2-block">
                                    <div>
                                        <FormGroup>
                                            <Label for="select">RER/Métro</Label>
                                            <Input
                                                type="select"
                                                name="m_r"
                                                id="select"
                                                value={formData.m_r}
                                                onChange={handleInputChange}
                                                required
                                            >
                                                <option value="">Sélectionnez...</option>
                                                <option value="RER">RER</option>
                                                <option value="Metro">Métro</option>
                                            </Input>
                                        </FormGroup>
                                        <FormGroup>
                                            <Label for="selectLine">Ligne</Label>
                                            <Input
                                                type="select"
                                                name="selectLine"
                                                id="selectLine"
                                                value={formData.selectLine}
                                                onChange={handleInputChange}
                                                required
                                            >
                                                <option value="">Sélectionnez...</option>
                                                {formData.m_r === "RER" &&
                                                    data.RER.map((line) => (
                                                        <option key={line.name} value={line.line_id}>
                                                            Line {line.name}
                                                        </option>
                                                    ))}
                                                {formData.m_r === "Metro" &&
                                                    data.Metro.map((line) => (
                                                        <option key={line.name} value={line.line_id}>
                                                            Line {line.name}
                                                        </option>
                                                    ))}
                                            </Input>
                                        </FormGroup>
                                    </div>

                                </div>
                            )}
                            {type3Visible && (
                                <div className="form-type3-block">
                                    <FormGroup>
                                        <Label for="select">RER/Métro ?</Label>
                                        <Input
                                            type="select"
                                            name="m_r"
                                            id="select"
                                            value={formData.m_r}
                                            onChange={handleInputChange}
                                            required
                                        >
                                            <option value="">Sélectionnez...</option>
                                            <option value="RER">RER</option>
                                            <option value="Metro">Métro</option>
                                        </Input>
                                    </FormGroup>
                                    <FormGroup>
                                        <Label for="value">Valeur</Label>
                                        <Input
                                            type="number"
                                            name="value"
                                            id="value"
                                            min="1"
                                            value={formData.value}
                                            onChange={handleInputChange}
                                            required
                                        />
                                    </FormGroup>
                                </div>
                            )}

                            <div className="form-qt-block">
                                <FormGroup>
                                    <Label for="qtDefeat">Taux de non réalisation</Label>
                                    <Input
                                        type="number"
                                        step="0.1"
                                        min="1"
                                        max="3"
                                        name="qtDefeat"
                                        id="qtDefeat"
                                        value={formData.qtDefeat}
                                        onChange={handleInputChange}
                                        required
                                    />
                                </FormGroup>
                                <FormGroup>
                                    <Label for="qtVictory">Taux de réalisation</Label>
                                    <Input
                                        type="number"
                                        step="0.1"
                                        min="1"
                                        max="3"
                                        name="qtVictory"
                                        id="qtVictory"
                                        value={formData.qtVictory}
                                        onChange={handleInputChange}
                                        required
                                    />
                                </FormGroup>

                            </div>
                        </div>

                    </ModalBody>
                    <Alert color="danger" isOpen={alert} toggle={onDismiss}>
                        {alertMessage}
                    </Alert>
                    <ModalFooter>
                        <Button type="submit" color="primary">Créer</Button>
                        <Button color="secondary" onClick={toggle}>
                            Annuler
                        </Button>
                    </ModalFooter>
                </Form>
            </Modal>
            <Modal isOpen={responseModal} toggle={toggleResponseModal} backdrop="static" size="sm" {...args}>
                <ModalHeader toggle={toggleResponseModal} className="form-title">
                    Confirmation
                </ModalHeader>
                <ModalBody>
                    {messageModal}
                    <p>You can see your tickets <a href="/user">here</a></p>
                </ModalBody>
            </Modal>

        </div>
    );
}

export default CreationModal;