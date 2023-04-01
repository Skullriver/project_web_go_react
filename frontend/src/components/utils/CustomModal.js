import React, {useState} from 'react';
import {Modal, ModalBody, ModalHeader} from "reactstrap";

function CustomModal(args) {

    const [modal, setModal] = useState(false);
    const toggle = (e) => {
        e.preventDefault()
        setModal(!modal);
    }
    return (
        <div>
            <a onClick={toggle} href="#">
                Details
            </a>
            <Modal isOpen={modal} centered toggle={toggle} >
                <ModalHeader toggle={toggle}>Message</ModalHeader>
                <ModalBody>
                    <div dangerouslySetInnerHTML={{__html: args.message}}/>
                </ModalBody>
            </Modal>
        </div>
    );
}

export default CustomModal