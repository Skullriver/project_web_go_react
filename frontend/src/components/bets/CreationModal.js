import React, {useEffect, useState} from 'react';
import {Button, Form, FormGroup, Input, Label, Modal, ModalBody, ModalFooter, ModalHeader, Tooltip} from 'reactstrap';
import '../../styles/createBet.css';
import DatePicker from "react-datepicker";
import {fr} from "date-fns/locale";
import {isSameDay} from "date-fns";
import axios from "axios";
import withAuth from "../auth/CheckAuth";

let endpointGet = "http://localhost:8080/api/betCreationInfo"

function CreationModal(args) {

    const [data, setData] = useState([]);

    useEffect(() => {
        axios.get(endpointGet)
            .then(response => setData(response.data))
            .catch(error => console.error(error));
    }, []);


    const [modal, setModal] = useState(false);

    const limitDateTomorrow = new Date();
    limitDateTomorrow.setDate(limitDateTomorrow.getDate() + 1);
    limitDateTomorrow.setHours(6, 0, 0, 0);

    let initialStartDay = new Date().getHours() < 21 ? new Date() : new Date().setDate(new Date().getDate() + 1);

    let initialLimitDate = new Date().getHours() < 20 ? new Date(new Date().getTime() + 60 * 60 * 1000)
        : limitDateTomorrow

    const [formData, setFormData] = useState({
        title: '',
        type: '',
        startDay: initialStartDay,
        limitDate: initialLimitDate,
        qtDefeat: '',
        qtVictory: '',
        select: '',
        selectLine: '',
        value: '',
    });

    let limitDateMinHour;
    let limitDateMaxHour;
    if (isSameDay(formData.startDay, new Date())) {
        limitDateMinHour = new Date(formData.startDay.getTime() + 60 * 60 * 1000);
        limitDateMaxHour = new Date(formData.startDay).setHours(21, 0, 0, 0);
    } else {
        limitDateMinHour = new Date(formData.startDay).setHours(3, 0, 0, 0);
        limitDateMaxHour = new Date(formData.startDay).setHours(21, 0, 0, 0);
    }

    const toggle = () => setModal(!modal);

    const [type1Visible, setType1Visible] = useState(false);
    const [type2Visible, setType2Visible] = useState(false);
    const [type3Visible, setType3Visible] = useState(false);

    const handleInputChange = (event) => {
        const {name, value} = event.target;
        setFormData({...formData, [name]: value});


        if (name === 'type') {
            switch (value) {
                case 'type1':
                    setType1Visible(true);
                    setType2Visible(false);
                    setType3Visible(false);
                    break;
                case 'type2':
                    setType1Visible(false);
                    setType2Visible(true);
                    setType3Visible(false);
                    break;
                case 'type3':
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
            [name]: date
        });
        if (name === "startDay") {
            let limitDate;
            if (isSameDay(new Date(), date)) {
                limitDate = new Date(date.getTime() + 60 * 60 * 1000);
            } else {
                limitDate = new Date(date).setHours(3, 0, 0, 0);
            }

            setFormData({
                ...formData,
                [name]: date,
                ['limitDate']: limitDate
            });
        }


    };

    const handleSubmit = (event) => {
        event.preventDefault();
        console.log(formData);
    };

    return (
        <div>
            <Button onClick={toggle}>
                Create
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
                                        <option value="type1">Proportion de lignes où il y aura un problème</option>
                                        <option value="type2">La présence de problèmes sur une ligne</option>
                                        <option value="type3">Le nombre total d'incidents pour cette journée</option>
                                    </Input>
                                </FormGroup>
                                <FormGroup>
                                    <Label for="startDay">Jour de pari</Label>
                                    <br/>
                                    <DatePicker
                                        className="form-control"
                                        selected={formData.startDay}
                                        onChange={(date) => handleDateChange('startDay', date)}
                                        minDate={new Date().getHours() < 21 ? new Date() : new Date().setDate(new Date().getDate() + 1)}
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
                                    minDate={formData.startDay}
                                    maxDate={formData.startDay}
                                    locale={fr}
                                    dateFormat="dd/MM/yyyy HH:mm"
                                    timeInputLabel="Time:"
                                    timeIntervals={15}
                                    showTimeSelect
                                    timeFormat="HH:mm"
                                    minTime={limitDateMinHour} // Add one hour to the start day and set it as minTime
                                    maxTime={limitDateMaxHour} // Add five hours to the start day and set it as maxTime
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
                                                name="select"
                                                id="select"
                                                value={formData.select}
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
                                                name="selectQty"
                                                id="selectQty"
                                                value={formData.selectQty}
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
                                                name="select"
                                                id="select"
                                                value={formData.select}
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
                                                {formData.select === "RER" &&
                                                    data.RER.map((line) => (
                                                        <option key={line.name} value={line.name}>
                                                            Line {line.name}
                                                        </option>
                                                    ))}
                                                {formData.select === "Metro" &&
                                                    data.Metro.map((line) => (
                                                        <option key={line.name} value={line.name}>
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
                                            name="select"
                                            id="select"
                                            value={formData.select}
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
                                    <Label for="qtDefeat">Taux de défaite</Label>
                                    <Input
                                        type="number"
                                        min="0.1"
                                        name="qtDefeat"
                                        id="qtDefeat"
                                        value={formData.qtDefeat}
                                        onChange={handleInputChange}
                                        required
                                    />
                                </FormGroup>
                                <FormGroup>
                                    <Label for="qtVictory">Taux de réussite</Label>
                                    <Input
                                        type="number"
                                        min="0.1"
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
                    <ModalFooter>
                        <Button type="submit" color="primary">Créer</Button>
                        {/*<Button color="primary" onClick={toggle}>*/}
                        {/*    Do Something*/}
                        {/*</Button>{' '}*/}
                        <Button color="secondary" onClick={toggle}>
                            Annuler
                        </Button>
                    </ModalFooter>
                </Form>
            </Modal>
        </div>
    );
}

export default CreationModal;