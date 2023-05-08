import {Component} from "react";
import {format} from "date-fns";
import axios from "axios";
import {Button, Col, Container, Row} from "reactstrap";
import {RxUpdate} from "react-icons/rx";
import CreationModal from "./CreationModal";

class BetsPage extends Component {

    constructor(props) {
        super(props);
        this.state = {

        };
    }


    componentDidMount() {
        this.resetState();
    }

    resetState = () => {

    };

    render() {
        return (
            <div className="main-container">
                <Container fluid style={{marginTop: "15px", padding: "0 50px"}}>
                    <Row>
                        <Col>
                            <div>
                                <CreationModal/>
                            </div>
                        </Col>
                    </Row>
                </Container>
            </div>
        );
    }
}

export default BetsPage;